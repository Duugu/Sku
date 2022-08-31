local VANILLA = string.byte(GetBuildInfo(), 1) == 49

SkuDB.DefaultWaypoints = {
   ["enUS"] = {
      "Innkeepers", -- [1]
      "Taxi", -- [2]
      "Postbox", -- [3]
      "Zones", -- [4]
      ["Innkeepers"] = {
         "horde", -- [1]
         "alliance", -- [2]
         ["horde"] = {
            "s;h;the barrens;innkeeper wiley", -- [1]
            "s;h;stranglethorn vale;Innkeeper Skindle", -- [2]
            "s;h;tanaris;Innkeeper Fizzgrimble", -- [3]
            "s;h;Winterspring;innkeeper vizzie", -- [4]
            "s;h;silithus;calandrath", -- [5]
            "s;h;badlands;innkeeper shul'kar", -- [6]
            "s;h;swamp of sorrows;innkeeper karakul", -- [7]
            "s;h;durotar;innkeeper grosk", -- [8]
            "s;h;the barrens;Innkeeper Boorand Plainswind", -- [9]
            "s;h;the barrens;innkeeper byula", -- [10]
            "s;h;stranglethorn vale;innkeeper thulbek", -- [11]
            "s;h;arathi highlands;innkeeper adegwa", -- [12]
            "s;h;the hinterlands;lard", -- [13]
            "s;h;tirisfal glades;innkeeper renee", -- [14]
            "s;h;silverpine forest;innkeeper bates", -- [15]
            "s;h;mulgore;innkeeper kauth", -- [16]
            "s;h;Hillsbrad Foothills;innkeeper shay", -- [17]
            "s;h;Ashenvale;innkeeper kaylisk", -- [18]
            "s;h;feralas;innkeeper greul", -- [19]
            "s;h;thousand needles;innkeeper abeqwa", -- [20]
            "s;h;desolace;innkeeper sikewa", -- [21]
            "s;h;stonetalon mountains;innkeeper jayka", -- [22]
            "s;h;Undercity;innkeeper norman", -- [23]
            "s;h;orgrimmar;innkeeper gryshka", -- [24]
            "s;h;Thunder Bluff;innkeeper pala", -- [25]
            ["s;h;the barrens;innkeeper byula"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 17,
               ["worldY"] = -1995.856689453125,
               ["worldX"] = -2376.389892578125,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;Winterspring;innkeeper vizzie"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 618,
               ["worldY"] = -4673.2265625,
               ["worldX"] = 6695.3798828125,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;the barrens;innkeeper wiley"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 17,
               ["worldY"] = -3664.817138671875,
               ["worldX"] = -1050.138305664063,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;Undercity;innkeeper norman"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 1497,
               ["worldY"] = 223.3119964599609,
               ["worldX"] = 1635.409912109375,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;mulgore;innkeeper kauth"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 215,
               ["worldY"] = -347.185791015625,
               ["worldX"] = -2365.2490234375,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;tanaris;Innkeeper Fizzgrimble"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 440,
               ["worldY"] = -3841.939697265625,
               ["worldX"] = -7158.8603515625,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;silithus;calandrath"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 1377,
               ["worldY"] = 729.998046875,
               ["worldX"] = -6867.98779296875,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;Thunder Bluff;innkeeper pala"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 1638,
               ["worldY"] = 38.52479553222656,
               ["worldX"] = -1300.273681640625,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;arathi highlands;innkeeper adegwa"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 45,
               ["worldY"] = -3524.906494140625,
               ["worldX"] = -912.3733520507812,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;tirisfal glades;innkeeper renee"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 85,
               ["worldY"] = 244.8126831054688,
               ["worldX"] = 2269.49365234375,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;feralas;innkeeper greul"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 357,
               ["worldY"] = 243.0665283203125,
               ["worldX"] = -4460.00634765625,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;stonetalon mountains;innkeeper jayka"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 406,
               ["worldY"] = 927.7150268554688,
               ["worldX"] = 893.5585327148438,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;thousand needles;innkeeper abeqwa"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 400,
               ["worldY"] = -2460.4130859375,
               ["worldX"] = -5477.919921875,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;desolace;innkeeper sikewa"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 405,
               ["worldY"] = 3150.286865234375,
               ["worldX"] = -1592.795532226563,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;orgrimmar;innkeeper gryshka"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 1637,
               ["worldY"] = -4439.41015625,
               ["worldX"] = 1633.958740234375,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;swamp of sorrows;innkeeper karakul"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 8,
               ["worldY"] = -3258.77392578125,
               ["worldX"] = -10487.259765625,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;Ashenvale;innkeeper kaylisk"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 331,
               ["worldY"] = -2566.756591796875,
               ["worldX"] = 2341.68212890625,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;stranglethorn vale;innkeeper thulbek"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 33,
               ["worldY"] = 211.3775634765625,
               ["worldX"] = -12434.365234375,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;Hillsbrad Foothills;innkeeper shay"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 267,
               ["worldY"] = -942.2933349609375,
               ["worldX"] = -5.97332763671875,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;stranglethorn vale;Innkeeper Skindle"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 33,
               ["worldY"] = 495.3433837890625,
               ["worldX"] = -14457.646484375,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;the barrens;Innkeeper Boorand Plainswind"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 17,
               ["worldY"] = -2645.403564453125,
               ["worldX"] = -406.9432373046875,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;durotar;innkeeper grosk"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 14,
               ["worldY"] = -4686.0908203125,
               ["worldX"] = 340.5234375,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;badlands;innkeeper shul'kar"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 3,
               ["worldY"] = -2149.065185546875,
               ["worldX"] = -6649.9287109375,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;the hinterlands;lard"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 47,
               ["worldY"] = -4583.39013671875,
               ["worldX"] = -622.086669921875,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;silverpine forest;innkeeper bates"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 130,
               ["worldY"] = 1636.439819335938,
               ["worldX"] = 510.8266296386719,
               ["createdBy"] = "SkuNav",
            },
         },
         ["alliance"] = {
            "s;a;dun morogh;innkeeper belm", -- [1]
            "s;a;duskwood;innkeeper trelayne", -- [2]
            "s;a;wetlands;innkeeper helbrek", -- [3]
            "s;a;elwynn forest;innkeeper farley", -- [4]
            "s;a;Dustwallow Marsh;innkeeper janene", -- [5]
            "s;a;loch modan;Innkeeper Hearthstove", -- [6]
            "s;a;westfall;innkeeper heather", -- [7]
            "s;a;redridge mountains;innkeeper brianna", -- [8]
            "s;a;the hinterlands;innkeeper thulfram", -- [9]
            "s;a;teldrassil;innkeeper keldamyr", -- [10]
            "s;a;darkshore;innkeeper shaussiy", -- [11]
            "s;a;Hillsbrad Foothills;innkeeper anderson", -- [12]
            "s;a;Ashenvale;innkeeper kimlya", -- [13]
            "s;a;feralas;innkeeper shyria", -- [14]
            "s;a;desolace;innkeeper lyshaerya", -- [15]
            "s;a;stonetalon mountains;innkeeper faralia", -- [16]
            "s;a;Stormwind;innkeeper allison", -- [17]
            "s;a;Ironforge;Innkeeper Firebrew", -- [18]
            "s;a;darnassus;innkeeper saelienne", -- [19]
            "s;a;the barrens;innkeeper wiley", -- [20]
            "s;a;stranglethorn vale;Innkeeper Skindle", -- [21]
            "s;a;tanaris;Innkeeper Fizzgrimble", -- [22]
            "s;a;Winterspring;innkeeper vizzie", -- [23]
            "s;a;silithus;calandrath", -- [24]
            ["s;a;dun morogh;innkeeper belm"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 1,
               ["worldY"] = -531.381591796875,
               ["worldX"] = -5601.490234375,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;Ashenvale;innkeeper kimlya"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 331,
               ["worldY"] = -433.0899658203125,
               ["worldX"] = 2781.022705078125,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;loch modan;Innkeeper Hearthstove"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 38,
               ["worldY"] = -2973.78564453125,
               ["worldX"] = -5377.8583984375,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;feralas;innkeeper shyria"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 357,
               ["worldY"] = 3289.25146484375,
               ["worldX"] = -4381.703125,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;duskwood;innkeeper trelayne"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 10,
               ["worldY"] = -1161.156616210938,
               ["worldX"] = -10516.0458984375,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;the hinterlands;innkeeper thulfram"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 47,
               ["worldY"] = -2119.77490234375,
               ["worldX"] = 399.7033996582031,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;darkshore;innkeeper shaussiy"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 148,
               ["worldY"] = 515.5465087890625,
               ["worldX"] = 6406.3232421875,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;stranglethorn vale;Innkeeper Skindle"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 33,
               ["worldY"] = 495.3433837890625,
               ["worldX"] = -14457.646484375,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;darnassus;innkeeper saelienne"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 1657,
               ["worldY"] = 2224.83447265625,
               ["worldX"] = 10127.8701171875,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;teldrassil;innkeeper keldamyr"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 141,
               ["worldY"] = 982.5982666015625,
               ["worldX"] = 9802.126953125,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;elwynn forest;innkeeper farley"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 12,
               ["worldY"] = 16.23291015625,
               ["worldX"] = -9462.578125,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;wetlands;innkeeper helbrek"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 11,
               ["worldY"] = -832.0728759765625,
               ["worldX"] = -3827.850830078125,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;silithus;calandrath"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 1377,
               ["worldY"] = 729.998046875,
               ["worldX"] = -6867.98779296875,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;Winterspring;innkeeper vizzie"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 618,
               ["worldY"] = -4673.2265625,
               ["worldX"] = 6695.3798828125,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;tanaris;Innkeeper Fizzgrimble"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 440,
               ["worldY"] = -3841.939697265625,
               ["worldX"] = -7158.8603515625,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;the barrens;innkeeper wiley"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 17,
               ["worldY"] = -3664.817138671875,
               ["worldX"] = -1050.138305664063,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;Ironforge;Innkeeper Firebrew"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 1537,
               ["worldY"] = -857.08984375,
               ["worldX"] = -4840.693359375,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;Hillsbrad Foothills;innkeeper anderson"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 267,
               ["worldY"] = -570.7732543945312,
               ["worldX"] = -857.1732177734375,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;stonetalon mountains;innkeeper faralia"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 406,
               ["worldY"] = 1498.088134765625,
               ["worldX"] = 2729.7578125,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;Stormwind;innkeeper allison"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 1519,
               ["worldY"] = 673.6161499023438,
               ["worldX"] = -8867.755859375,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;Dustwallow Marsh;innkeeper janene"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 15,
               ["worldY"] = -4470.97509765625,
               ["worldX"] = -3616.033203125,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;westfall;innkeeper heather"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 40,
               ["worldY"] = 1166.566650390625,
               ["worldX"] = -10653.466796875,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;desolace;innkeeper lyshaerya"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 405,
               ["worldY"] = 1253.944458007813,
               ["worldX"] = 255.7197570800781,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;redridge mountains;innkeeper brianna"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 44,
               ["worldY"] = -2157.17529296875,
               ["worldX"] = -9223.9560546875,
               ["createdBy"] = "SkuNav",
            },
         },
      },
      ["Postbox"] = {
			"alliance", -- [1]
			"horde", -- [2]
			"unknown", -- [3]
			["horde"] = {
				"s;h;Mailbox;Durotar", -- [1]
				"s;h;Mailbox;Mulgore", -- [2]
				"s;h;Mailbox;Badlands", -- [3]
				"s;h;Mailbox;1;Orgrimmar", -- [4]
				"s;h;Mailbox;2;Orgrimmar", -- [5]
				"s;h;Mailbox;1;Silverpine Forest", -- [6]
				"s;h;Mailbox;2;Silverpine Forest", -- [7]
				"s;h;Mailbox;Thunder Bluff", -- [8]
				"s;h;Mailbox;Tirisfal Glades", -- [9]
				"s;h;Mailbox;Undercity", -- [10]
				["s;h;Mailbox;2;Silverpine Forest"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 130,
					["worldY"] = 1627.199829101563,
					["worldX"] = 507.4665832519531,
					["createdBy"] = "SkuNav",
				},
				["s;h;Mailbox;Undercity"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 1497,
					["worldY"] = 221.7769775390625,
					["worldX"] = 1632.145385742188,
					["createdBy"] = "SkuNav",
				},
				["s;h;Mailbox;Thunder Bluff"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 1,
					["areaId"] = 1638,
					["worldY"] = 46.97917175292969,
					["worldX"] = -1261.933227539063,
					["createdBy"] = "SkuNav",
				},
				["s;h;Mailbox;2;Orgrimmar"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 1,
					["areaId"] = 1637,
					["worldY"] = -4551.61865234375,
					["worldX"] = 1895.033569335938,
					["createdBy"] = "SkuNav",
				},
				["s;h;Mailbox;Badlands"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 3,
					["worldY"] = -2176.17919921875,
					["worldX"] = -6673.974609375,
					["createdBy"] = "SkuNav",
				},
				["s;h;Mailbox;1;Orgrimmar"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 1,
					["areaId"] = 1637,
					["worldY"] = -4387.513671875,
					["worldX"] = 1612.53759765625,
					["createdBy"] = "SkuNav",
				},
				["s;h;Mailbox;Durotar"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 1,
					["areaId"] = 14,
					["worldY"] = -4706.71240234375,
					["worldX"] = 324.3082275390625,
					["createdBy"] = "SkuNav",
				},
				["s;h;Mailbox;Tirisfal Glades"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 85,
					["worldY"] = 258.8207397460938,
					["worldX"] = 2237.8623046875,
					["createdBy"] = "SkuNav",
				},
				["s;h;Mailbox;1;Silverpine Forest"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 130,
					["worldY"] = 1517.999755859375,
					["worldX"] = 490.666748046875,
					["createdBy"] = "SkuNav",
				},
				["s;h;Mailbox;Mulgore"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 1,
					["areaId"] = 215,
					["worldY"] = -366.7083740234375,
					["worldX"] = -2338.19140625,
					["createdBy"] = "SkuNav",
				},
			},
			["alliance"] = {
				"s;A;Mailbox;1;Darnassus", -- [1]
				"s;A;Mailbox;2;Darnassus", -- [2]
				"s;A;Mailbox;Dun Morogh", -- [3]
				"s;A;Mailbox;1;Ironforge", -- [4]
				"s;A;Mailbox;2;Ironforge", -- [5]
				"s;A;Mailbox;3;Ironforge", -- [6]
				"s;A;Mailbox;4;Ironforge", -- [7]
				"s;A;Mailbox;Loch Modan", -- [8]
				"s;A;Mailbox;1;Stormwind", -- [9]
				"s;A;Mailbox;2;Stormwind", -- [10]
				"s;A;Mailbox;3;Stormwind", -- [11]
				"s;A;Mailbox;4;Stormwind", -- [12]
				"s;A;Mailbox;Elwynn Forest", -- [13]
				"s;A;Mailbox;Westfall", -- [14]
				["s;A;Mailbox;2;Stormwind"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 1519,
					["worldY"] = 845.95166015625,
					["worldX"] = -9036.26953125,
					["createdBy"] = "SkuNav",
				},
				["s;A;Mailbox;1;Ironforge"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 1537,
					["worldY"] = -880.4132690429688,
					["worldX"] = -4848.34375,
					["createdBy"] = "SkuNav",
				},
				["s;A;Mailbox;1;Stormwind"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 1519,
					["worldY"] = 1083.887573242188,
					["worldX"] = -8793.3583984375,
					["createdBy"] = "SkuNav",
				},
				["s;A;Mailbox;2;Darnassus"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 1,
					["areaId"] = 1657,
					["worldY"] = 2227.37451171875,
					["worldX"] = 10122.08203125,
					["createdBy"] = "SkuNav",
				},
				["s;A;Mailbox;1;Darnassus"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 1,
					["areaId"] = 1657,
					["worldY"] = 2500.212646484375,
					["worldX"] = 9941.205078125,
					["createdBy"] = "SkuNav",
				},
				["s;A;Mailbox;4;Ironforge"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 1537,
					["worldY"] = -1282.841430664063,
					["worldX"] = -4824.6015625,
					["createdBy"] = "SkuNav",
				},
				["s;A;Mailbox;Westfall"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 40,
					["worldY"] = 1161.666748046875,
					["worldX"] = -10648.3330078125,
					["createdBy"] = "SkuNav",
				},
				["s;A;Mailbox;Elwynn Forest"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 12,
					["worldY"] = 46.42913818359375,
					["worldX"] = -9453.3203125,
					["createdBy"] = "SkuNav",
				},
				["s;A;Mailbox;Dun Morogh"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 1,
					["worldY"] = -512.6666870117188,
					["worldX"] = -5597.5498046875,
					["createdBy"] = "SkuNav",
				},
				["s;A;Mailbox;Loch Modan"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 38,
					["worldY"] = -2953.64990234375,
					["worldX"] = -5364.98095703125,
					["createdBy"] = "SkuNav",
				},
				["s;A;Mailbox;3;Stormwind"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 1519,
					["worldY"] = 648.3438110351562,
					["worldX"] = -8875.822265625,
					["createdBy"] = "SkuNav",
				},
				["s;A;Mailbox;2;Ironforge"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 1537,
					["worldY"] = -973.70703125,
					["worldX"] = -4911.65625,
					["createdBy"] = "SkuNav",
				},
				["s;A;Mailbox;3;Ironforge"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 1537,
					["worldY"] = -1274.14453125,
					["worldX"] = -4950.69921875,
					["createdBy"] = "SkuNav",
				},
				["s;A;Mailbox;4;Stormwind"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 1519,
					["worldY"] = 427.8834533691406,
					["worldX"] = -8640.0810546875,
					["createdBy"] = "SkuNav",
				},
			},
			["unknown"] = {
				"s;u;Mailbox;Arathi Highlands", -- [1]
				"s;u;Mailbox;1;Ashenvale", -- [2]
				"s;u;Mailbox;2;Ashenvale", -- [3]
				"s;u;Mailbox;1;The Barrens", -- [4]
				"s;u;Mailbox;2;The Barrens", -- [5]
				"s;u;Mailbox;3;The Barrens", -- [6]
				"s;u;Mailbox;Duskwood", -- [7]
				"s;u;Mailbox;1;Desolace", -- [8]
				"s;u;Mailbox;2;Desolace", -- [9]
				"s;u;Mailbox;Darkshore", -- [10]
				"s;u;Mailbox;1;Feralas", -- [11]
				"s;u;Mailbox;2;Feralas", -- [12]
				"s;u;Mailbox;1;The Hinterlands", -- [13]
				"s;u;Mailbox;2;The Hinterlands", -- [14]
				"s;u;Mailbox;Dustwallow Marsh", -- [15]
				"s;u;Mailbox;1;Eastern Plaguelands", -- [16]
				"s;u;Mailbox;2;Eastern Plaguelands", -- [17]
				"s;u;Mailbox;1;Redridge Mountains", -- [18]
				"s;u;Mailbox;2;Redridge Mountains", -- [19]
				"s;u;Mailbox;1;Stranglethorn Vale", -- [20]
				"s;u;Mailbox;2;Stranglethorn Vale", -- [21]
				"s;u;Mailbox;3;Stranglethorn Vale", -- [22]
				"s;u;Mailbox;Silithus", -- [23]
				"s;u;Mailbox;1;Stonetalon Mountains", -- [24]
				"s;u;Mailbox;2;Stonetalon Mountains", -- [25]
				"s;u;Mailbox;Swamp of Sorrows", -- [26]
				"s;u;Mailbox;Wetlands", -- [27]
				"s;u;Mailbox;Tanaris", -- [28]
				"s;u;Mailbox;Thousand Needles", -- [29]
				"s;u;Mailbox;Teldrassil", -- [30]
				"s;u;Mailbox;Felwood", -- [31]
				"s;u;Mailbox;Blasted Lands", -- [32]
				"s;u;Mailbox;1;Hillsbrad Foothills", -- [33]
				"s;u;Mailbox;2;Hillsbrad Foothills", -- [34]
				"s;u;Mailbox;Winterspring", -- [35]
				["s;u;Mailbox;Duskwood"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 10,
					["worldY"] = -1159.2666015625,
					["worldX"] = -10548.265625,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;1;Eastern Plaguelands"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 139,
					["worldY"] = -5088.54150390625,
					["worldX"] = 2457.75,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;1;The Hinterlands"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 47,
					["worldY"] = -2117.849853515625,
					["worldX"] = 293.6999816894531,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;1;Ashenvale"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 1,
					["areaId"] = 331,
					["worldY"] = -393.300048828125,
					["worldX"] = 2739.51025390625,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;Winterspring"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 1,
					["areaId"] = 618,
					["worldY"] = -4668.96630859375,
					["worldX"] = 6706.26611328125,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;1;Desolace"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 1,
					["areaId"] = 405,
					["worldY"] = 3118.3662109375,
					["worldX"] = -1610.4833984375,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;1;Hillsbrad Foothills"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 267,
					["worldY"] = -546.13330078125,
					["worldX"] = -850.1333618164062,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;2;The Hinterlands"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 47,
					["worldY"] = -4612.64990234375,
					["worldX"] = -599.5,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;2;Desolace"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 1,
					["areaId"] = 405,
					["worldY"] = 1293.058227539063,
					["worldX"] = 245.2270660400391,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;Arathi Highlands"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 45,
					["worldY"] = -3523.46630859375,
					["worldX"] = -927.7333374023438,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;Swamp of Sorrows"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 8,
					["worldY"] = -3264.279052734375,
					["worldX"] = -10461.875,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;Darkshore"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 1,
					["areaId"] = 148,
					["worldY"] = 498.5164794921875,
					["worldX"] = 6420.7333984375,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;1;Redridge Mountains"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 44,
					["worldY"] = -2243.79150390625,
					["worldX"] = -9270,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;Tanaris"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 1,
					["areaId"] = 440,
					["worldY"] = -3827.44970703125,
					["worldX"] = -7153.7998046875,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;3;Stranglethorn Vale"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 33,
					["worldY"] = 480.0283203125,
					["worldX"] = -14461.8994140625,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;2;Eastern Plaguelands"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 139,
					["worldY"] = -5316.9208984375,
					["worldX"] = 2292.5498046875,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;2;Hillsbrad Foothills"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 267,
					["worldY"] = -930.13330078125,
					["worldX"] = -22.39999389648438,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;1;Stranglethorn Vale"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 33,
					["worldY"] = 517.0396728515625,
					["worldX"] = -14418.9326171875,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;Felwood"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 1,
					["areaId"] = 361,
					["worldY"] = -360.483154296875,
					["worldX"] = 5103.5830078125,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;2;Redridge Mountains"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 44,
					["worldY"] = -2143.93310546875,
					["worldX"] = -9249.728515625,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;Wetlands"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 11,
					["worldY"] = -836.2083740234375,
					["worldX"] = -3793.397705078125,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;2;Feralas"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 1,
					["areaId"] = 357,
					["worldY"] = 236.11669921875,
					["worldX"] = -4405.3330078125,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;Teldrassil"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 1,
					["areaId"] = 141,
					["worldY"] = 958.1583862304688,
					["worldX"] = 9849.30078125,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;2;Stranglethorn Vale"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 33,
					["worldY"] = 153.308349609375,
					["worldX"] = -12389.6953125,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;2;Ashenvale"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 1,
					["areaId"] = 331,
					["worldY"] = -2544.2666015625,
					["worldX"] = 2332.07275390625,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;Silithus"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 1,
					["areaId"] = 1377,
					["worldY"] = 736.6162109375,
					["worldX"] = -6838.71875,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;Thousand Needles"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 1,
					["areaId"] = 400,
					["worldY"] = -2452.93310546875,
					["worldX"] = -5462.66650390625,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;Blasted Lands"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 0,
					["areaId"] = 4,
					["worldY"] = -3389.016357421875,
					["worldX"] = -10997.69921875,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;2;Stonetalon Mountains"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 1,
					["areaId"] = 406,
					["worldY"] = 901.8333129882812,
					["worldX"] = 927.0978393554688,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;1;Stonetalon Mountains"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 1,
					["areaId"] = 406,
					["worldY"] = 1487.833251953125,
					["worldX"] = 2678.960205078125,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;1;The Barrens"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 1,
					["areaId"] = 17,
					["worldY"] = -1947.216796875,
					["worldX"] = -2353.4189453125,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;2;The Barrens"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 1,
					["areaId"] = 17,
					["worldY"] = -2646.41650390625,
					["worldX"] = -441.4000244140625,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;1;Feralas"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 1,
					["areaId"] = 357,
					["worldY"] = 3273.2666015625,
					["worldX"] = -4396.06640625,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;3;The Barrens"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 1,
					["areaId"] = 17,
					["worldY"] = -3680.0166015625,
					["worldX"] = -1035.949951171875,
					["createdBy"] = "SkuNav",
				},
				["s;u;Mailbox;Dustwallow Marsh"] = {
					["createdAt"] = "Sun Apr 25 23:32:35 2021",
					["contintentId"] = 1,
					["areaId"] = 15,
					["worldY"] = -4434.75,
					["worldX"] = -3618.8330078125,
					["createdBy"] = "SkuNav",
				},

         },




      },
      ["Taxi"] = {
         "horde", -- [1]
         "alliance", -- [2]
         ["horde"] = {
            "s;h;flight master;arathi highlands;urda", -- [1]
            "s;h;flight master;Ashenvale;andruk", -- [2]
            "s;h;flight master;Ashenvale;vhulgra", -- [3]
            "s;h;flight master;azshara;kroum", -- [4]
            "s;h;flight master;the barrens;bragok", -- [5]
            "s;h;flight master;the barrens;devrak", -- [6]
            "s;h;flight master;the barrens;Omusa Thunderhorn", -- [7]
            "s;h;flight master;burning steppes;vahgruk", -- [8]
            "s;h;flight master;desolace;thalon", -- [9]
            "s;h;flight master;feralas;shyn", -- [10]
            "s;h;flight master;the hinterlands;gorkas", -- [11]
            "s;h;flight master;Dustwallow Marsh;shardi", -- [12]
            "s;h;flight master;Moonglade;faustron", -- [13]
            "s;h;flight master;badlands;gorrik", -- [14]
            "s;h;flight master;orgrimmar;doras", -- [15]
            "s;h;flight master;eastern plaguelands;georgia", -- [16]
            "s;h;flight master;stranglethorn vale;gringer", -- [17]
            "s;h;flight master;stranglethorn vale;thysta", -- [18]
            "s;h;flight master;searing gorge;grisha", -- [19]
            "s;h;flight master;silverpine forest;karos razok", -- [20]
            "s;h;flight master;silithus;runk windtamer", -- [21]
            "s;h;flight master;stonetalon mountains;tharm", -- [22]
            "s;h;flight master;swamp of sorrows;breyk", -- [23]
            "s;h;flight master;tanaris;Bulkrek Ragefist", -- [24]
            "s;h;flight master;thousand needles;nyse", -- [25]
            "s;h;flight master;felwood;brakkar", -- [26]
            "s;h;flight master;Thunder Bluff;valley", -- [27]
            "s;h;flight master;Undercity;michael garrett", -- [28]
            "s;h;flight master;Un'Goro Crater;gryfe", -- [29]
            "s;h;flight master;Hillsbrad Foothills;zarise", -- [30]
            "s;h;flight master;Winterspring;yugrek", -- [31]
            ["s;h;flight master;burning steppes;vahgruk"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 46,
               ["worldY"] = -2190.836181640625,
               ["worldX"] = -7504.0439453125,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;flight master;tanaris;Bulkrek Ragefist"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 440,
               ["worldY"] = -3779.149658203125,
               ["worldX"] = -7045.240234375,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;flight master;desolace;thalon"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 405,
               ["worldY"] = 3262.233154296875,
               ["worldX"] = -1770.272216796875,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;flight master;the barrens;bragok"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 17,
               ["worldY"] = -3769.18994140625,
               ["worldX"] = -898.1226196289062,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;flight master;Moonglade;faustron"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 493,
               ["worldY"] = -2121.994140625,
               ["worldX"] = 7466.14990234375,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;flight master;Hillsbrad Foothills;zarise"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 267,
               ["worldY"] = -857.8133544921875,
               ["worldX"] = 2.773345947265625,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;flight master;Un'Goro Crater;gryfe"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 490,
               ["worldY"] = -1140.176635742188,
               ["worldX"] = -6110.47265625,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;flight master;stranglethorn vale;thysta"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 33,
               ["worldY"] = 144.37451171875,
               ["worldX"] = -12417.34765625,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;flight master;Undercity;michael garrett"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 1497,
               ["worldY"] = 266.3879089355469,
               ["worldX"] = 1567.11083984375,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;flight master;Ashenvale;andruk"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 331,
               ["worldY"] = 994.159912109375,
               ["worldX"] = 3373.72900390625,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;flight master;azshara;kroum"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 16,
               ["worldY"] = -4390.63818359375,
               ["worldX"] = 3663.890625,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;flight master;eastern plaguelands;georgia"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 139,
               ["worldY"] = -5290.59912109375,
               ["worldX"] = 2328.42919921875,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;flight master;arathi highlands;urda"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 45,
               ["worldY"] = -3496.826416015625,
               ["worldX"] = -917.6532592773438,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;flight master;Thunder Bluff;valley"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 1638,
               ["worldY"] = 26.1041259765625,
               ["worldX"] = -1196.733642578125,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;flight master;Ashenvale;vhulgra"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 331,
               ["worldY"] = -2520.046630859375,
               ["worldX"] = 2305.551025390625,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;flight master;felwood;brakkar"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 361,
               ["worldY"] = -338.6331787109375,
               ["worldX"] = 5064.8662109375,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;flight master;thousand needles;nyse"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 400,
               ["worldY"] = -2419.4931640625,
               ["worldX"] = -5407.2265625,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;flight master;stranglethorn vale;gringer"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 33,
               ["worldY"] = 506.19140625,
               ["worldX"] = -14448.7119140625,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;flight master;Winterspring;yugrek"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 618,
               ["worldY"] = -4610.03662109375,
               ["worldX"] = 6815.1328125,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;flight master;stonetalon mountains;tharm"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 406,
               ["worldY"] = 1042.473266601563,
               ["worldX"] = 968.1265869140625,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;flight master;silithus;runk windtamer"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 1377,
               ["worldY"] = 841.8131103515625,
               ["worldX"] = -6810.1474609375,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;flight master;silverpine forest;karos razok"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 130,
               ["worldY"] = 1533.959838867188,
               ["worldX"] = 473.8666687011719,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;flight master;searing gorge;grisha"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 51,
               ["worldY"] = -1100.284057617188,
               ["worldX"] = -6559.19140625,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;flight master;swamp of sorrows;breyk"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 8,
               ["worldY"] = -3279.647216796875,
               ["worldX"] = -10459.275390625,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;flight master;the barrens;Omusa Thunderhorn"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 17,
               ["worldY"] = -1881.349975585938,
               ["worldX"] = -2383.82177734375,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;flight master;orgrimmar;doras"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 1637,
               ["worldY"] = -4313.4560546875,
               ["worldX"] = 1676.239501953125,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;flight master;the hinterlands;gorkas"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 47,
               ["worldY"] = -4720.44970703125,
               ["worldX"] = -631.8399658203125,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;flight master;the barrens;devrak"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 17,
               ["worldY"] = -2595.75,
               ["worldX"] = -437.346435546875,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;flight master;Dustwallow Marsh;shardi"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 15,
               ["worldY"] = -2841.900146484375,
               ["worldX"] = -3149.13330078125,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;flight master;feralas;shyn"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 357,
               ["worldY"] = 197.8919677734375,
               ["worldX"] = -4422.0126953125,
               ["createdBy"] = "SkuNav",
            },
            ["s;h;flight master;badlands;gorrik"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 3,
               ["worldY"] = -2178.417724609375,
               ["worldX"] = -6632.1845703125,
               ["createdBy"] = "SkuNav",
            },
         },
         ["alliance"] = {
            "s;a;flight master;arathi highlands;Cedrik Prose", -- [1]
            "s;a;flight master;Ashenvale;daelyshia", -- [2]
            "s;a;flight master;azshara;jarrodenus", -- [3]
            "s;a;flight master;the barrens;bragok", -- [4]
            "s;a;flight master;burning steppes;Borgus Stoutarm", -- [5]
            "s;a;flight master;duskwood;felicia maline", -- [6]
            "s;a;flight master;desolace;Baritanas Skyriver", -- [7]
            "s;a;flight master;darkshore;Caylais Moonfeather", -- [8]
            "s;a;flight master;feralas;Fyldren Moonfeather", -- [9]
            "s;a;flight master;feralas;thyssiana", -- [10]
            "s;a;flight master;the hinterlands;Guthrum Thunderfist", -- [11]
            "s;a;flight master;Ironforge;gryth thurden", -- [12]
            "s;a;flight master;loch modan;thorgrum borrelson", -- [13]
            "s;a;flight master;Dustwallow Marsh;baldruc", -- [14]
            "s;a;flight master;Moonglade;sindrayl", -- [15]
            "s;a;flight master;eastern plaguelands;Khaelyn Steelwing", -- [16]
            "s;a;flight master;redridge mountains;Ariena Stormfeather", -- [17]
            "s;a;flight master;stranglethorn vale;gyll", -- [18]
            "s;a;flight master;searing gorge;Lanie Reed", -- [19]
            "s;a;flight master;silithus;Cloud Skydancer", -- [20]
            "s;a;flight master;stonetalon mountains;teloren", -- [21]
            "s;a;flight master;Stormwind;Dungar Longdrink", -- [22]
            "s;a;flight master;wetlands;shellei brondir", -- [23]
            "s;a;flight master;tanaris;Bera Stonehammer", -- [24]
            "s;a;flight master;teldrassil;vesprystus", -- [25]
            "s;a;flight master;felwood;mishellena", -- [26]
            "s;a;flight master;Un'Goro Crater;gryfe", -- [27]
            "s;a;flight master;blasted lands;Alexandra Constantine", -- [28]
            "s;a;flight master;Hillsbrad Foothills;darla harris", -- [29]
            "s;a;flight master;westfall;thor", -- [30]
            "s;a;flight master;western plaguelands;Bibilfaz Featherwhistle", -- [31]
            "s;a;flight master;Winterspring;maethrya", -- [32]
            ["s;a;flight master;Stormwind;Dungar Longdrink"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 1519,
               ["worldY"] = 490.1231689453125,
               ["worldX"] = -8835.755859375,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;westfall;thor"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 40,
               ["worldY"] = 1037.41650390625,
               ["worldX"] = -10628.2666015625,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;loch modan;thorgrum borrelson"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 38,
               ["worldY"] = -2929.92822265625,
               ["worldX"] = -5424.767578125,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;azshara;jarrodenus"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 16,
               ["worldY"] = -3880.512451171875,
               ["worldX"] = 2718.15478515625,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;the barrens;bragok"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 17,
               ["worldY"] = -3769.18994140625,
               ["worldX"] = -898.1226196289062,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;Winterspring;maethrya"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 618,
               ["worldY"] = -4742.0966796875,
               ["worldX"] = 6800.4599609375,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;Ashenvale;daelyshia"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 331,
               ["worldY"] = -284.31005859375,
               ["worldX"] = 2828.30078125,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;western plaguelands;Bibilfaz Featherwhistle"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 28,
               ["worldY"] = -1428.893188476563,
               ["worldX"] = 928.2799072265625,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;darkshore;Caylais Moonfeather"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 148,
               ["worldY"] = 561.3966064453125,
               ["worldX"] = 6343.0068359375,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;eastern plaguelands;Khaelyn Steelwing"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 139,
               ["worldY"] = -5345.56494140625,
               ["worldX"] = 2269.8349609375,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;blasted lands;Alexandra Constantine"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 4,
               ["worldY"] = -3437.256591796875,
               ["worldX"] = -11110.259765625,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;Un'Goro Crater;gryfe"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 490,
               ["worldY"] = -1140.176635742188,
               ["worldX"] = -6110.47265625,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;burning steppes;Borgus Stoutarm"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 46,
               ["worldY"] = -2736.832763671875,
               ["worldX"] = -8365.1083984375,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;feralas;thyssiana"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 357,
               ["worldY"] = -778.5831909179688,
               ["worldX"] = -4491.0498046875,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;teldrassil;vesprystus"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 141,
               ["worldY"] = 841.0501098632812,
               ["worldX"] = 8640.4462890625,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;Ironforge;gryth thurden"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 1537,
               ["worldY"] = -1152.388305664063,
               ["worldX"] = -4821.11962890625,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;duskwood;felicia maline"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 10,
               ["worldY"] = -1258.896728515625,
               ["worldX"] = -10513.88671875,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;felwood;mishellena"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 361,
               ["worldY"] = -1951.507934570313,
               ["worldX"] = 6204.13330078125,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;tanaris;Bera Stonehammer"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 440,
               ["worldY"] = -3738.439697265625,
               ["worldX"] = -7224.6396484375,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;wetlands;shellei brondir"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 11,
               ["worldY"] = -782.0343017578125,
               ["worldX"] = -3793.1220703125,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;silithus;Cloud Skydancer"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 1377,
               ["worldY"] = 775.629638671875,
               ["worldX"] = -6758.57861328125,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;the hinterlands;Guthrum Thunderfist"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 47,
               ["worldY"] = -2001.194946289063,
               ["worldX"] = 282.1499938964844,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;stonetalon mountains;teloren"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 406,
               ["worldY"] = 1466.346557617188,
               ["worldX"] = 2682.86767578125,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;searing gorge;Lanie Reed"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 51,
               ["worldY"] = -1169.452880859375,
               ["worldX"] = -6559.04248046875,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;Moonglade;sindrayl"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 493,
               ["worldY"] = -2491.558349609375,
               ["worldX"] = 7454.9111328125,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;stranglethorn vale;gyll"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 33,
               ["worldY"] = 464.0750732421875,
               ["worldX"] = -14478.06640625,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;feralas;Fyldren Moonfeather"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 357,
               ["worldY"] = 3339.98681640625,
               ["worldX"] = -4370.5830078125,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;redridge mountains;Ariena Stormfeather"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 44,
               ["worldY"] = -2234.89111328125,
               ["worldX"] = -9435.20703125,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;desolace;Baritanas Skyriver"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 405,
               ["worldY"] = 1326.327270507813,
               ["worldX"] = 136.1028747558594,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;Hillsbrad Foothills;darla harris"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 267,
               ["worldY"] = -512.2133178710938,
               ["worldX"] = -715.0933227539062,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;arathi highlands;Cedrik Prose"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 45,
               ["worldY"] = -2514.026611328125,
               ["worldX"] = -1239.973388671875,
               ["createdBy"] = "SkuNav",
            },
            ["s;a;flight master;Dustwallow Marsh;baldruc"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["areaId"] = 15,
               ["worldY"] = -4517.69970703125,
               ["worldX"] = -3828.8330078125,
               ["createdBy"] = "SkuNav",
            },
         },
      },
		["Zones"] = {
         "Kalimdor", -- [1]
         "Eastern Kingdoms", -- [2]
         ["Kalimdor"] = {
            "Ashenvale", -- [1]
            "Azshara", -- [2]
            "The Barrens", -- [3]
            "Desolace", -- [4]
            "Darkshore", -- [5]
            "Durotar", -- [6]
            "Dustwallow Marsh", -- [7]
            "Feralas", -- [8]
            "capital", -- [9]
            "Dustwallow Marsh", -- [10]
            "Moonglade", -- [11]
            "Mulgore", -- [12]
            "Silithus", -- [13]
            "Stonetalon Mountains", -- [14]
            "Tanaris", -- [15]
            "Thousand Needles", -- [16]
            "Teldrassil", -- [17]
            "Felwood", -- [18]
            "Un'Goro Crater", -- [19]
            "Winterspring", -- [20]
            "Darnassus", -- [21]
            "Orgrimmar", -- [22]
            "Thunder Bluff", -- [23]
            ["Moonglade"] = {
               "s;Kalimdor;Moonglade;Lake Elune'ara;Stormrage Barrow Dens", -- [1]
               "s;Kalimdor;Moonglade;Lake Elune'ara;Nighthaven", -- [2]
               "s;Kalimdor;Moonglade;Lake Elune'ara;Shrine of Remulos", -- [3]
               ["s;Kalimdor;Moonglade;Lake Elune'ara;Nighthaven"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 2361,
                  ["worldY"] = -2491.77,
                  ["worldX"] = 7961.75,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Moonglade;Lake Elune'ara;Stormrage Barrow Dens"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 2363,
                  ["worldY"] = -2951.72,
                  ["worldX"] = 7564.51,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Moonglade;Lake Elune'ara;Shrine of Remulos"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 2362,
                  ["worldY"] = -2215.45,
                  ["worldX"] = 7856.18,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Thousand Needles"] = {
               "s;Kalimdor;Thousand Needles;Camp E'thok;Whitereach Post", -- [1]
               "s;Kalimdor;Thousand Needles;The Screeching Canyon;Roguefeather Den", -- [2]
               "s;Kalimdor;Thousand Needles;The Shimmering Flats;The Rustmaul Dig Site", -- [3]
               "s;Kalimdor;Thousand Needles;The Shimmering Flats;Mirage Raceway", -- [4]
               "s;Kalimdor;Thousand Needles;The Shimmering Flats;Tahonda Ruins", -- [5]
               "s;Kalimdor;Thousand Needles;The Shimmering Flats;Weazel's Crater", -- [6]
               "s;Kalimdor;Thousand Needles;Darkcloud Pinnacle;Darkcloud Pinnacle", -- [7]
               "s;Kalimdor;Thousand Needles;Freewind Post", -- [8]
               "s;Kalimdor;Thousand Needles;Windbreak Canyon;Ironstone Camp", -- [9]
               "s;Kalimdor;Thousand Needles;Splithoof Crag;The Weathered Nook", -- [10]
               "s;Kalimdor;Thousand Needles;Splithoof Crag;Splithoof Hold", -- [11]
               ["s;Kalimdor;Thousand Needles;Camp E'thok;Whitereach Post"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 2237,
                  ["worldY"] = -1375.5,
                  ["worldX"] = -4917.35,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Thousand Needles;Windbreak Canyon;Ironstone Camp"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 3037,
                  ["worldY"] = -3412.38,
                  ["worldX"] = -5848.05,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Thousand Needles;The Screeching Canyon;Roguefeather Den"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 487,
                  ["worldY"] = -1636.27,
                  ["worldX"] = -5466.71,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Thousand Needles;Darkcloud Pinnacle;Darkcloud Pinnacle"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 2097,
                  ["worldY"] = -1919.44,
                  ["worldX"] = -5086.21,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Thousand Needles;The Shimmering Flats;Weazel's Crater"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 3038,
                  ["worldY"] = -3899.53,
                  ["worldX"] = -5799.94,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Thousand Needles;The Shimmering Flats;The Rustmaul Dig Site"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 479,
                  ["worldY"] = -3449.15,
                  ["worldX"] = -6490.61,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Thousand Needles;Freewind Post"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 484,
                  ["worldY"] = -2445.5,
                  ["worldX"] = -5454.07,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Thousand Needles;The Shimmering Flats;Mirage Raceway"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 2240,
                  ["worldY"] = -3973.12,
                  ["worldX"] = -6239.42,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Thousand Needles;Splithoof Crag;Splithoof Hold"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 1557,
                  ["worldY"] = -2367.61,
                  ["worldX"] = -5065.61,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Thousand Needles;Splithoof Crag;The Weathered Nook"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 488,
                  ["worldY"] = -2794.53,
                  ["worldX"] = -5213.85,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Thousand Needles;The Shimmering Flats;Tahonda Ruins"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 3039,
                  ["worldY"] = -3894.97,
                  ["worldX"] = -6569.91,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Winterspring"] = {
               "s;Kalimdor;Winterspring;Frostfire Hot Springs;Holzschlundfeste B", -- [1]
               "s;Kalimdor;Winterspring;Everlook;Moon Horror Den", -- [2]
               "s;Kalimdor;Winterspring;Everlook", -- [3]
               "s;Kalimdor;Winterspring;Lake Kel'Theril;The Ruins of Kel'Theril", -- [4]
               "s;Kalimdor;Winterspring;Mazthoril;Dun Mandarr", -- [5]
               ["s;Kalimdor;Winterspring;Everlook;Moon Horror Den"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 3139,
                  ["worldY"] = -4631.57,
                  ["worldX"] = 7123.02,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Winterspring;Lake Kel'Theril;The Ruins of Kel'Theril"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 2252,
                  ["worldY"] = -4304.99,
                  ["worldX"] = 6426.76,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Winterspring;Everlook"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 2255,
                  ["worldY"] = -4662.5,
                  ["worldX"] = 6723.46,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Winterspring;Mazthoril;Dun Mandarr"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 2248,
                  ["worldY"] = -4507.31,
                  ["worldX"] = 5718.83,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Winterspring;Frostfire Hot Springs;Holzschlundfeste B"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 1769,
                  ["worldY"] = -2298.18,
                  ["worldX"] = 6900.63,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Ashenvale"] = {
               "s;Kalimdor;Ashenvale;Astranaar", -- [1]
               "s;Kalimdor;Ashenvale;The Zoram Strand;Zoram'gar Outpost", -- [2]
               "s;Kalimdor;Ashenvale;Fallen Sky Lake;Silverwing Outpost", -- [3]
               "s;Kalimdor;Ashenvale;Fallen Sky Lake;The Dor'Danil Barrow Den", -- [4]
               "s;Kalimdor;Ashenvale;Fallen Sky Lake;Silverwing Grove", -- [5]
               "s;Kalimdor;Ashenvale;Fallen Sky Lake;Warsong Labor Camp", -- [6]
               "s;Kalimdor;Ashenvale;Felfire Hill;Demon Fall Canyon", -- [7]
               "s;Kalimdor;Ashenvale;Maestra's Post;Bathran's Haunt", -- [8]
               "s;Kalimdor;Ashenvale;Maestra's Post;The Ruins of Ordil'Aran", -- [9]
               "s;Kalimdor;Ashenvale;Mystral Lake;Bloodtooth Camp", -- [10]
               "s;Kalimdor;Ashenvale;Mystral Lake;Talondeep Path A", -- [11]
               "s;Kalimdor;Ashenvale;Mystral Lake;Greenpaw Village", -- [12]
               "s;Kalimdor;Ashenvale;Mystral Lake;Silverwind Refuge", -- [13]
               "s;Kalimdor;Ashenvale;Night Run;Falfarren River", -- [14]
               "s;Kalimdor;Ashenvale;Satyrnaar;Forest Song", -- [15]
               "s;Kalimdor;Ashenvale;Satyrnaar;Xavian", -- [16]
               "s;Kalimdor;Ashenvale;Splintertree Post", -- [17]
               ["s;Kalimdor;Ashenvale;Fallen Sky Lake;Warsong Labor Camp"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 3177,
                  ["worldY"] = -2463.94,
                  ["worldX"] = 1575.91,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Ashenvale;Maestra's Post;The Ruins of Ordil'Aran"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 412,
                  ["worldY"] = -119.601,
                  ["worldX"] = 3493.89,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Ashenvale;Splintertree Post"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 431,
                  ["worldY"] = -2564.67,
                  ["worldX"] = 2286.41,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Ashenvale;Felfire Hill;Demon Fall Canyon"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 435,
                  ["worldY"] = -3150.99,
                  ["worldX"] = 1702.45,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Ashenvale;Fallen Sky Lake;Silverwing Outpost"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 2360,
                  ["worldY"] = -2065.15,
                  ["worldX"] = 1776.64,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Ashenvale;Satyrnaar;Xavian"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 429,
                  ["worldY"] = -2822.67,
                  ["worldX"] = 2936.56,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Ashenvale;Night Run;Falfarren River"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 433,
                  ["worldY"] = -2222.91,
                  ["worldX"] = 2231.21,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Ashenvale;Maestra's Post;Bathran's Haunt"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 411,
                  ["worldY"] = -161.305,
                  ["worldX"] = 3827.37,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Ashenvale;Mystral Lake;Bloodtooth Camp"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 2357,
                  ["worldY"] = -1465.1,
                  ["worldX"] = 1612.52,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Ashenvale;Satyrnaar;Forest Song"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 2358,
                  ["worldY"] = -3287.54,
                  ["worldX"] = 2880.33,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Ashenvale;The Zoram Strand;Zoram'gar Outpost"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 2897,
                  ["worldY"] = -1010.16,
                  ["worldX"] = 3362.22,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Ashenvale;Mystral Lake;Talondeep Path A"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 1276,
                  ["worldY"] = -732.677,
                  ["worldX"] = 1930.26,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Ashenvale;Fallen Sky Lake;The Dor'Danil Barrow Den"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 432,
                  ["worldY"] = -2678.36,
                  ["worldX"] = 1776.23,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Ashenvale;Mystral Lake;Silverwind Refuge"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 420,
                  ["worldY"] = -1190.25,
                  ["worldX"] = 2130.27,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Ashenvale;Astranaar"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 415,
                  ["worldY"] = -382.391,
                  ["worldX"] = 2720.43,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Ashenvale;Mystral Lake;Greenpaw Village"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 2359,
                  ["worldY"] = -1444.96,
                  ["worldX"] = 2291.29,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Ashenvale;Fallen Sky Lake;Silverwing Grove"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 3319,
                  ["worldY"] = -1858.93,
                  ["worldX"] = 1462.48,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Teldrassil"] = {
               "s;Kalimdor;Teldrassil;Ban'ethil Hollow;Ban'ethil Barrow Den", -- [1]
               "s;Kalimdor;Teldrassil;Dolanaar;Fel Rock", -- [2]
               "s;Kalimdor;Teldrassil;Dolanaar", -- [3]
               "s;Kalimdor;Teldrassil;Shadowglen;Aldrassil A", -- [4]
               "s;Kalimdor;Teldrassil;Shadowglen;Shadowthread Cave", -- [5]
               "s;Kalimdor;Teldrassil;Wellspring Lake;The Cleft", -- [6]
               ["s;Kalimdor;Teldrassil;Shadowglen;Aldrassil A"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 256,
                  ["worldY"] = -805.993,
                  ["worldX"] = 10462.7,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Teldrassil;Shadowglen;Shadowthread Cave"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 257,
                  ["worldY"] = -921.301,
                  ["worldX"] = 10756.2,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Teldrassil;Ban'ethil Hollow;Ban'ethil Barrow Den"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 262,
                  ["worldY"] = -1557.41,
                  ["worldX"] = 9864.17,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Teldrassil;Dolanaar;Fel Rock"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 258,
                  ["worldY"] = -1031.2,
                  ["worldX"] = 10050.6,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Teldrassil;Dolanaar"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 186,
                  ["worldY"] = -949.897,
                  ["worldX"] = 9787.99,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Teldrassil;Wellspring Lake;The Cleft"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 263,
                  ["worldY"] = -1200.62,
                  ["worldX"] = 10316.4,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Un'Goro Crater"] = {
               "s;Kalimdor;Un'Goro Crater;Lakkari Tar Pits;Fungal Rock", -- [1]
               "s;Kalimdor;Un'Goro Crater;Lakkari Tar Pits;Marshal's Refuge", -- [2]
               ["s;Kalimdor;Un'Goro Crater;Lakkari Tar Pits;Marshal's Refuge"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 541,
                  ["worldY"] = -1078.89,
                  ["worldX"] = -6143.21,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Un'Goro Crater;Lakkari Tar Pits;Fungal Rock"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 542,
                  ["worldY"] = -1836.52,
                  ["worldX"] = -6370.15,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Mulgore"] = {
               "s;Kalimdor;Mulgore;Bloodhoof", -- [1]
               "s;Kalimdor;Mulgore;Camp Narache", -- [2]
               "s;Kalimdor;Mulgore;The Golden Plains;The Venture Co. Mine", -- [3]
               ["s;Kalimdor;Mulgore;The Golden Plains;The Venture Co. Mine"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 360,
                  ["worldY"] = -1036.19,
                  ["worldX"] = -1501.49,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Mulgore;Camp Narache"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 221,
                  ["worldY"] = -253.607,
                  ["worldX"] = -2906.49,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Mulgore;Bloodhoof"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 222,
                  ["worldY"] = -394.981,
                  ["worldX"] = -2323.92,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Dustwallow Marsh"] = {
               "s;Kalimdor;Dustwallow Marsh;Brackenwall Village;Bluefen", -- [1]
               "s;Kalimdor;Dustwallow Marsh;Brackenwall Village;Brackenwall Village", -- [2]
               "s;Kalimdor;Dustwallow Marsh;Brackenwall Village;Darkmist Cavern", -- [3]
               "s;Kalimdor;Dustwallow Marsh;Brackenwall Village;North Point Tower", -- [4]
               "s;Kalimdor;Dustwallow Marsh;The Dragonmurk;Stonemaul Ruins", -- [5]
               "s;Kalimdor;Dustwallow Marsh;Wyrmbog;Emberstrife's Den", -- [6]
               "s;Kalimdor;Dustwallow Marsh;Wyrmbog;Onyxia's Lair", -- [7]
               "s;Kalimdor;Dustwallow Marsh;Wyrmbog;Tidefury Cove", -- [8]
               "s;Kalimdor;Dustwallow Marsh;The Den of Flame;Bloodfen Burrow", -- [9]
               "s;Kalimdor;Dustwallow Marsh;The Quagmire;Lost Point", -- [10]
               "s;Kalimdor;Dustwallow Marsh;The Quagmire;Shady Rest Inn", -- [11]
               "s;Kalimdor;Dustwallow Marsh;Nijel's Point", -- [12]
               "s;Kalimdor;Dustwallow Marsh;Witch Hill;Sentry Point", -- [13]
               "s;Kalimdor;Dustwallow Marsh;Witch Hill;Swamplight Manor", -- [14]
               ["s;Kalimdor;Dustwallow Marsh;The Dragonmurk;Stonemaul Ruins"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 508,
                  ["worldY"] = -3321.15,
                  ["worldX"] = -4346.02,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Dustwallow Marsh;Witch Hill;Swamplight Manor"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 497,
                  ["worldY"] = -3893.5,
                  ["worldX"] = -2949.47,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Dustwallow Marsh;Nijel's Point"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 608,
                  ["worldY"] = -1308.24,
                  ["worldX"] = 202.521,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Dustwallow Marsh;Wyrmbog;Onyxia's Lair"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 2159,
                  ["worldY"] = -3720.58,
                  ["worldX"] = -4698.06,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Dustwallow Marsh;Brackenwall Village;Darkmist Cavern"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 499,
                  ["worldY"] = -2722.81,
                  ["worldX"] = -2829.79,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Dustwallow Marsh;The Den of Flame;Bloodfen Burrow"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 498,
                  ["worldY"] = -2639.53,
                  ["worldX"] = -4335.04,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Dustwallow Marsh;Witch Hill;Sentry Point"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 503,
                  ["worldY"] = -4109.08,
                  ["worldX"] = -3476.59,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Dustwallow Marsh;Brackenwall Village;Brackenwall Village"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 496,
                  ["worldY"] = -2880.71,
                  ["worldX"] = -3132.98,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Dustwallow Marsh;Brackenwall Village;Bluefen"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 507,
                  ["worldY"] = -3087.58,
                  ["worldX"] = -2685.32,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Dustwallow Marsh;Wyrmbog;Tidefury Cove"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 517,
                  ["worldY"] = -4062.71,
                  ["worldX"] = -4300.98,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Dustwallow Marsh;Wyrmbog;Emberstrife's Den"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 2158,
                  ["worldY"] = -3832.99,
                  ["worldX"] = -4987.73,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Dustwallow Marsh;The Quagmire;Lost Point"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 506,
                  ["worldY"] = -2862.15,
                  ["worldX"] = -3925.5,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Dustwallow Marsh;The Quagmire;Shady Rest Inn"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 403,
                  ["worldY"] = -2535.18,
                  ["worldX"] = -3723.63,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Dustwallow Marsh;Brackenwall Village;North Point Tower"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 504,
                  ["worldY"] = -3429.99,
                  ["worldX"] = -2884.79,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Felwood"] = {
               "s;Kalimdor;Felwood;Irontree Woods;Irontree Cavern", -- [1]
               "s;Kalimdor;Felwood;Bloodvenom Falls;Bloodvenom Post ", -- [2]
               "s;Kalimdor;Felwood;Felpaw Village;Timbermaw Hold A", -- [3]
               ["s;Kalimdor;Felwood;Bloodvenom Falls;Bloodvenom Post "] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 1997,
                  ["worldY"] = -353.403,
                  ["worldX"] = 5111.98,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Felwood;Felpaw Village;Timbermaw Hold A"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 1216,
                  ["worldY"] = -2097.68,
                  ["worldX"] = 6817.78,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Felwood;Irontree Woods;Irontree Cavern"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 1768,
                  ["worldY"] = -1571,
                  ["worldX"] = 6481.87,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["capital"] = {
               "s;Kalimdor;capital;Darnassus", -- [1]
               "s;Kalimdor;capital;Orgrimmar", -- [2]
               "s;Kalimdor;capital;Thunder Bluff", -- [3]
               ["s;Kalimdor;capital;Orgrimmar"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 1637,
                  ["worldY"] = -4371.16,
                  ["worldX"] = 1381.77,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;capital;Darnassus"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 1657,
                  ["worldY"] = -2254.5,
                  ["worldX"] = 9951.75,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;capital;Thunder Bluff"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 1638,
                  ["worldY"] = -29.4214,
                  ["worldX"] = -1205.41,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Orgrimmar"] = {
               "s;Kalimdor;capital;Orgrimmar", -- [1]
               ["s;Kalimdor;capital;Orgrimmar"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 1637,
                  ["worldY"] = -4371.16,
                  ["worldX"] = 1381.77,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Desolace"] = {
               "s;Kalimdor;Desolace;Valley of Spears;Maraudon", -- [1]
               "s;Kalimdor;Desolace;Kodo Graveyard;Ghost Walker Post", -- [2]
               "s;Kalimdor;Desolace;Gelkis Village;Bolgan's Hole", -- [3]
               "s;Kalimdor;Desolace;Mannoroc Coven;Scrabblescrew's Camp", -- [4]
               "s;Kalimdor;Desolace;Mannoroc Coven;Valley of Bones", -- [5]
               "s;Kalimdor;Desolace;Shadowprey", -- [6]
               ["s;Kalimdor;Desolace;Mannoroc Coven;Valley of Bones"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 2657,
                  ["worldY"] = -1513.55,
                  ["worldX"] = -2251.19,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Desolace;Valley of Spears;Maraudon"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 349,
                  ["areaId"] = 2100,
                  ["worldY"] = -2918.45,
                  ["worldX"] = -1422.62,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Desolace;Mannoroc Coven;Scrabblescrew's Camp"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 2617,
                  ["worldY"] = -1493.13,
                  ["worldX"] = -1407.87,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Desolace;Kodo Graveyard;Ghost Walker Post"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 597,
                  ["worldY"] = -1736.67,
                  ["worldX"] = -1224.06,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Desolace;Shadowprey"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 2408,
                  ["worldY"] = -3097.92,
                  ["worldX"] = -1657.85,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Desolace;Gelkis Village;Bolgan's Hole"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 600,
                  ["worldY"] = -2499.6,
                  ["worldX"] = -2281.95,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Tanaris"] = {
               "s;Kalimdor;Tanaris;Gadgetzan", -- [1]
               "s;Kalimdor;Tanaris;Lost Rigger Cove;Wavestrider Beach", -- [2]
               "s;Kalimdor;Tanaris;Valley of the Watchers;Uldum", -- [3]
               ["s;Kalimdor;Tanaris;Gadgetzan"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 976,
                  ["worldY"] = -3752.11,
                  ["worldX"] = -7139.15,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Tanaris;Lost Rigger Cove;Wavestrider Beach"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 988,
                  ["worldY"] = -4878.96,
                  ["worldX"] = -7693.45,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Tanaris;Valley of the Watchers;Uldum"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 989,
                  ["worldY"] = -2787.2,
                  ["worldX"] = -9635.41,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Durotar"] = {
               "s;Kalimdor;Durotar;The Den", -- [1]
               "s;Kalimdor;Durotar;Thunder Ridge;Tor'kren Farm", -- [2]
               "s;Kalimdor;Durotar;Razor Hill;Razor Hill", -- [3]
               "s;Kalimdor;Durotar;Razorwind Canyon;Razorwind Canyon", -- [4]
               "s;Kalimdor;Durotar;Sen'jin Village;Sen'jin Village", -- [5]
               ["s;Kalimdor;Durotar;Razor Hill;Razor Hill"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 362,
                  ["worldY"] = -4745.52,
                  ["worldX"] = 312.659,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Durotar;Razorwind Canyon;Razorwind Canyon"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 410,
                  ["worldY"] = -4534.04,
                  ["worldX"] = 636.963,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Durotar;Thunder Ridge;Tor'kren Farm"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 2979,
                  ["worldY"] = -4242.41,
                  ["worldX"] = 726.297,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Durotar;Sen'jin Village;Sen'jin Village"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 367,
                  ["worldY"] = -4918.24,
                  ["worldX"] = -819.492,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Durotar;The Den"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 364,
                  ["worldY"] = -4202.92,
                  ["worldX"] = -604.098,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Azshara"] = {
               "s;Kalimdor;Azshara;Bay of Storms;Hetaera's Clutch", -- [1]
               "s;Kalimdor;Azshara;Bay of Storms;Scalebeard's Cave", -- [2]
               "s;Kalimdor;Azshara;Ruins of Eldarath ;Temple of Zin-Malor", -- [3]
               "s;Kalimdor;Azshara;The Ruined Reaches;Rethress Sanctum", -- [4]
               "s;Kalimdor;Azshara;Shadowsong Shrine;Talrendis Point", -- [5]
               ["s;Kalimdor;Azshara;Bay of Storms;Scalebeard's Cave"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 3140,
                  ["worldY"] = -6043.45,
                  ["worldX"] = 3705.1,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Azshara;Bay of Storms;Hetaera's Clutch"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 1222,
                  ["worldY"] = -6232.79,
                  ["worldX"] = 3556.64,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Azshara;Shadowsong Shrine;Talrendis Point"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 3137,
                  ["worldY"] = -3869.25,
                  ["worldX"] = 2707.72,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Azshara;Ruins of Eldarath ;Temple of Zin-Malor"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 1223,
                  ["worldY"] = -5359.12,
                  ["worldX"] = 3549.15,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Azshara;The Ruined Reaches;Rethress Sanctum"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 3138,
                  ["worldY"] = -6438.33,
                  ["worldX"] = 2195.67,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Feralas"] = {
            },
            ["The Barrens"] = {
               "s;Kalimdor;The Barrens;The Mor'shan Rampart;Mor'shan Base Camp", -- [1]
               "s;Kalimdor;The Barrens;Lushwater Oasis;Wailing Caverns", -- [2]
               "s;Kalimdor;The Barrens;Fray Island", -- [3]
               "s;Kalimdor;The Barrens;Camp Mojache", -- [4]
               "s;Kalimdor;The Barrens;Camp Taurajo", -- [5]
               "s;Kalimdor;The Barrens;Crossroads", -- [6]
               "s;Kalimdor;The Barrens;Ratchet", -- [7]
               ["s;Kalimdor;The Barrens;Fray Island"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 720,
                  ["worldY"] = -4329.2,
                  ["worldX"] = -1668.51,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;The Barrens;Lushwater Oasis;Wailing Caverns"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 43,
                  ["areaId"] = 718,
                  ["worldY"] = -2037,
                  ["worldX"] = -837.968,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;The Barrens;Ratchet"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 392,
                  ["worldY"] = -3680.07,
                  ["worldX"] = -951.364,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;The Barrens;Crossroads"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 380,
                  ["worldY"] = -2652.15,
                  ["worldX"] = -455.9,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;The Barrens;Camp Taurajo"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 378,
                  ["worldY"] = -1921.67,
                  ["worldX"] = -2352.66,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;The Barrens;The Mor'shan Rampart;Mor'shan Base Camp"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 1599,
                  ["worldY"] = -2113.34,
                  ["worldX"] = 1035.13,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;The Barrens;Camp Mojache"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 1099,
                  ["worldY"] = -215.611,
                  ["worldX"] = -4394.98,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Darkshore"] = {
               "s;Kalimdor;Darkshore;Auberdine", -- [1]
               "s;Kalimdor;Darkshore;Cliffspring;Cliffspring Falls", -- [2]
               "s;Kalimdor;Darkshore;Grove of the Ancients;Wildbend River", -- [3]
               "s;Kalimdor;Darkshore;The Master's Glaive;Blackwood Den", -- [4]
               ["s;Kalimdor;Darkshore;The Master's Glaive;Blackwood Den"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 455,
                  ["worldY"] = -25.6126,
                  ["worldX"] = 4619.42,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Darkshore;Cliffspring;Cliffspring Falls"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 445,
                  ["worldY"] = -662.396,
                  ["worldX"] = 6870.57,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Darkshore;Auberdine"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 442,
                  ["worldY"] = -411.951,
                  ["worldX"] = 6439.33,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Darkshore;Grove of the Ancients;Wildbend River"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 454,
                  ["worldY"] = -220.755,
                  ["worldX"] = 5056.04,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Thunder Bluff"] = {
               "s;Kalimdor;capital;Thunder Bluff", -- [1]
               ["s;Kalimdor;capital;Thunder Bluff"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 1638,
                  ["worldY"] = -29.4214,
                  ["worldX"] = -1205.41,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Silithus"] = {
               "s;Kalimdor;Silithus;Twilight Base Camp;Twilight Base Camp", -- [1]
               "s;Kalimdor;Silithus;Hive'Regal;Ortell's Hideout", -- [2]
               "s;Kalimdor;Silithus;Hive'Zora;Twilight Post", -- [3]
               "s;Kalimdor;Silithus;Bronzebeard Encampment;Bronzebeard Encampment", -- [4]
               "s;Kalimdor;Silithus;Cenarion Hold;The Swarming Pillar", -- [5]
               "s;Kalimdor;Silithus;Cenarion Hold;Bones of Grakkarond", -- [6]
               "s;Kalimdor;Silithus;Cenarion Hold", -- [7]
               "s;Kalimdor;Silithus;The Crystal Vale;Ravaged Twilight Camp", -- [8]
               "s;Kalimdor;Silithus;Staghelm Point;Twilight's Run", -- [9]
               "s;Kalimdor;Silithus;Staghelm Point;Staghelm Point", -- [10]
               "s;Kalimdor;Silithus;Southwind Village;Valor's Rest", -- [11]
               "s;Kalimdor;Silithus;Twilight Post;Twilight Post", -- [12]
               ["s;Kalimdor;Silithus;The Crystal Vale;Ravaged Twilight Camp"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 3100,
                  ["worldY"] = -1766.95,
                  ["worldX"] = -6206.25,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Silithus;Cenarion Hold;The Swarming Pillar"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 3097,
                  ["worldY"] = -731.852,
                  ["worldX"] = -7066.79,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Silithus;Twilight Base Camp;Twilight Base Camp"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 2739,
                  ["worldY"] = -1195.01,
                  ["worldX"] = -6996.15,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Silithus;Twilight Post;Twilight Post"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 3098,
                  ["worldY"] = -1636.32,
                  ["worldX"] = -6740.04,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Silithus;Hive'Regal;Ortell's Hideout"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 3447,
                  ["worldY"] = -226.396,
                  ["worldX"] = -7586.17,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Silithus;Cenarion Hold;Bones of Grakkarond"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 3257,
                  ["worldY"] = -874.224,
                  ["worldX"] = -7234.61,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Silithus;Staghelm Point;Twilight's Run"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 3446,
                  ["worldY"] = -136.591,
                  ["worldX"] = -6310.14,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Silithus;Cenarion Hold"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 3425,
                  ["worldY"] = -718.398,
                  ["worldX"] = -6886.15,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Silithus;Southwind Village;Valor's Rest"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 3077,
                  ["worldY"] = -292.647,
                  ["worldX"] = -6404.33,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Silithus;Hive'Zora;Twilight Post"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 3099,
                  ["worldY"] = -1833.28,
                  ["worldX"] = -7929.11,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Silithus;Staghelm Point;Staghelm Point"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 3426,
                  ["worldY"] = -97.5554,
                  ["worldX"] = -6517.49,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Silithus;Bronzebeard Encampment;Bronzebeard Encampment"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 3427,
                  ["worldY"] = -1105.84,
                  ["worldX"] = -8021.76,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Stonetalon Mountains"] = {
               "s;Kalimdor;Stonetalon Mountains;Stonetalon Peak;The Talon Den", -- [1]
               "s;Kalimdor;Stonetalon Mountains;Stonetalon Peak", -- [2]
               "s;Kalimdor;Stonetalon Mountains;Windshear Crag;Talondeep Path B", -- [3]
               "s;Kalimdor;Stonetalon Mountains;Windshear Crag;Cragpool Lake", -- [4]
               "s;Kalimdor;Stonetalon Mountains;Windshear Crag;Windshear Mine", -- [5]
               "s;Kalimdor;Stonetalon Mountains;Sishir Canyon;Sishir Canyon", -- [6]
               "s;Kalimdor;Stonetalon Mountains;Sun Rock Retreat", -- [7]
               ["s;Kalimdor;Stonetalon Mountains;Stonetalon Peak"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 467,
                  ["worldY"] = -1449.71,
                  ["worldX"] = 2658.78,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Stonetalon Mountains;Stonetalon Peak;The Talon Den"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 468,
                  ["worldY"] = -1792.39,
                  ["worldX"] = 2416.89,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Stonetalon Mountains;Sishir Canyon;Sishir Canyon"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 2541,
                  ["worldY"] = -624.05,
                  ["worldX"] = 515.845,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Stonetalon Mountains;Sun Rock Retreat"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 460,
                  ["worldY"] = -910.974,
                  ["worldX"] = 936.308,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Stonetalon Mountains;Windshear Crag;Cragpool Lake"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 463,
                  ["worldY"] = -70.1338,
                  ["worldX"] = 1543.57,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Stonetalon Mountains;Windshear Crag;Windshear Mine"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 2160,
                  ["worldY"] = -358.9,
                  ["worldX"] = 981.949,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Kalimdor;Stonetalon Mountains;Windshear Crag;Talondeep Path B"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 1277,
                  ["worldY"] = -576.57,
                  ["worldX"] = 1531.94,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Darnassus"] = {
               "s;Kalimdor;capital;Darnassus", -- [1]
               ["s;Kalimdor;capital;Darnassus"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["areaId"] = 1657,
                  ["worldY"] = -2254.5,
                  ["worldX"] = 9951.75,
                  ["createdBy"] = "SkuNav",
               },
            },
         },
         ["Eastern Kingdoms"] = {
            "Alterac Mountains", -- [1]
            "Arathi Highlands", -- [2]
            "Burning Steppes", -- [3]
            "Duskwood", -- [4]
            "Dun Morogh", -- [5]
            "Deadwind Pass", -- [6]
            "capital", -- [7]
            "The Hinterlands", -- [8]
            "Loch Modan", -- [9]
            "Badlands", -- [10]
            "Eastern Plaguelands", -- [11]
            "Redridge Mountains", -- [12]
            "Stranglethorn Vale", -- [13]
            "Searing Gorge", -- [14]
            "Silverpine Forest", -- [15]
            "Swamp of Sorrows", -- [16]
            "Wetlands", -- [17]
            "Tirisfal Glades", -- [18]
            "Hillsbrad Foothills", -- [19]
            "Elwynn Forest", -- [20]
            "Westfall", -- [21]
            "Western Plaguelands", -- [22]
            "Ironforge", -- [23]
            "Stormwind City", -- [24]
            "Undercity", -- [25]
            "Blasted Lands", -- [26]
            ["The Hinterlands"] = {
               "s;Eastern Kingdoms;The Hinterlands;Aerie Peak;Wildhammer Keep", -- [1]
               "s;Eastern Kingdoms;The Hinterlands;Aerie Peak", -- [2]
               "s;Eastern Kingdoms;The Hinterlands;The Overlook Cliffs;Revantusk", -- [3]
               ["s;Eastern Kingdoms;The Hinterlands;Aerie Peak"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 348,
                  ["worldY"] = -2127.76,
                  ["worldX"] = 234.85,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;The Hinterlands;The Overlook Cliffs;Revantusk"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 3317,
                  ["worldY"] = -4590.51,
                  ["worldX"] = -573.459,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;The Hinterlands;Aerie Peak;Wildhammer Keep"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 349,
                  ["worldY"] = -2119.3,
                  ["worldX"] = 316.946,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Stranglethorn Vale"] = {
               "s;Eastern Kingdoms;Stranglethorn Vale;Booty Bay;Janeiro's Point", -- [1]
               "s;Eastern Kingdoms;Stranglethorn Vale;Booty Bay", -- [2]
               "s;Eastern Kingdoms;Stranglethorn Vale;Grom'gol Base Camp", -- [3]
               "s;Eastern Kingdoms;Stranglethorn Vale;Yojamba Isle", -- [4]
               "s;Eastern Kingdoms;Stranglethorn Vale;Mistvale Valley;Spirit Den", -- [5]
               ["s;Eastern Kingdoms;Stranglethorn Vale;Grom'gol Base Camp"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 117,
                  ["worldY"] = -185.734,
                  ["worldX"] = -12378.4,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Stranglethorn Vale;Booty Bay;Janeiro's Point"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 312,
                  ["worldY"] = -718,
                  ["worldX"] = -14179.6,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Stranglethorn Vale;Yojamba Isle"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 3357,
                  ["worldY"] = -1250.73,
                  ["worldX"] = -11874.6,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Stranglethorn Vale;Booty Bay"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 35,
                  ["worldY"] = -487.139,
                  ["worldX"] = -14383.3,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Stranglethorn Vale;Mistvale Valley;Spirit Den"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 1742,
                  ["worldY"] = -18.3165,
                  ["worldX"] = -13751.4,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Eastern Plaguelands"] = {
               "s;Eastern Kingdoms;Eastern Plaguelands;Northpass Tower", -- [1]
               "s;Eastern Kingdoms;Eastern Plaguelands;Eastwall Tower;Browman Mill", -- [2]
               "s;Eastern Kingdoms;Eastern Plaguelands;Eastwall Tower", -- [3]
               "s;Eastern Kingdoms;Eastern Plaguelands;Terrordale;Terrorweb Tunnel", -- [4]
               ["s;Eastern Kingdoms;Eastern Plaguelands;Eastwall Tower"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 2271,
                  ["worldY"] = -4796.96,
                  ["worldX"] = 2562.3,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Eastern Plaguelands;Terrordale;Terrorweb Tunnel"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 2626,
                  ["worldY"] = -2773.9,
                  ["worldX"] = 3035.33,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Eastern Plaguelands;Northpass Tower"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 2275,
                  ["worldY"] = -4376.45,
                  ["worldX"] = 3170.26,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Eastern Plaguelands;Eastwall Tower;Browman Mill"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 2269,
                  ["worldY"] = -5183.79,
                  ["worldX"] = 2483.98,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Duskwood"] = {
               "s;Eastern Kingdoms;Duskwood;The Rotting Orchard;Roland's Doom", -- [1]
               "s;Eastern Kingdoms;Duskwood;Darkshire;Beggar's Haunt", -- [2]
               "s;Eastern Kingdoms;Duskwood;Darkshire;Darkshire", -- [3]
               "s;Eastern Kingdoms;Duskwood;Raven Hill", -- [4]
               ["s;Eastern Kingdoms;Duskwood;The Rotting Orchard;Roland's Doom"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 2161,
                  ["worldY"] = -1139.98,
                  ["worldX"] = -11076,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Duskwood;Raven Hill"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 94,
                  ["worldY"] = -310.43338,
                  ["worldX"] = -10752.526,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Duskwood;Darkshire;Beggar's Haunt"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 576,
                  ["worldY"] = -1538.8,
                  ["worldX"] = -10349.7,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Duskwood;Darkshire;Darkshire"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 42,
                  ["worldY"] = -1170.65,
                  ["worldX"] = -10564.7,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Blasted Lands"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["areaId"] = 4,
               ["worldY"] = -3389.016357421875,
               ["worldX"] = -10997.69921875,
               ["createdBy"] = "SkuNav",
            },
            ["Redridge Mountains"] = {
               "s;Eastern Kingdoms;Redridge Mountains;Galardell Valley;Tower of Ilgalar", -- [1]
               "s;Eastern Kingdoms;Redridge Mountains;Render's Camp;Render's Rock", -- [2]
               "s;Eastern Kingdoms;Redridge Mountains;Rethban Caverns", -- [3]
               "s;Eastern Kingdoms;Redridge Mountains;Lakeshire", -- [4]
               ["s;Eastern Kingdoms;Redridge Mountains;Lakeshire"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 69,
                  ["worldY"] = -2201.47,
                  ["worldX"] = -9227.69,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Redridge Mountains;Rethban Caverns"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 98,
                  ["worldY"] = -2002.7,
                  ["worldX"] = -8970.76,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Redridge Mountains;Galardell Valley;Tower of Ilgalar"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 96,
                  ["worldY"] = -3318.81,
                  ["worldX"] = -9281.33,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Redridge Mountains;Render's Camp;Render's Rock"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 998,
                  ["worldY"] = -2290.05,
                  ["worldX"] = -8674.12,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Arathi Highlands"] = {
               "s;Eastern Kingdoms;Arathi Highlands;Stromgarde Keep;The Tower of Arathor", -- [1]
               "s;Eastern Kingdoms;Arathi Highlands;Refuge Pointe", -- [2]
               "s;Eastern Kingdoms;Arathi Highlands;Hammerfall;Drywhisker Gorge", -- [3]
               "s;Eastern Kingdoms;Arathi Highlands;Hammerfall", -- [4]
               ["s;Eastern Kingdoms;Arathi Highlands;Stromgarde Keep;The Tower of Arathor"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 325,
                  ["worldY"] = -1513.16,
                  ["worldX"] = -1778.21,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Arathi Highlands;Hammerfall;Drywhisker Gorge"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 318,
                  ["worldY"] = -3827.39,
                  ["worldX"] = -1014.22,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Arathi Highlands;Refuge Pointe"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 320,
                  ["worldY"] = -2526.81,
                  ["worldX"] = -1251.05,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Arathi Highlands;Hammerfall"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 321,
                  ["worldY"] = -3528.34,
                  ["worldX"] = -991.57,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Westfall"] = {
               "s;Eastern Kingdoms;Westfall;Moonbrook", -- [1]
               "s;Eastern Kingdoms;Westfall;Sentinel Hill", -- [2]
               ["s;Eastern Kingdoms;Westfall;Sentinel Hill"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 108,
                  ["worldY"] = -1027.76,
                  ["worldX"] = -10503.7,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Westfall;Moonbrook"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 20,
                  ["worldY"] = -1510.168,
                  ["worldX"] = -11017.066,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Deadwind Pass"] = {
               "s;Eastern Kingdoms;Deadwind Pass;The vice;Grosh'gok Compound", -- [1]
               "s;Eastern Kingdoms;Deadwind Pass;Sleeping Gorge;Sleeping Gorge", -- [2]
               "s;Eastern Kingdoms;Deadwind Pass;Deadman's Crossing;Ariden's Camp", -- [3]
               "s;Eastern Kingdoms;Deadwind Pass;Deadman's Crossing;Deadwind Ravine", -- [4]
               ["s;Eastern Kingdoms;Deadwind Pass;Deadman's Crossing;Ariden's Camp"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 2560,
                  ["worldY"] = -2141.1,
                  ["worldX"] = -10443.3,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Deadwind Pass;Deadman's Crossing;Deadwind Ravine"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 2558,
                  ["worldY"] = -1841.05,
                  ["worldX"] = -10572,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Deadwind Pass;Sleeping Gorge;Sleeping Gorge"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 2938,
                  ["worldY"] = -1973.68,
                  ["worldX"] = -10740.8,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Deadwind Pass;The vice;Grosh'gok Compound"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 2937,
                  ["worldY"] = -2335.63,
                  ["worldX"] = -11112.2,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["capital"] = {
               "s;Eastern Kingdoms;capital;Ironforge", -- [1]
               "s;Eastern Kingdoms;capital;Stormwind", -- [2]
               "s;Eastern Kingdoms;capital;Undercity", -- [3]
               ["s;Eastern Kingdoms;capital;Ironforge"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 1537,
                  ["worldY"] = -834.059,
                  ["worldX"] = -5021,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;capital;Undercity"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 1497,
                  ["worldY"] = -235.699,
                  ["worldX"] = 1849.69,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;capital;Stormwind"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 1519,
                  ["worldY"] = -364.057,
                  ["worldX"] = -9153.77,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Loch Modan"] = {
               "s;Eastern Kingdoms;Loch Modan;North Gate Pass;Algaz Station", -- [1]
               "s;Eastern Kingdoms;Loch Modan;Thelsamar", -- [2]
               ["s;Eastern Kingdoms;Loch Modan;North Gate Pass;Algaz Station"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 925,
                  ["worldY"] = -2666.7,
                  ["worldX"] = -4817.79,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Loch Modan;Thelsamar"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 144,
                  ["worldY"] = -2959.91,
                  ["worldX"] = -5349.27,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Burning Steppes"] = {
               "s;Eastern Kingdoms;Burning Steppes;Ruins of Thaurissan;Flame Crest", -- [1]
               "s;Eastern Kingdoms;Burning Steppes;Terror Wing Path;Slither Rock", -- [2]
               ["s;Eastern Kingdoms;Burning Steppes;Ruins of Thaurissan;Flame Crest"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 251,
                  ["worldY"] = -2186.4,
                  ["worldX"] = -7479.77,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Burning Steppes;Terror Wing Path;Slither Rock"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 2419,
                  ["worldY"] = -3030.61,
                  ["worldX"] = -7652.52,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Undercity"] = {
               "s;Eastern Kingdoms;capital;Undercity", -- [1]
               ["s;Eastern Kingdoms;capital;Undercity"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 1497,
                  ["worldY"] = -235.699,
                  ["worldX"] = 1849.69,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Ironforge"] = {
               "s;Eastern Kingdoms;capital;Ironforge", -- [1]
               ["s;Eastern Kingdoms;capital;Ironforge"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 1537,
                  ["worldY"] = -834.059,
                  ["worldX"] = -5021,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Wetlands"] = {
               "s;Eastern Kingdoms;Wetlands;Menethil Harbor", -- [1]
               "s;Eastern Kingdoms;Wetlands;Dun Algaz", -- [2]
               "s;Eastern Kingdoms;Wetlands;Dun Modr", -- [3]
               "s;Eastern Kingdoms;Wetlands;Dragonmaw Gates;Grim Batol", -- [4]
               ["s;Eastern Kingdoms;Wetlands;Dun Algaz"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 837,
                  ["worldY"] = -2373.1401,
                  ["worldX"] = -4191.0234,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Wetlands;Dragonmaw Gates;Grim Batol"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 1037,
                  ["worldY"] = -3448.54,
                  ["worldX"] = -4055,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Wetlands;Menethil Harbor"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 150,
                  ["worldY"] = -828.455,
                  ["worldX"] = -3672.7,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Wetlands;Dun Modr"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 205,
                  ["worldY"] = -2350.5583,
                  ["worldX"] = -2610.2583,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Tirisfal Glades"] = {
               "s;Eastern Kingdoms;Tirisfal Glades;Brill", -- [1]
               "s;Eastern Kingdoms;Tirisfal Glades;Deathknell;Night Web's Hollow", -- [2]
               "s;Eastern Kingdoms;Tirisfal Glades;Deathknell", -- [3]
               ["s;Eastern Kingdoms;Tirisfal Glades;Deathknell"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 154,
                  ["worldY"] = -1588.2028,
                  ["worldX"] = 1879.8323,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Tirisfal Glades;Deathknell;Night Web's Hollow"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 155,
                  ["worldY"] = -1829.45,
                  ["worldX"] = 2046.11,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Tirisfal Glades;Brill"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 159,
                  ["worldY"] = -278.41385,
                  ["worldX"] = 2249.85,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Stormwind City"] = {
               "s;Eastern Kingdoms;capital;Stormwind", -- [1]
               ["s;Eastern Kingdoms;capital;Stormwind"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 1519,
                  ["worldY"] = -364.057,
                  ["worldX"] = -9153.77,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Silverpine Forest"] = {
               "s;Eastern Kingdoms;Silverpine Forest;The Sepulcher", -- [1]
               "s;Eastern Kingdoms;Silverpine Forest;Valgan's Field;Valgan's Field", -- [2]
               ["s;Eastern Kingdoms;Silverpine Forest;The Sepulcher"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 228,
                  ["worldY"] = -1619.02,
                  ["worldX"] = 508.073,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Silverpine Forest;Valgan's Field;Valgan's Field"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 227,
                  ["worldY"] = -1255.63,
                  ["worldX"] = 908.754,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Western Plaguelands"] = {
               "s;Eastern Kingdoms;Western Plaguelands;The Weeping Cave;The Weeping Cave", -- [1]
               "s;Eastern Kingdoms;Western Plaguelands;Scholomance", -- [2]
               "s;Eastern Kingdoms;Western Plaguelands;Sorrow Hill;Chillwind Camp", -- [3]
               "s;Eastern Kingdoms;Western Plaguelands;Sorrow Hill;Uther's Tomb", -- [4]
               ["s;Eastern Kingdoms;Western Plaguelands;Sorrow Hill;Uther's Tomb"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 196,
                  ["worldY"] = -1825.52,
                  ["worldX"] = 969.176,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Western Plaguelands;Sorrow Hill;Chillwind Camp"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 3197,
                  ["worldY"] = -1421.46,
                  ["worldX"] = 921.054,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Western Plaguelands;Scholomance"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 289,
                  ["areaId"] = 2057,
                  ["worldY"] = -2579.41,
                  ["worldX"] = 1262.19,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Western Plaguelands;The Weeping Cave;The Weeping Cave"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 198,
                  ["worldY"] = -2389.63,
                  ["worldX"] = 2249.61,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Elwynn Forest"] = {
               "s;Eastern Kingdoms;Elwynn Forest;Northshire Abbey;Echo Ridge Mine", -- [1]
               "s;Eastern Kingdoms;Elwynn Forest;Northshire Abbey;Northshire Vineyards", -- [2]
               "s;Eastern Kingdoms;Elwynn Forest;Northshire Abbey", -- [3]
               "s;Eastern Kingdoms;Elwynn Forest;Forest's Edge;Westbrook Garrison", -- [4]
               "s;Eastern Kingdoms;Elwynn Forest;Goldshire", -- [5]
               "s;Eastern Kingdoms;Elwynn Forest;Mirror Lake", -- [6]
               "s;Eastern Kingdoms;Elwynn Forest;Fargodeep Mine;The Stonefield Farm", -- [7]
               "s;Eastern Kingdoms;Elwynn Forest;Fargodeep Mine;The Maclure Vineyards", -- [8]
               "s;Eastern Kingdoms;Elwynn Forest;Tower of Azora;Jasperlode Mine", -- [9]
               ["s;Eastern Kingdoms;Elwynn Forest;Northshire Abbey;Echo Ridge Mine"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 34,
                  ["worldY"] = -119.634,
                  ["worldX"] = -8676.57,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Elwynn Forest;Northshire Abbey;Northshire Vineyards"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 59,
                  ["worldY"] = -333.965,
                  ["worldX"] = -9067.35,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Elwynn Forest;Tower of Azora;Jasperlode Mine"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 54,
                  ["worldY"] = -605.891,
                  ["worldX"] = -9184.5,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Elwynn Forest;Northshire Abbey"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 24,
                  ["worldY"] = -179.32834,
                  ["worldX"] = -8896.159,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Elwynn Forest;Fargodeep Mine;The Maclure Vineyards"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 64,
                  ["worldY"] = -69.1568,
                  ["worldX"] = -9948.39,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Elwynn Forest;Forest's Edge;Westbrook Garrison"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 120,
                  ["worldY"] = -667.327,
                  ["worldX"] = -9615.71,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Elwynn Forest;Mirror Lake"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 92,
                  ["worldY"] = -458.427,
                  ["worldX"] = -9389.26,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Elwynn Forest;Goldshire"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 87,
                  ["worldY"] = -63.521755,
                  ["worldX"] = -9480.089,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Elwynn Forest;Fargodeep Mine;The Stonefield Farm"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 63,
                  ["worldY"] = -378.19,
                  ["worldX"] = -9901.14,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Hillsbrad Foothills"] = {
               "s;Eastern Kingdoms;Hillsbrad Foothills;Southshore", -- [1]
               "s;Eastern Kingdoms;Hillsbrad Foothills;Tarren Mill", -- [2]
               ["s;Eastern Kingdoms;Hillsbrad Foothills;Southshore"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 560,
                  ["areaId"] = 2369,
                  ["worldY"] = -531.727,
                  ["worldX"] = -803.031,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Hillsbrad Foothills;Tarren Mill"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 560,
                  ["areaId"] = 2368,
                  ["worldY"] = -900.562,
                  ["worldX"] = -27.0354,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Badlands"] = {
               "s;Eastern Kingdoms;Badlands;Camp Cagg;Dustbelch Grotto", -- [1]
               "s;Eastern Kingdoms;Badlands;Angor Fortress", -- [2]
               "s;Eastern Kingdoms;Badlands;Kargath", -- [3]
               "s;Eastern Kingdoms;Badlands;The Maker's Terrace;Uldaman", -- [4]
               ["s;Eastern Kingdoms;Badlands;Kargath"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 340,
                  ["worldY"] = -2186.68,
                  ["worldX"] = -6676.42,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Badlands;The Maker's Terrace;Uldaman"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 70,
                  ["areaId"] = 1337,
                  ["worldY"] = -3179.35,
                  ["worldX"] = -6092.01,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Badlands;Angor Fortress"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 338,
                  ["worldY"] = -3158,
                  ["worldX"] = -6392.65,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Badlands;Camp Cagg;Dustbelch Grotto"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 347,
                  ["worldY"] = -2265.09,
                  ["worldX"] = -7320.59,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Searing Gorge"] = {
               "s;Eastern Kingdoms;Searing Gorge;Firewatch Ridge;Thorium Point", -- [1]
               ["s;Eastern Kingdoms;Searing Gorge;Firewatch Ridge;Thorium Point"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 1446,
                  ["worldY"] = -1142.76,
                  ["worldX"] = -6513.68,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Swamp of Sorrows"] = {
               "s;Eastern Kingdoms;Swamp of Sorrows;Misty Reed Strand;Misty Reed Post", -- [1]
               "s;Eastern Kingdoms;Swamp of Sorrows;Stagalbog;Stagalbog Cave", -- [2]
               "s;Eastern Kingdoms;Swamp of Sorrows;Stonard", -- [3]
               "s;Eastern Kingdoms;Swamp of Sorrows;Pool of Tears;The Temple of Atal'Hakkar", -- [4]
               ["s;Eastern Kingdoms;Swamp of Sorrows;Stagalbog;Stagalbog Cave"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 1817,
                  ["worldY"] = -3739.01,
                  ["worldX"] = -10803.2,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Swamp of Sorrows;Pool of Tears;The Temple of Atal'Hakkar"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 109,
                  ["areaId"] = 1477,
                  ["worldY"] = -3828.52,
                  ["worldX"] = -10429.9,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Swamp of Sorrows;Misty Reed Strand;Misty Reed Post"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 1978,
                  ["worldY"] = -4093.43,
                  ["worldX"] = -10854.8,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Swamp of Sorrows;Stonard"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 75,
                  ["worldY"] = -3277.49,
                  ["worldX"] = -10443.7,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Dun Morogh"] = {
               "s;Eastern Kingdoms;Dun Morogh;Coldridge Valley;Anvilmar", -- [1]
               "s;Eastern Kingdoms;Dun Morogh;Helm's Bed Lake;Ironband's Compound", -- [2]
               "s;Eastern Kingdoms;Dun Morogh;Kharanos;Steelgrill's Depot", -- [3]
               "s;Eastern Kingdoms;Dun Morogh;Kharanos", -- [4]
               ["s;Eastern Kingdoms;Dun Morogh;Coldridge Valley;Anvilmar"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 77,
                  ["worldY"] = -383.763,
                  ["worldX"] = -6134.28,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Dun Morogh;Kharanos"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 131,
                  ["worldY"] = -482.12653,
                  ["worldX"] = -5585.9507,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Dun Morogh;Helm's Bed Lake;Ironband's Compound"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 716,
                  ["worldY"] = -2004.1,
                  ["worldX"] = -5858.7,
                  ["createdBy"] = "SkuNav",
               },
               ["s;Eastern Kingdoms;Dun Morogh;Kharanos;Steelgrill's Depot"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 189,
                  ["worldY"] = -658.67,
                  ["worldX"] = -5488.04,
                  ["createdBy"] = "SkuNav",
               },
            },
            ["Alterac Mountains"] = {
               "s;Eastern Kingdoms;Alterac Mountains;Crushridge Hold;Slaughter Hollow", -- [1]
               ["s;Eastern Kingdoms;Alterac Mountains;Crushridge Hold;Slaughter Hollow"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["areaId"] = 283,
                  ["worldY"] = -558.217,
                  ["worldX"] = 861.216,
                  ["createdBy"] = "SkuNav",
               },
            },
         },
		},
   },
   ["deDE"] = {
      "Innkeepers", -- [1]
      "Taxi", -- [2]
      "Postbox", -- [3]
      "Zones", -- [4]
      ["Innkeepers"] = {
         "Horde", -- [1]
         "Allianz", -- [2]
         ["Horde"] = {
            "s;h;Brachland;Gastwirt Wiley", -- [1]
            "s;h;Schlingendorntal;Gastwirt Skindle", -- [2]
            "s;h;Tanaris;Gastwirt Fizzgrimble", -- [3]
            "s;h;Winterspring;Gastwirt Vizzie", -- [4]
            "s;h;Silithus;Calandrath", -- [5]
            "s;h;Ödland;Gastwirt Shul'kar", -- [6]
            "s;h;Sümpfe des Elends;Gastwirt Karakul", -- [7]
            "s;h;Durotar;Gastwirt Grosk", -- [8]
            "s;h;Brachland;Gastwirt Boorand Plainswind", -- [9]
            "s;h;Brachland;Gastwirt Byula", -- [10]
            "s;h;Schlingendorntal;Gastwirt Thulbek", -- [11]
            "s;h;Arathihochland;Gastwirt Adegwa", -- [12]
            "s;h;Hinterland;Lard", -- [13]
            "s;h;Tirisfal;Gastwirtin Renee", -- [14]
            "s;h;Silberwald;Gastwirt Bates", -- [15]
            "s;h;Mulgore;Gastwirt Kauth", -- [16]
            "s;h;Vorgebirge von Hillsbrad;Gastwirt Shay", -- [17]
            "s;h;Ashenvale;Gastwirtin Kaylisk", -- [18]
            "s;h;Feralas;Gastwirtin Greul", -- [19]
            "s;h;Tausend Nadeln;Gastwirt Abeqwa", -- [20]
            "s;h;Desolace;Gastwirtin Sikewa", -- [21]
            "s;h;Steinkrallengebirge;Gastwirt Jayka", -- [22]
            "s;h;Undercity;Gastwirt Norman", -- [23]
            "s;h;Orgrimmar;Gastwirtin Gryshka", -- [24]
            "s;h;Thunder Bluff;Gastwirtin Pala", -- [25]
            ["s;h;Brachland;Gastwirt Wiley"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -3664.817138671875,
               ["worldX"] = -1050.138305664063,
               ["areaId"] = 17,
            },
            ["s;h;Orgrimmar;Gastwirtin Gryshka"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -4439.41015625,
               ["worldX"] = 1633.958740234375,
               ["areaId"] = 1637,
            },
            ["s;h;Feralas;Gastwirtin Greul"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 243.0665283203125,
               ["worldX"] = -4460.00634765625,
               ["areaId"] = 357,
            },
            ["s;h;Vorgebirge von Hillsbrad;Gastwirt Shay"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -942.2933349609375,
               ["worldX"] = -5.97332763671875,
               ["areaId"] = 267,
            },
            ["s;h;Tirisfal;Gastwirtin Renee"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 244.8126831054688,
               ["worldX"] = 2269.49365234375,
               ["areaId"] = 85,
            },
            ["s;h;Undercity;Gastwirt Norman"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 223.3119964599609,
               ["worldX"] = 1635.409912109375,
               ["areaId"] = 1497,
            },
            ["s;h;Schlingendorntal;Gastwirt Skindle"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 495.3433837890625,
               ["worldX"] = -14457.646484375,
               ["areaId"] = 33,
            },
            ["s;h;Ashenvale;Gastwirtin Kaylisk"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -2566.756591796875,
               ["worldX"] = 2341.68212890625,
               ["areaId"] = 331,
            },
            ["s;h;Silberwald;Gastwirt Bates"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 1636.439819335938,
               ["worldX"] = 510.8266296386719,
               ["areaId"] = 130,
            },
            ["s;h;Brachland;Gastwirt Byula"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -1995.856689453125,
               ["worldX"] = -2376.389892578125,
               ["areaId"] = 17,
            },
            ["s;h;Ödland;Gastwirt Shul'kar"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -2149.065185546875,
               ["worldX"] = -6649.9287109375,
               ["areaId"] = 3,
            },
            ["s;h;Thunder Bluff;Gastwirtin Pala"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 38.52479553222656,
               ["worldX"] = -1300.273681640625,
               ["areaId"] = 1638,
            },
            ["s;h;Schlingendorntal;Gastwirt Thulbek"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 211.3775634765625,
               ["worldX"] = -12434.365234375,
               ["areaId"] = 33,
            },
            ["s;h;Silithus;Calandrath"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 729.998046875,
               ["worldX"] = -6867.98779296875,
               ["areaId"] = 1377,
            },
            ["s;h;Tanaris;Gastwirt Fizzgrimble"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -3841.939697265625,
               ["worldX"] = -7158.8603515625,
               ["areaId"] = 440,
            },
            ["s;h;Hinterland;Lard"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -4583.39013671875,
               ["worldX"] = -622.086669921875,
               ["areaId"] = 47,
            },
            ["s;h;Steinkrallengebirge;Gastwirt Jayka"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 927.7150268554688,
               ["worldX"] = 893.5585327148438,
               ["areaId"] = 406,
            },
            ["s;h;Brachland;Gastwirt Boorand Plainswind"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -2645.403564453125,
               ["worldX"] = -406.9432373046875,
               ["areaId"] = 17,
            },
            ["s;h;Tausend Nadeln;Gastwirt Abeqwa"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -2460.4130859375,
               ["worldX"] = -5477.919921875,
               ["areaId"] = 400,
            },
            ["s;h;Sümpfe des Elends;Gastwirt Karakul"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -3258.77392578125,
               ["worldX"] = -10487.259765625,
               ["areaId"] = 8,
            },
            ["s;h;Mulgore;Gastwirt Kauth"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -347.185791015625,
               ["worldX"] = -2365.2490234375,
               ["areaId"] = 215,
            },
            ["s;h;Arathihochland;Gastwirt Adegwa"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -3524.906494140625,
               ["worldX"] = -912.3733520507812,
               ["areaId"] = 45,
            },
            ["s;h;Desolace;Gastwirtin Sikewa"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 3150.286865234375,
               ["worldX"] = -1592.795532226563,
               ["areaId"] = 405,
            },
            ["s;h;Winterspring;Gastwirt Vizzie"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -4673.2265625,
               ["worldX"] = 6695.3798828125,
               ["areaId"] = 618,
            },
            ["s;h;Durotar;Gastwirt Grosk"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -4686.0908203125,
               ["worldX"] = 340.5234375,
               ["areaId"] = 14,
            },
         },
         ["Allianz"] = {
            "s;a;Dun Morogh;Gastwirt Belm", -- [1]
            "s;a;Dämmerwald;Gastwirtin Trelayne", -- [2]
            "s;a;Sumpfland;Gastwirt Helbrek", -- [3]
            "s;a;Wald von Elwynn;Gastwirt Farley", -- [4]
            "s;a;Marschen von Dustwallow;Gastwirtin Janene", -- [5]
            "s;a;Loch Modan;Gastwirt Hearthstove", -- [6]
            "s;a;Westfall;Gastwirtin Heather", -- [7]
            "s;a;Rotkammgebirge;Gastwirtin Brianna", -- [8]
            "s;a;Hinterland;Gastwirt Thulfram", -- [9]
            "s;a;Teldrassil;Gastwirt Keldamyr", -- [10]
            "s;a;Dunkelküste;Gastwirtin Shaussiy", -- [11]
            "s;a;Vorgebirge von Hillsbrad;Gastwirt Anderson", -- [12]
            "s;a;Ashenvale;Gastwirtin Kimlya", -- [13]
            "s;a;Feralas;Gastwirtin Shyria", -- [14]
            "s;a;Desolace;Gastwirtin Lyshaerya", -- [15]
            "s;a;Steinkrallengebirge;Gastwirtin Faralia", -- [16]
            "s;a;Stormwind;Gastwirtin Allison", -- [17]
            "s;a;Ironforge;Gastwirt Firebrew", -- [18]
            "s;a;Darnassus;Gastwirtin Saelienne", -- [19]
            "s;a;Brachland;Gastwirt Wiley", -- [20]
            "s;a;Schlingendorntal;Gastwirt Skindle", -- [21]
            "s;a;Tanaris;Gastwirt Fizzgrimble", -- [22]
            "s;a;Winterspring;Gastwirt Vizzie", -- [23]
            "s;a;Silithus;Calandrath", -- [24]
            ["s;a;Steinkrallengebirge;Gastwirtin Faralia"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 1498.088134765625,
               ["worldX"] = 2729.7578125,
               ["areaId"] = 406,
            },
            ["s;a;Loch Modan;Gastwirt Hearthstove"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -2973.78564453125,
               ["worldX"] = -5377.8583984375,
               ["areaId"] = 38,
            },
            ["s;a;Wald von Elwynn;Gastwirt Farley"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 16.23291015625,
               ["worldX"] = -9462.578125,
               ["areaId"] = 12,
            },
            ["s;a;Dun Morogh;Gastwirt Belm"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -531.381591796875,
               ["worldX"] = -5601.490234375,
               ["areaId"] = 1,
            },
            ["s;a;Feralas;Gastwirtin Shyria"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 3289.25146484375,
               ["worldX"] = -4381.703125,
               ["areaId"] = 357,
            },
            ["s;a;Silithus;Calandrath"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 729.998046875,
               ["worldX"] = -6867.98779296875,
               ["areaId"] = 1377,
            },
            ["s;a;Winterspring;Gastwirt Vizzie"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -4673.2265625,
               ["worldX"] = 6695.3798828125,
               ["areaId"] = 618,
            },
            ["s;a;Stormwind;Gastwirtin Allison"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 673.6161499023438,
               ["worldX"] = -8867.755859375,
               ["areaId"] = 1519,
            },
            ["s;a;Darnassus;Gastwirtin Saelienne"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 2224.83447265625,
               ["worldX"] = 10127.8701171875,
               ["areaId"] = 1657,
            },
            ["s;a;Dunkelküste;Gastwirtin Shaussiy"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 515.5465087890625,
               ["worldX"] = 6406.3232421875,
               ["areaId"] = 148,
            },
            ["s;a;Schlingendorntal;Gastwirt Skindle"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 495.3433837890625,
               ["worldX"] = -14457.646484375,
               ["areaId"] = 33,
            },
            ["s;a;Hinterland;Gastwirt Thulfram"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -2119.77490234375,
               ["worldX"] = 399.7033996582031,
               ["areaId"] = 47,
            },
            ["s;a;Ironforge;Gastwirt Firebrew"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -857.08984375,
               ["worldX"] = -4840.693359375,
               ["areaId"] = 1537,
            },
            ["s;a;Tanaris;Gastwirt Fizzgrimble"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -3841.939697265625,
               ["worldX"] = -7158.8603515625,
               ["areaId"] = 440,
            },
            ["s;a;Desolace;Gastwirtin Lyshaerya"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 1253.944458007813,
               ["worldX"] = 255.7197570800781,
               ["areaId"] = 405,
            },
            ["s;a;Sumpfland;Gastwirt Helbrek"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -832.0728759765625,
               ["worldX"] = -3827.850830078125,
               ["areaId"] = 11,
            },
            ["s;a;Marschen von Dustwallow;Gastwirtin Janene"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -4470.97509765625,
               ["worldX"] = -3616.033203125,
               ["areaId"] = 15,
            },
            ["s;a;Rotkammgebirge;Gastwirtin Brianna"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -2157.17529296875,
               ["worldX"] = -9223.9560546875,
               ["areaId"] = 44,
            },
            ["s;a;Ashenvale;Gastwirtin Kimlya"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -433.0899658203125,
               ["worldX"] = 2781.022705078125,
               ["areaId"] = 331,
            },
            ["s;a;Dämmerwald;Gastwirtin Trelayne"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -1161.156616210938,
               ["worldX"] = -10516.0458984375,
               ["areaId"] = 10,
            },
            ["s;a;Brachland;Gastwirt Wiley"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -3664.817138671875,
               ["worldX"] = -1050.138305664063,
               ["areaId"] = 17,
            },
            ["s;a;Teldrassil;Gastwirt Keldamyr"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 982.5982666015625,
               ["worldX"] = 9802.126953125,
               ["areaId"] = 141,
            },
            ["s;a;Vorgebirge von Hillsbrad;Gastwirt Anderson"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -570.7732543945312,
               ["worldX"] = -857.1732177734375,
               ["areaId"] = 267,
            },
            ["s;a;Westfall;Gastwirtin Heather"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 1166.566650390625,
               ["worldX"] = -10653.466796875,
               ["areaId"] = 40,
            },
         },
      },
      ["Zones"] = {
         "Kalimdor", -- [1]
         "Östliche Königreiche", -- [2]
         ["Kalimdor"] = {
            "Eschental", -- [1]
            "Azshara", -- [2]
            "Das Brachland", -- [3]
            "Desolace", -- [4]
            "Dunkelküste", -- [5]
            "Durotar", -- [6]
            "Düstermarschen", -- [7]
            "Feralas", -- [8]
            "Hauptstadt", -- [9]
            "Marschen von Dustwallow", -- [10]
            "Moonglade", -- [11]
            "Mulgore", -- [12]
            "Silithus", -- [13]
            "Steinkrallengebirge", -- [14]
            "Tanaris", -- [15]
            "Tausend Nadeln", -- [16]
            "Teldrassil", -- [17]
            "Teufelswald", -- [18]
            "Un'Goro-Krater", -- [19]
            "Winterspring", -- [20]
            "Darnassus", -- [20]
            "Orgrimmar", -- [20]
            "Donnerfels", -- [20]
            ["Moonglade"] = {
               "s;Kalimdor;Moonglade;Der Elune'ara See;Die Stormrage Grabhügel", -- [1]
               "s;Kalimdor;Moonglade;Der Elune'ara See;Nighthaven", -- [2]
               "s;Kalimdor;Moonglade;Der Elune'ara See;Schrein von Remulos", -- [3]
               ["s;Kalimdor;Moonglade;Der Elune'ara See;Schrein von Remulos"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2215.45,
                  ["worldX"] = 7856.18,
                  ["areaId"] = 2362,
               },
               ["s;Kalimdor;Moonglade;Der Elune'ara See;Nighthaven"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2491.77,
                  ["worldX"] = 7961.75,
                  ["areaId"] = 2361,
               },
               ["s;Kalimdor;Moonglade;Der Elune'ara See;Die Stormrage Grabhügel"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2951.72,
                  ["worldX"] = 7564.51,
                  ["areaId"] = 2363,
               },
            },
            ["Hauptstadt"] = {
               "s;Kalimdor;Hauptstadt;Darnassus", -- [1]
               "s;Kalimdor;Hauptstadt;Orgrimmar", -- [2]
               "s;Kalimdor;Hauptstadt;Thunder Bluff", -- [3]
               ["s;Kalimdor;Hauptstadt;Thunder Bluff"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -29.4214,
                  ["worldX"] = -1205.41,
                  ["areaId"] = 1638,
               },
               ["s;Kalimdor;Hauptstadt;Orgrimmar"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -4371.16,
                  ["worldX"] = 1381.77,
                  ["areaId"] = 1637,
               },
               ["s;Kalimdor;Hauptstadt;Darnassus"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2254.5,
                  ["worldX"] = 9951.75,
                  ["areaId"] = 1657,
               },
            },
            ["Winterspring"] = {
               "s;Kalimdor;Winterspring;Die heißen Quellen von Frostfire;Holzschlundfeste B", -- [1]
               "s;Kalimdor;Winterspring;Everlook;Mondschreckensbau", -- [2]
               "s;Kalimdor;Winterspring;Everlook", -- [3]
               "s;Kalimdor;Winterspring;Kel'Therilsee;Die Ruinen von Kel'Theril", -- [4]
               "s;Kalimdor;Winterspring;Mazthoril;Dun Mandarr", -- [5]
               ["s;Kalimdor;Winterspring;Kel'Therilsee;Die Ruinen von Kel'Theril"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -4304.99,
                  ["worldX"] = 6426.76,
                  ["areaId"] = 2252,
               },
               ["s;Kalimdor;Winterspring;Everlook;Mondschreckensbau"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -4631.57,
                  ["worldX"] = 7123.02,
                  ["areaId"] = 3139,
               },
               ["s;Kalimdor;Winterspring;Everlook"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -4662.5,
                  ["worldX"] = 6723.46,
                  ["areaId"] = 2255,
               },
               ["s;Kalimdor;Winterspring;Mazthoril;Dun Mandarr"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -4507.31,
                  ["worldX"] = 5718.83,
                  ["areaId"] = 2248,
               },
               ["s;Kalimdor;Winterspring;Die heißen Quellen von Frostfire;Holzschlundfeste B"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2298.18,
                  ["worldX"] = 6900.63,
                  ["areaId"] = 1769,
               },
            },
            ["Eschental"] = {
               "s;Kalimdor;Eschental;Astranaar", -- [1]
               "s;Kalimdor;Eschental;Der Zoramstrand;Zoram'gar-Außenposten", -- [2]
               "s;Kalimdor;Eschental;Fallenskysee;Außenposten der Silverwing", -- [3]
               "s;Kalimdor;Eschental;Fallenskysee;Der Dor'danil-Grabhügel", -- [4]
               "s;Kalimdor;Eschental;Fallenskysee;Hain der Silverwing", -- [5]
               "s;Kalimdor;Eschental;Fallenskysee;Lager der Warsongarbeiter", -- [6]
               "s;Kalimdor;Eschental;Felfire Hill;Demonfall-Canyon", -- [7]
               "s;Kalimdor;Eschental;Maestras Posten;Bathrans Schlupfwinkel", -- [8]
               "s;Kalimdor;Eschental;Maestras Posten;Die Ruinen von Ordil'Aran", -- [9]
               "s;Kalimdor;Eschental;Mystralsee;Blutreißers Lager", -- [10]
               "s;Kalimdor;Eschental;Mystralsee;Der Steinkrallenpfad A", -- [11]
               "s;Kalimdor;Eschental;Mystralsee;Laubtatzenlichtung", -- [12]
               "s;Kalimdor;Eschental;Mystralsee;Silberwindzuflucht", -- [13]
               "s;Kalimdor;Eschental;Night Run;Der Falfarren", -- [14]
               "s;Kalimdor;Eschental;Satyrnaar;Forest Song", -- [15]
               "s;Kalimdor;Eschental;Satyrnaar;Xavian", -- [16]
               "s;Kalimdor;Eschental;Splintertreeposten", -- [17]
               ["s;Kalimdor;Eschental;Satyrnaar;Xavian"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2822.67,
                  ["worldX"] = 2936.56,
                  ["areaId"] = 429,
               },
               ["s;Kalimdor;Eschental;Satyrnaar;Forest Song"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -3287.54,
                  ["worldX"] = 2880.33,
                  ["areaId"] = 2358,
               },
               ["s;Kalimdor;Eschental;Astranaar"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -382.391,
                  ["worldX"] = 2720.43,
                  ["areaId"] = 415,
               },
               ["s;Kalimdor;Eschental;Fallenskysee;Lager der Warsongarbeiter"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2463.94,
                  ["worldX"] = 1575.91,
                  ["areaId"] = 3177,
               },
               ["s;Kalimdor;Eschental;Maestras Posten;Bathrans Schlupfwinkel"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -161.305,
                  ["worldX"] = 3827.37,
                  ["areaId"] = 411,
               },
               ["s;Kalimdor;Eschental;Felfire Hill;Demonfall-Canyon"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -3150.99,
                  ["worldX"] = 1702.45,
                  ["areaId"] = 435,
               },
               ["s;Kalimdor;Eschental;Mystralsee;Silberwindzuflucht"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1190.25,
                  ["worldX"] = 2130.27,
                  ["areaId"] = 420,
               },
               ["s;Kalimdor;Eschental;Maestras Posten;Die Ruinen von Ordil'Aran"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -119.601,
                  ["worldX"] = 3493.89,
                  ["areaId"] = 412,
               },
               ["s;Kalimdor;Eschental;Fallenskysee;Der Dor'danil-Grabhügel"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2678.36,
                  ["worldX"] = 1776.23,
                  ["areaId"] = 432,
               },
               ["s;Kalimdor;Eschental;Splintertreeposten"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2564.67,
                  ["worldX"] = 2286.41,
                  ["areaId"] = 431,
               },
               ["s;Kalimdor;Eschental;Fallenskysee;Hain der Silverwing"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1858.93,
                  ["worldX"] = 1462.48,
                  ["areaId"] = 3319,
               },
               ["s;Kalimdor;Eschental;Fallenskysee;Außenposten der Silverwing"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2065.15,
                  ["worldX"] = 1776.64,
                  ["areaId"] = 2360,
               },
               ["s;Kalimdor;Eschental;Night Run;Der Falfarren"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2222.91,
                  ["worldX"] = 2231.21,
                  ["areaId"] = 433,
               },
               ["s;Kalimdor;Eschental;Mystralsee;Blutreißers Lager"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1465.1,
                  ["worldX"] = 1612.52,
                  ["areaId"] = 2357,
               },
               ["s;Kalimdor;Eschental;Der Zoramstrand;Zoram'gar-Außenposten"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1010.16,
                  ["worldX"] = 3362.22,
                  ["areaId"] = 2897,
               },
               ["s;Kalimdor;Eschental;Mystralsee;Laubtatzenlichtung"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1444.96,
                  ["worldX"] = 2291.29,
                  ["areaId"] = 2359,
               },
               ["s;Kalimdor;Eschental;Mystralsee;Der Steinkrallenpfad A"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -732.677,
                  ["worldX"] = 1930.26,
                  ["areaId"] = 1276,
               },
            },
            ["Teldrassil"] = {
               "s;Kalimdor;Teldrassil;Ban'ethil Hollow;Grabhügel von Ban'ethil", -- [1]
               "s;Kalimdor;Teldrassil;Dolanaar;Teufelsfels", -- [2]
               "s;Kalimdor;Teldrassil;Dolanaar", -- [3]
               "s;Kalimdor;Teldrassil;Shadowglen;Aldrassil A", -- [4]
               "s;Kalimdor;Teldrassil;Shadowglen;Schattenweberhöhle", -- [5]
               "s;Kalimdor;Teldrassil;Wellspringsee;Die Kluft", -- [6]
               ["s;Kalimdor;Teldrassil;Shadowglen;Aldrassil A"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -805.993,
                  ["worldX"] = 10462.7,
                  ["areaId"] = 256,
               },
               ["s;Kalimdor;Teldrassil;Dolanaar;Teufelsfels"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1031.2,
                  ["worldX"] = 10050.6,
                  ["areaId"] = 258,
               },
               ["s;Kalimdor;Teldrassil;Wellspringsee;Die Kluft"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1200.62,
                  ["worldX"] = 10316.4,
                  ["areaId"] = 263,
               },
               ["s;Kalimdor;Teldrassil;Dolanaar"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -949.897,
                  ["worldX"] = 9787.99,
                  ["areaId"] = 186,
               },
               ["s;Kalimdor;Teldrassil;Ban'ethil Hollow;Grabhügel von Ban'ethil"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1557.41,
                  ["worldX"] = 9864.17,
                  ["areaId"] = 262,
               },
               ["s;Kalimdor;Teldrassil;Shadowglen;Schattenweberhöhle"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -921.301,
                  ["worldX"] = 10756.2,
                  ["areaId"] = 257,
               },
            },
            ["Mulgore"] = {
               "s;Kalimdor;Mulgore;Bloodhoof", -- [1]
               "s;Kalimdor;Mulgore;Camp Narache", -- [2]
               "s;Kalimdor;Mulgore;Die goldenen Ebenen;Mine der Venture Co,", -- [3]
               ["s;Kalimdor;Mulgore;Die goldenen Ebenen;Mine der Venture Co,"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1036.19,
                  ["worldX"] = -1501.49,
                  ["areaId"] = 360,
               },
               ["s;Kalimdor;Mulgore;Camp Narache"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -253.607,
                  ["worldX"] = -2906.49,
                  ["areaId"] = 221,
               },
               ["s;Kalimdor;Mulgore;Bloodhoof"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -394.981,
                  ["worldX"] = -2323.92,
                  ["areaId"] = 222,
               },
            },
            ["Steinkrallengebirge"] = {
               "s;Kalimdor;Steinkrallengebirge;Der Steinkrallengipfel;Der Krallenbau", -- [1]
               "s;Kalimdor;Steinkrallengebirge;Der Steinkrallengipfel", -- [2]
               "s;Kalimdor;Steinkrallengebirge;Die Scherwindklippe;Der Steinkrallenpfad B", -- [3]
               "s;Kalimdor;Steinkrallengebirge;Die Scherwindklippe;Felskesselsee", -- [4]
               "s;Kalimdor;Steinkrallengebirge;Die Scherwindklippe;Scherwindmine", -- [5]
               "s;Kalimdor;Steinkrallengebirge;Sishircanyon;Sishircanyon", -- [6]
               "s;Kalimdor;Steinkrallengebirge;Sonnenfels", -- [7]
               ["s;Kalimdor;Steinkrallengebirge;Die Scherwindklippe;Der Steinkrallenpfad B"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -576.57,
                  ["worldX"] = 1531.94,
                  ["areaId"] = 1277,
               },
               ["s;Kalimdor;Steinkrallengebirge;Der Steinkrallengipfel;Der Krallenbau"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1792.39,
                  ["worldX"] = 2416.89,
                  ["areaId"] = 468,
               },
               ["s;Kalimdor;Steinkrallengebirge;Sishircanyon;Sishircanyon"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -624.05,
                  ["worldX"] = 515.845,
                  ["areaId"] = 2541,
               },
               ["s;Kalimdor;Steinkrallengebirge;Der Steinkrallengipfel"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1449.71,
                  ["worldX"] = 2658.78,
                  ["areaId"] = 467,
               },
               ["s;Kalimdor;Steinkrallengebirge;Die Scherwindklippe;Scherwindmine"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -358.9,
                  ["worldX"] = 981.949,
                  ["areaId"] = 2160,
               },
               ["s;Kalimdor;Steinkrallengebirge;Sonnenfels"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -910.974,
                  ["worldX"] = 936.308,
                  ["areaId"] = 460,
               },
               ["s;Kalimdor;Steinkrallengebirge;Die Scherwindklippe;Felskesselsee"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -70.1338,
                  ["worldX"] = 1543.57,
                  ["areaId"] = 463,
               },
            },
            ["Marschen von Dustwallow"] = {
               "s;Kalimdor;Marschen von Dustwallow;Brackenwall;Blaumoor", -- [1]
               "s;Kalimdor;Marschen von Dustwallow;Brackenwall;Brackenwall", -- [2]
               "s;Kalimdor;Marschen von Dustwallow;Brackenwall;Graunebelhöhlen", -- [3]
               "s;Kalimdor;Marschen von Dustwallow;Brackenwall;Nordwacht", -- [4]
               "s;Kalimdor;Marschen von Dustwallow;Das Drachendüster;Die Stonemaul Ruinen", -- [5]
               "s;Kalimdor;Marschen von Dustwallow;Der Drachensumpf;Aschenschwingens Bau", -- [6]
               "s;Kalimdor;Marschen von Dustwallow;Der Drachensumpf;Onyxias Hort", -- [7]
               "s;Kalimdor;Marschen von Dustwallow;Der Drachensumpf;Tidefury-Bucht", -- [8]
               "s;Kalimdor;Marschen von Dustwallow;Der Flammenbau;Blutsumpfbau", -- [9]
               "s;Kalimdor;Marschen von Dustwallow;Der Morast;Die verlassene Wacht", -- [10]
               "s;Kalimdor;Marschen von Dustwallow;Der Morast;Gasthaus Zur süßen Ruh", -- [11]
               "s;Kalimdor;Marschen von Dustwallow;Die Nijelspitze", -- [12]
               "s;Kalimdor;Marschen von Dustwallow;Hexenhügel;Späherwacht", -- [13]
               "s;Kalimdor;Marschen von Dustwallow;Hexenhügel;Swamplight-Anwesen", -- [14]
               ["s;Kalimdor;Marschen von Dustwallow;Die Nijelspitze"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1308.24,
                  ["worldX"] = 202.521,
                  ["areaId"] = 608,
               },
               ["s;Kalimdor;Marschen von Dustwallow;Hexenhügel;Späherwacht"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -4109.08,
                  ["worldX"] = -3476.59,
                  ["areaId"] = 503,
               },
               ["s;Kalimdor;Marschen von Dustwallow;Der Morast;Die verlassene Wacht"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2862.15,
                  ["worldX"] = -3925.5,
                  ["areaId"] = 506,
               },
               ["s;Kalimdor;Marschen von Dustwallow;Der Drachensumpf;Aschenschwingens Bau"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -3832.99,
                  ["worldX"] = -4987.73,
                  ["areaId"] = 2158,
               },
               ["s;Kalimdor;Marschen von Dustwallow;Hexenhügel;Swamplight-Anwesen"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -3893.5,
                  ["worldX"] = -2949.47,
                  ["areaId"] = 497,
               },
               ["s;Kalimdor;Marschen von Dustwallow;Der Flammenbau;Blutsumpfbau"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2639.53,
                  ["worldX"] = -4335.04,
                  ["areaId"] = 498,
               },
               ["s;Kalimdor;Marschen von Dustwallow;Der Morast;Gasthaus Zur süßen Ruh"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2535.18,
                  ["worldX"] = -3723.63,
                  ["areaId"] = 403,
               },
               ["s;Kalimdor;Marschen von Dustwallow;Brackenwall;Nordwacht"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -3429.99,
                  ["worldX"] = -2884.79,
                  ["areaId"] = 504,
               },
               ["s;Kalimdor;Marschen von Dustwallow;Der Drachensumpf;Tidefury-Bucht"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -4062.71,
                  ["worldX"] = -4300.98,
                  ["areaId"] = 517,
               },
               ["s;Kalimdor;Marschen von Dustwallow;Brackenwall;Brackenwall"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2880.71,
                  ["worldX"] = -3132.98,
                  ["areaId"] = 496,
               },
               ["s;Kalimdor;Marschen von Dustwallow;Der Drachensumpf;Onyxias Hort"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -3720.58,
                  ["worldX"] = -4698.06,
                  ["areaId"] = 2159,
               },
               ["s;Kalimdor;Marschen von Dustwallow;Brackenwall;Graunebelhöhlen"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2722.81,
                  ["worldX"] = -2829.79,
                  ["areaId"] = 499,
               },
               ["s;Kalimdor;Marschen von Dustwallow;Brackenwall;Blaumoor"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -3087.58,
                  ["worldX"] = -2685.32,
                  ["areaId"] = 507,
               },
               ["s;Kalimdor;Marschen von Dustwallow;Das Drachendüster;Die Stonemaul Ruinen"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -3321.15,
                  ["worldX"] = -4346.02,
                  ["areaId"] = 508,
               },
            },
            ["Desolace"] = {
               "s;Kalimdor;Desolace;Das Tal der Speere;Maraudon", -- [1]
               "s;Kalimdor;Desolace;Der Kodofriedhof;Geistwandlerposten", -- [2]
               "s;Kalimdor;Desolace;Gelkis;Bolgans Loch", -- [3]
               "s;Kalimdor;Desolace;Mannorocs Koven;Scrabblescrews Lager", -- [4]
               "s;Kalimdor;Desolace;Mannorocs Koven;Tal der Knochen", -- [5]
               "s;Kalimdor;Desolace;Shadowprey", -- [6]
               ["s;Kalimdor;Desolace;Der Kodofriedhof;Geistwandlerposten"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1736.67,
                  ["worldX"] = -1224.06,
                  ["areaId"] = 597,
               },
               ["s;Kalimdor;Desolace;Gelkis;Bolgans Loch"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2499.6,
                  ["worldX"] = -2281.95,
                  ["areaId"] = 600,
               },
               ["s;Kalimdor;Desolace;Mannorocs Koven;Tal der Knochen"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1513.55,
                  ["worldX"] = -2251.19,
                  ["areaId"] = 2657,
               },
               ["s;Kalimdor;Desolace;Mannorocs Koven;Scrabblescrews Lager"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1493.13,
                  ["worldX"] = -1407.87,
                  ["areaId"] = 2617,
               },
               ["s;Kalimdor;Desolace;Das Tal der Speere;Maraudon"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 349,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2918.45,
                  ["worldX"] = -1422.62,
                  ["areaId"] = 2100,
               },
               ["s;Kalimdor;Desolace;Shadowprey"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -3097.92,
                  ["worldX"] = -1657.85,
                  ["areaId"] = 2408,
               },
            },
            ["Tanaris"] = {
               "s;Kalimdor;Tanaris;Gadgetzan", -- [1]
               "s;Kalimdor;Tanaris;Lost-Rigger-Bucht;Wellenschreiterstrand", -- [2]
               "s;Kalimdor;Tanaris;Tal der Behüter;Uldum", -- [3]
               ["s;Kalimdor;Tanaris;Gadgetzan"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -3752.11,
                  ["worldX"] = -7139.15,
                  ["areaId"] = 976,
               },
               ["s;Kalimdor;Tanaris;Lost-Rigger-Bucht;Wellenschreiterstrand"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -4878.96,
                  ["worldX"] = -7693.45,
                  ["areaId"] = 988,
               },
               ["s;Kalimdor;Tanaris;Tal der Behüter;Uldum"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2787.2,
                  ["worldX"] = -9635.41,
                  ["areaId"] = 989,
               },
            },
            ["Un'Goro-Krater"] = {
               "s;Kalimdor;Un'Goro-Krater;Teergruben von Lakkari;Fungal Rock", -- [1]
               "s;Kalimdor;Un'Goro-Krater;Teergruben von Lakkari;Marshals Zuflucht", -- [2]
               ["s;Kalimdor;Un'Goro-Krater;Teergruben von Lakkari;Marshals Zuflucht"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1078.89,
                  ["worldX"] = -6143.21,
                  ["areaId"] = 541,
               },
               ["s;Kalimdor;Un'Goro-Krater;Teergruben von Lakkari;Fungal Rock"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1836.52,
                  ["worldX"] = -6370.15,
                  ["areaId"] = 542,
               },
            },
            ["Düstermarschen"] = {
               "s;Kalimdor;Düstermarschen;Die Insel Theramore", -- [1]
               ["s;Kalimdor;Düstermarschen;Die Insel Theramore"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -4388.51,
                  ["worldX"] = -3680.17,
                  ["areaId"] = 513,
               },
            },
            ["Azshara"] = {
               "s;Kalimdor;Azshara;Die Bucht der Stürme;Hetaeras Gelege", -- [1]
               "s;Kalimdor;Azshara;Die Bucht der Stürme;Schuppenbarts Höhle", -- [2]
               "s;Kalimdor;Azshara;Die Ruinen von Eldarath;Tempel von Zin-Malor", -- [3]
               "s;Kalimdor;Azshara;Die verfallenen Gegenden;Rethress Sanktum", -- [4]
               "s;Kalimdor;Azshara;Shadowsong-Schrein;Talrendisspitze", -- [5]
               ["s;Kalimdor;Azshara;Die verfallenen Gegenden;Rethress Sanktum"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -6438.33,
                  ["worldX"] = 2195.67,
                  ["areaId"] = 3138,
               },
               ["s;Kalimdor;Azshara;Die Bucht der Stürme;Hetaeras Gelege"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -6232.79,
                  ["worldX"] = 3556.64,
                  ["areaId"] = 1222,
               },
               ["s;Kalimdor;Azshara;Die Bucht der Stürme;Schuppenbarts Höhle"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -6043.45,
                  ["worldX"] = 3705.1,
                  ["areaId"] = 3140,
               },
               ["s;Kalimdor;Azshara;Shadowsong-Schrein;Talrendisspitze"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -3869.25,
                  ["worldX"] = 2707.72,
                  ["areaId"] = 3137,
               },
               ["s;Kalimdor;Azshara;Die Ruinen von Eldarath;Tempel von Zin-Malor"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -5359.12,
                  ["worldX"] = 3549.15,
                  ["areaId"] = 1223,
               },
            },
            ["Feralas"] = {
               --[[
               "s;Kalimdor;Feralas;Außenposten der Gordunni;Lariss' Pavillon", -- [1]
               "s;Kalimdor;Feralas;Die Insel des Schreckens;Shalzarus Unterschlupf", -- [2]
               "s;Kalimdor;Feralas;Die verwundene Tiefe;Waldpfotenbau", -- [3]
               "s;Kalimdor;Feralas;Die verwundene Tiefe;Waldpfotenhügel", -- [4]
               "s;Kalimdor;Feralas;Die Zwillingskolosse;Wutschrammfeste", -- [5]
               "s;Kalimdor;Feralas;Festung Feathermoon", -- [6]
               "s;Kalimdor;Feralas;Ruinen von Solarsal;Ruinen von Solarsal", -- [7]
               "s;Kalimdor;Feralas;Thalanaar", -- [8]
               ["s;Kalimdor;Feralas;Die verwundene Tiefe;Waldpfotenhügel"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -199.275,
                  ["worldX"] = -4915.81,
                  ["areaId"] = 2519,
               },
               ["s;Kalimdor;Feralas;Thalanaar"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -779.474,
                  ["worldX"] = -4510.03,
                  ["areaId"] = 489,
               },
               ["s;Kalimdor;Feralas;Die Zwillingskolosse;Wutschrammfeste"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1738.94,
                  ["worldX"] = -3842.71,
                  ["areaId"] = 1115,
               },
               ["s;Kalimdor;Feralas;Außenposten der Gordunni;Lariss' Pavillon"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -81.5525,
                  ["worldX"] = -4052.72,
                  ["areaId"] = 2518,
               },
               ["s;Kalimdor;Feralas;Ruinen von Solarsal;Ruinen von Solarsal"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -3616.63,
                  ["worldX"] = -4852.91,
                  ["areaId"] = 1117,
               },
               ["s;Kalimdor;Feralas;Festung Feathermoon"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -3276.74,
                  ["worldX"] = -4434.99,
                  ["areaId"] = 1116,
               },
               ["s;Kalimdor;Feralas;Die Insel des Schreckens;Shalzarus Unterschlupf"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -3622.79,
                  ["worldX"] = -5492.37,
                  ["areaId"] = 3117,
               },
               ["s;Kalimdor;Feralas;Die verwundene Tiefe;Waldpfotenbau"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -863.048,
                  ["worldX"] = -4835.2,
                  ["areaId"] = 2520,
               },]]
            },
            ["Silithus"] = {
               "s;Kalimdor;Silithus;Basislager der Twilight;Basislager der Twilight", -- [1]
               "s;Kalimdor;Silithus;Bau des Regalschwarms;Ortells Unterschlupf", -- [2]
               "s;Kalimdor;Silithus;Bau des Zoraschwarms;Twilight-Außenposten", -- [3]
               "s;Kalimdor;Silithus;Bronzebeards Lager;Bronzebeards Lager", -- [4]
               "s;Kalimdor;Silithus;Burg Cenarius;Die Schwarmsäule", -- [5]
               "s;Kalimdor;Silithus;Burg Cenarius;Knochen von Grakkarond", -- [6]
               "s;Kalimdor;Silithus;Burg Cenarius", -- [7]
               "s;Kalimdor;Silithus;Das Kristalltal;Verwüsteter Twilight-Stützpunkt", -- [8]
               "s;Kalimdor;Silithus;Staghelms Stätte;Kavernen der Twilight", -- [9]
               "s;Kalimdor;Silithus;Staghelms Stätte;Staghelms Stätte", -- [10]
               "s;Kalimdor;Silithus;Südwindposten;Heldenwacht", -- [11]
               "s;Kalimdor;Silithus;Twilight-Posten;Twilight-Posten", -- [12]
               ["s;Kalimdor;Silithus;Bau des Regalschwarms;Ortells Unterschlupf"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -226.396,
                  ["worldX"] = -7586.17,
                  ["areaId"] = 3447,
               },
               ["s;Kalimdor;Silithus;Burg Cenarius;Knochen von Grakkarond"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -874.224,
                  ["worldX"] = -7234.61,
                  ["areaId"] = 3257,
               },
               ["s;Kalimdor;Silithus;Burg Cenarius;Die Schwarmsäule"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -731.852,
                  ["worldX"] = -7066.79,
                  ["areaId"] = 3097,
               },
               ["s;Kalimdor;Silithus;Bau des Zoraschwarms;Twilight-Außenposten"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1833.28,
                  ["worldX"] = -7929.11,
                  ["areaId"] = 3099,
               },
               ["s;Kalimdor;Silithus;Das Kristalltal;Verwüsteter Twilight-Stützpunkt"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1766.95,
                  ["worldX"] = -6206.25,
                  ["areaId"] = 3100,
               },
               ["s;Kalimdor;Silithus;Basislager der Twilight;Basislager der Twilight"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1195.01,
                  ["worldX"] = -6996.15,
                  ["areaId"] = 2739,
               },
               ["s;Kalimdor;Silithus;Bronzebeards Lager;Bronzebeards Lager"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1105.84,
                  ["worldX"] = -8021.76,
                  ["areaId"] = 3427,
               },
               ["s;Kalimdor;Silithus;Südwindposten;Heldenwacht"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -292.647,
                  ["worldX"] = -6404.33,
                  ["areaId"] = 3077,
               },
               ["s;Kalimdor;Silithus;Twilight-Posten;Twilight-Posten"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1636.32,
                  ["worldX"] = -6740.04,
                  ["areaId"] = 3098,
               },
               ["s;Kalimdor;Silithus;Staghelms Stätte;Staghelms Stätte"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -97.5554,
                  ["worldX"] = -6517.49,
                  ["areaId"] = 3426,
               },
               ["s;Kalimdor;Silithus;Staghelms Stätte;Kavernen der Twilight"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -136.591,
                  ["worldX"] = -6310.14,
                  ["areaId"] = 3446,
               },
               ["s;Kalimdor;Silithus;Burg Cenarius"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -718.398,
                  ["worldX"] = -6886.15,
                  ["areaId"] = 3425,
               },
            },
            ["Teufelswald"] = {
               "s;Kalimdor;Teufelswald;Der Eisenwald;Eisenstammhöhle", -- [1]
               "s;Kalimdor;Teufelswald;Die Blutgiftfälle;Blutgiftposten", -- [2]
               "s;Kalimdor;Teufelswald;Revier der Teufelspfoten;Holzschlundfeste A", -- [3]
               ["s;Kalimdor;Teufelswald;Revier der Teufelspfoten;Holzschlundfeste A"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2097.68,
                  ["worldX"] = 6817.78,
                  ["areaId"] = 1216,
               },
               ["s;Kalimdor;Teufelswald;Die Blutgiftfälle;Blutgiftposten"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -353.403,
                  ["worldX"] = 5111.98,
                  ["areaId"] = 1997,
               },
               ["s;Kalimdor;Teufelswald;Der Eisenwald;Eisenstammhöhle"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1571,
                  ["worldX"] = 6481.87,
                  ["areaId"] = 1768,
               },
            },
            ["Tausend Nadeln"] = {
               "s;Kalimdor;Tausend Nadeln;Camp E'thok;Weißgipfelposten", -- [1]
               "s;Kalimdor;Tausend Nadeln;Der kreischende Canyon;Bau der Wildfedern", -- [2]
               "s;Kalimdor;Tausend Nadeln;Die schimmernde Ebene;Die Rustmaul-Grabungsstätte", -- [3]
               "s;Kalimdor;Tausend Nadeln;Die schimmernde Ebene;Illusionenrennbahn", -- [4]
               "s;Kalimdor;Tausend Nadeln;Die schimmernde Ebene;Ruinen von Tahonda", -- [5]
               "s;Kalimdor;Tausend Nadeln;Die schimmernde Ebene;Weazels Krater", -- [6]
               "s;Kalimdor;Tausend Nadeln;Düsterwolkengipfel;Düsterwolkengipfel", -- [7]
               "s;Kalimdor;Tausend Nadeln;Freiwindposten", -- [8]
               "s;Kalimdor;Tausend Nadeln;Schlucht der heulenden Winde;Eisensteinlager", -- [9]
               "s;Kalimdor;Tausend Nadeln;Spalthufklippe;Der Wetterwinkel", -- [10]
               "s;Kalimdor;Tausend Nadeln;Spalthufklippe;Spalthufhöhle", -- [11]
               ["s;Kalimdor;Tausend Nadeln;Die schimmernde Ebene;Illusionenrennbahn"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -3973.12,
                  ["worldX"] = -6239.42,
                  ["areaId"] = 2240,
               },
               ["s;Kalimdor;Tausend Nadeln;Der kreischende Canyon;Bau der Wildfedern"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1636.27,
                  ["worldX"] = -5466.71,
                  ["areaId"] = 487,
               },
               ["s;Kalimdor;Tausend Nadeln;Spalthufklippe;Spalthufhöhle"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2367.61,
                  ["worldX"] = -5065.61,
                  ["areaId"] = 1557,
               },
               ["s;Kalimdor;Tausend Nadeln;Schlucht der heulenden Winde;Eisensteinlager"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -3412.38,
                  ["worldX"] = -5848.05,
                  ["areaId"] = 3037,
               },
               ["s;Kalimdor;Tausend Nadeln;Die schimmernde Ebene;Ruinen von Tahonda"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -3894.97,
                  ["worldX"] = -6569.91,
                  ["areaId"] = 3039,
               },
               ["s;Kalimdor;Tausend Nadeln;Freiwindposten"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2445.5,
                  ["worldX"] = -5454.07,
                  ["areaId"] = 484,
               },
               ["s;Kalimdor;Tausend Nadeln;Die schimmernde Ebene;Weazels Krater"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -3899.53,
                  ["worldX"] = -5799.94,
                  ["areaId"] = 3038,
               },
               ["s;Kalimdor;Tausend Nadeln;Die schimmernde Ebene;Die Rustmaul-Grabungsstätte"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -3449.15,
                  ["worldX"] = -6490.61,
                  ["areaId"] = 479,
               },
               ["s;Kalimdor;Tausend Nadeln;Spalthufklippe;Der Wetterwinkel"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2794.53,
                  ["worldX"] = -5213.85,
                  ["areaId"] = 488,
               },
               ["s;Kalimdor;Tausend Nadeln;Camp E'thok;Weißgipfelposten"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1375.5,
                  ["worldX"] = -4917.35,
                  ["areaId"] = 2237,
               },
               ["s;Kalimdor;Tausend Nadeln;Düsterwolkengipfel;Düsterwolkengipfel"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1919.44,
                  ["worldX"] = -5086.21,
                  ["areaId"] = 2097,
               },
            },
            ["Das Brachland"] = {
               "s;Kalimdor;Das Brachland;Der Mor'shan-Schutzwall;Mor'shan-Stützpunkt", -- [1]
               "s;Kalimdor;Das Brachland;Die blühende Oase;Die Höhlen des Wehklagens", -- [2]
               "s;Kalimdor;Das Brachland;Prügel-Eiland", -- [3]
               "s;Kalimdor;Das Brachland;Camp Mojache", -- [4]
               "s;Kalimdor;Das Brachland;Camp Taurajo", -- [5]
               "s;Kalimdor;Das Brachland;Crossroads", -- [6]
               "s;Kalimdor;Das Brachland;Ratchet", -- [7]
               ["s;Kalimdor;Das Brachland;Die blühende Oase;Die Höhlen des Wehklagens"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 43,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2037,
                  ["worldX"] = -837.968,
                  ["areaId"] = 718,
               },
               ["s;Kalimdor;Das Brachland;Der Mor'shan-Schutzwall;Mor'shan-Stützpunkt"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2113.34,
                  ["worldX"] = 1035.13,
                  ["areaId"] = 1599,
               },
               ["s;Kalimdor;Das Brachland;Ratchet"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -3680.07,
                  ["worldX"] = -951.364,
                  ["areaId"] = 392,
               },
               ["s;Kalimdor;Das Brachland;Crossroads"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2652.15,
                  ["worldX"] = -455.9,
                  ["areaId"] = 380,
               },
               ["s;Kalimdor;Das Brachland;Prügel-Eiland"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -4329.2,
                  ["worldX"] = -1668.51,
                  ["areaId"] = 720,
               },
               ["s;Kalimdor;Das Brachland;Camp Taurajo"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1921.67,
                  ["worldX"] = -2352.66,
                  ["areaId"] = 378,
               },
               ["s;Kalimdor;Das Brachland;Camp Mojache"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -215.611,
                  ["worldX"] = -4394.98,
                  ["areaId"] = 1099,
               },
            },
            ["Durotar"] = {
               "s;Kalimdor;Durotar;Der Höhlenbau", -- [1]
               "s;Kalimdor;Durotar;Donnergrat;Tor'krens Hof", -- [2]
               "s;Kalimdor;Durotar;Klingenhügel;Klingenhügel", -- [3]
               "s;Kalimdor;Durotar;Klingenschlucht;Klingenschlucht", -- [4]
               "s;Kalimdor;Durotar;Sen'jin;Sen'jin", -- [5]
               ["s;Kalimdor;Durotar;Der Höhlenbau"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -4202.92,
                  ["worldX"] = -604.098,
                  ["areaId"] = 364,
               },
               ["s;Kalimdor;Durotar;Donnergrat;Tor'krens Hof"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -4242.41,
                  ["worldX"] = 726.297,
                  ["areaId"] = 2979,
               },
               ["s;Kalimdor;Durotar;Klingenschlucht;Klingenschlucht"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -4534.04,
                  ["worldX"] = 636.963,
                  ["areaId"] = 410,
               },
               ["s;Kalimdor;Durotar;Klingenhügel;Klingenhügel"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -4745.52,
                  ["worldX"] = 312.659,
                  ["areaId"] = 362,
               },
               ["s;Kalimdor;Durotar;Sen'jin;Sen'jin"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -4918.24,
                  ["worldX"] = -819.492,
                  ["areaId"] = 367,
               },
            },
            ["Dunkelküste"] = {
               "s;Kalimdor;Dunkelküste;Auberdine", -- [1]
               "s;Kalimdor;Dunkelküste;Cliffspring;Cliffspring Falls", -- [2]
               "s;Kalimdor;Dunkelküste;Der Hain der Uralten;Der Wildbend", -- [3]
               "s;Kalimdor;Dunkelküste;Die Meistergleve;Bau der Schwarzfelle", -- [4]
               ["s;Kalimdor;Dunkelküste;Auberdine"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -411.951,
                  ["worldX"] = 6439.33,
                  ["areaId"] = 442,
               },
               ["s;Kalimdor;Dunkelküste;Cliffspring;Cliffspring Falls"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -662.396,
                  ["worldX"] = 6870.57,
                  ["areaId"] = 445,
               },
               ["s;Kalimdor;Dunkelküste;Der Hain der Uralten;Der Wildbend"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -220.755,
                  ["worldX"] = 5056.04,
                  ["areaId"] = 454,
               },
               ["s;Kalimdor;Dunkelküste;Die Meistergleve;Bau der Schwarzfelle"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -25.6126,
                  ["worldX"] = 4619.42,
                  ["areaId"] = 455,
               },
            },
            ["Darnassus"] = {
               "s;Kalimdor;Hauptstadt;Darnassus", -- [1]
               ["s;Kalimdor;Hauptstadt;Darnassus"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2254.5,
                  ["worldX"] = 9951.75,
                  ["areaId"] = 1657,
               },
            },
            ["Orgrimmar"] = {
               "s;Kalimdor;Hauptstadt;Orgrimmar", -- [2]
               ["s;Kalimdor;Hauptstadt;Orgrimmar"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -4371.16,
                  ["worldX"] = 1381.77,
                  ["areaId"] = 1637,
               },
            },
            ["Donnerfels"] = {
               "s;Kalimdor;Hauptstadt;Thunder Bluff", -- [3]
               ["s;Kalimdor;Hauptstadt;Thunder Bluff"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 1,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -29.4214,
                  ["worldX"] = -1205.41,
                  ["areaId"] = 1638,
               },
            },
         },
         ["Östliche Königreiche"] = {
            "Alteracgebirge", -- [1]
            "Arathihochland", -- [2]
            "Brennende Steppe", -- [3]
            "Dämmerwald", -- [4]
            "Dun Morogh", -- [5]
            "Gebirgspass der Totenwinde", -- [6]
            "Hauptstadt", -- [7]
            "Hinterland", -- [8]
            "Loch Modan", -- [9]
            "Ödland", -- [10]
            "Östliche Pestländer", -- [11]
            "Rotkammgebirge", -- [12]
            "Schlingendorntal", -- [13]
            "Sengende Schlucht", -- [14]
            "Silberwald", -- [15]
            "Sümpfe des Elends", -- [16]
            "Sumpfland", -- [17]
            "Tirisfal", -- [18]
            "Vorgebirge von Hillsbrad", -- [19]
            "Wald von Elwynn", -- [20]
            "Westfall", -- [21]
            "Westliche Pestländer", -- [22]
            "Eisenschmiede", -- [1]
            "Sturmwind", -- [2]
            "Unterstadt", -- [3]
            "Verwüstete Lande",
            ["Verwüstete Lande"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -3389.016357421875,
               ["worldX"] = -10997.69921875,
               ["areaId"] = 4,
            },
            ["Vorgebirge von Hillsbrad"] = {
               "s;Östliche Königreiche;Vorgebirge von Hillsbrad;Southshore", -- [1]
               "s;Östliche Königreiche;Vorgebirge von Hillsbrad;Tarrens Mühle", -- [2]
               ["s;Östliche Königreiche;Vorgebirge von Hillsbrad;Tarrens Mühle"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 560,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -900.562,
                  ["worldX"] = -27.0354,
                  ["areaId"] = 2368,
               },
               ["s;Östliche Königreiche;Vorgebirge von Hillsbrad;Southshore"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 560,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -531.727,
                  ["worldX"] = -803.031,
                  ["areaId"] = 2369,
               },
            },
            ["Hauptstadt"] = {
               "s;Östliche Königreiche;Hauptstadt;Ironforge", -- [1]
               "s;Östliche Königreiche;Hauptstadt;Stormwind", -- [2]
               "s;Östliche Königreiche;Hauptstadt;Undercity", -- [3]
               ["s;Östliche Königreiche;Hauptstadt;Ironforge"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -834.059,
                  ["worldX"] = -5021,
                  ["areaId"] = 1537,
               },
               ["s;Östliche Königreiche;Hauptstadt;Undercity"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -235.699,
                  ["worldX"] = 1849.69,
                  ["areaId"] = 1497,
               },
               ["s;Östliche Königreiche;Hauptstadt;Stormwind"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -364.057,
                  ["worldX"] = -9153.77,
                  ["areaId"] = 1519,
               },
            },
            ["Alteracgebirge"] = {
               "s;Östliche Königreiche;Alteracgebirge;Crushridgehöhle;Slaughter Hollow", -- [1]
               ["s;Östliche Königreiche;Alteracgebirge;Crushridgehöhle;Slaughter Hollow"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -558.217,
                  ["worldX"] = 861.216,
                  ["areaId"] = 283,
               },
            },
            ["Sumpfland"] = {
               "s;Östliche Königreiche;Sumpfland;Der Hafen von Menethil", -- [1]
               "s;Östliche Königreiche;Sumpfland;Dun Algaz", -- [2]
               "s;Östliche Königreiche;Sumpfland;Dun Modr", -- [3]
               "s;Östliche Königreiche;Sumpfland;Tore der Dragonmaw;Grim Batol", -- [4]
               ["s;Östliche Königreiche;Sumpfland;Tore der Dragonmaw;Grim Batol"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -3448.54,
                  ["worldX"] = -4055,
                  ["areaId"] = 1037,
               },
               ["s;Östliche Königreiche;Sumpfland;Dun Modr"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2350.5583,
                  ["worldX"] = -2610.2583,
                  ["areaId"] = 205,
               },
               ["s;Östliche Königreiche;Sumpfland;Dun Algaz"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2373.1401,
                  ["worldX"] = -4191.0234,
                  ["areaId"] = 837,
               },
               ["s;Östliche Königreiche;Sumpfland;Der Hafen von Menethil"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -828.455,
                  ["worldX"] = -3672.7,
                  ["areaId"] = 150,
               },
            },
            ["Gebirgspass der Totenwinde"] = {
               "s;Östliche Königreiche;Gebirgspass der Totenwinde;Das Laster;Das Grosh'gok Lager", -- [1]
               "s;Östliche Königreiche;Gebirgspass der Totenwinde;Die schlummernde Schlucht;Die schlummernde Schlucht", -- [2]
               "s;Östliche Königreiche;Gebirgspass der Totenwinde;Totmannsfurt;Aridens Lager", -- [3]
               "s;Östliche Königreiche;Gebirgspass der Totenwinde;Totmannsfurt;Schlucht der Totenwinde", -- [4]
               ["s;Östliche Königreiche;Gebirgspass der Totenwinde;Totmannsfurt;Aridens Lager"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2141.1,
                  ["worldX"] = -10443.3,
                  ["areaId"] = 2560,
               },
               ["s;Östliche Königreiche;Gebirgspass der Totenwinde;Totmannsfurt;Schlucht der Totenwinde"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1841.05,
                  ["worldX"] = -10572,
                  ["areaId"] = 2558,
               },
               ["s;Östliche Königreiche;Gebirgspass der Totenwinde;Das Laster;Das Grosh'gok Lager"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2335.63,
                  ["worldX"] = -11112.2,
                  ["areaId"] = 2937,
               },
               ["s;Östliche Königreiche;Gebirgspass der Totenwinde;Die schlummernde Schlucht;Die schlummernde Schlucht"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1973.68,
                  ["worldX"] = -10740.8,
                  ["areaId"] = 2938,
               },
            },
            ["Westfall"] = {
               "s;Östliche Königreiche;Westfall;Moonbrook", -- [1]
               "s;Östliche Königreiche;Westfall;Späherkuppe", -- [2]
               ["s;Östliche Königreiche;Westfall;Späherkuppe"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1027.76,
                  ["worldX"] = -10503.7,
                  ["areaId"] = 108,
               },
               ["s;Östliche Königreiche;Westfall;Moonbrook"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1510.168,
                  ["worldX"] = -11017.066,
                  ["areaId"] = 20,
               },
            },
            ["Loch Modan"] = {
               "s;Östliche Königreiche;Loch Modan;Nordtorpass;Station Algaz", -- [1]
               "s;Östliche Königreiche;Loch Modan;Thelsamar", -- [2]
               ["s;Östliche Königreiche;Loch Modan;Thelsamar"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2959.91,
                  ["worldX"] = -5349.27,
                  ["areaId"] = 144,
               },
               ["s;Östliche Königreiche;Loch Modan;Nordtorpass;Station Algaz"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2666.7,
                  ["worldX"] = -4817.79,
                  ["areaId"] = 925,
               },
            },
            ["Arathihochland"] = {
               "s;Östliche Königreiche;Arathihochland;Burg Stromgarde;Der Turm von Arathor", -- [1]
               "s;Östliche Königreiche;Arathihochland;Die Zuflucht", -- [2]
               "s;Östliche Königreiche;Arathihochland;Hammerfall;Schlucht der Trockenstoppel", -- [3]
               "s;Östliche Königreiche;Arathihochland;Hammerfall", -- [4]
               ["s;Östliche Königreiche;Arathihochland;Die Zuflucht"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2526.81,
                  ["worldX"] = -1251.05,
                  ["areaId"] = 320,
               },
               ["s;Östliche Königreiche;Arathihochland;Hammerfall"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -3528.34,
                  ["worldX"] = -991.57,
                  ["areaId"] = 321,
               },
               ["s;Östliche Königreiche;Arathihochland;Burg Stromgarde;Der Turm von Arathor"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1513.16,
                  ["worldX"] = -1778.21,
                  ["areaId"] = 325,
               },
               ["s;Östliche Königreiche;Arathihochland;Hammerfall;Schlucht der Trockenstoppel"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -3827.39,
                  ["worldX"] = -1014.22,
                  ["areaId"] = 318,
               },
            },
            ["Östliche Pestländer"] = {
               "s;Östliche Königreiche;Östliche Pestländer;Nordpassturm", -- [1]
               "s;Östliche Königreiche;Östliche Pestländer;Ostwallturm;Braumanns Mühle", -- [2]
               "s;Östliche Königreiche;Östliche Pestländer;Ostwallturm", -- [3]
               "s;Östliche Königreiche;Östliche Pestländer;Schreckenstal;Terrorweb-Tunnel", -- [4]
               ["s;Östliche Königreiche;Östliche Pestländer;Ostwallturm"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -4796.96,
                  ["worldX"] = 2562.3,
                  ["areaId"] = 2271,
               },
               ["s;Östliche Königreiche;Östliche Pestländer;Ostwallturm;Braumanns Mühle"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -5183.79,
                  ["worldX"] = 2483.98,
                  ["areaId"] = 2269,
               },
               ["s;Östliche Königreiche;Östliche Pestländer;Nordpassturm"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -4376.45,
                  ["worldX"] = 3170.26,
                  ["areaId"] = 2275,
               },
               ["s;Östliche Königreiche;Östliche Pestländer;Schreckenstal;Terrorweb-Tunnel"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2773.9,
                  ["worldX"] = 3035.33,
                  ["areaId"] = 2626,
               },
            },
            ["Dämmerwald"] = {
               "s;Östliche Königreiche;Dämmerwald;Der verlassene Obstgarten;Rolands Verdammnis", -- [1]
               "s;Östliche Königreiche;Dämmerwald;Dunkelhain;Bettlerschlupfwinkel", -- [2]
               "s;Östliche Königreiche;Dämmerwald;Dunkelhain;Dunkelhain", -- [3]
               "s;Östliche Königreiche;Dämmerwald;Rabenflucht", -- [4]
               ["s;Östliche Königreiche;Dämmerwald;Dunkelhain;Bettlerschlupfwinkel"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1538.8,
                  ["worldX"] = -10349.7,
                  ["areaId"] = 576,
               },
               ["s;Östliche Königreiche;Dämmerwald;Rabenflucht"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -310.43338,
                  ["worldX"] = -10752.526,
                  ["areaId"] = 94,
               },
               ["s;Östliche Königreiche;Dämmerwald;Dunkelhain;Dunkelhain"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1170.65,
                  ["worldX"] = -10564.7,
                  ["areaId"] = 42,
               },
               ["s;Östliche Königreiche;Dämmerwald;Der verlassene Obstgarten;Rolands Verdammnis"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1139.98,
                  ["worldX"] = -11076,
                  ["areaId"] = 2161,
               },
            },
            ["Wald von Elwynn"] = {
               "s;Östliche Königreiche;Wald von Elwynn;Abtei von Nordhain;Echokammmine", -- [1]
               "s;Östliche Königreiche;Wald von Elwynn;Abtei von Nordhain;Weinberge von Nordhain", -- [2]
               "s;Östliche Königreiche;Wald von Elwynn;Abtei von Nordhain", -- [3]
               "s;Östliche Königreiche;Wald von Elwynn;Der Waldrand;Weststromgarnison", -- [4]
               "s;Östliche Königreiche;Wald von Elwynn;Goldhain", -- [5]
               "s;Östliche Königreiche;Wald von Elwynn;Spiegelsee", -- [6]
               "s;Östliche Königreiche;Wald von Elwynn;Tiefenschachtmine;Hof der Stonefields", -- [7]
               "s;Östliche Königreiche;Wald von Elwynn;Tiefenschachtmine;Weinberge der Maclures", -- [8]
               "s;Östliche Königreiche;Wald von Elwynn;Turm von Azora;Jaspismine", -- [9]
               ["s;Östliche Königreiche;Wald von Elwynn;Der Waldrand;Weststromgarnison"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -667.327,
                  ["worldX"] = -9615.71,
                  ["areaId"] = 120,
               },
               ["s;Östliche Königreiche;Wald von Elwynn;Abtei von Nordhain"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -179.32834,
                  ["worldX"] = -8896.159,
                  ["areaId"] = 24,
               },
               ["s;Östliche Königreiche;Wald von Elwynn;Goldhain"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -63.521755,
                  ["worldX"] = -9480.089,
                  ["areaId"] = 87,
               },
               ["s;Östliche Königreiche;Wald von Elwynn;Abtei von Nordhain;Echokammmine"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -119.634,
                  ["worldX"] = -8676.57,
                  ["areaId"] = 34,
               },
               ["s;Östliche Königreiche;Wald von Elwynn;Spiegelsee"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -458.427,
                  ["worldX"] = -9389.26,
                  ["areaId"] = 92,
               },
               ["s;Östliche Königreiche;Wald von Elwynn;Tiefenschachtmine;Hof der Stonefields"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -378.19,
                  ["worldX"] = -9901.14,
                  ["areaId"] = 63,
               },
               ["s;Östliche Königreiche;Wald von Elwynn;Turm von Azora;Jaspismine"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -605.891,
                  ["worldX"] = -9184.5,
                  ["areaId"] = 54,
               },
               ["s;Östliche Königreiche;Wald von Elwynn;Abtei von Nordhain;Weinberge von Nordhain"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -333.965,
                  ["worldX"] = -9067.35,
                  ["areaId"] = 59,
               },
               ["s;Östliche Königreiche;Wald von Elwynn;Tiefenschachtmine;Weinberge der Maclures"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -69.1568,
                  ["worldX"] = -9948.39,
                  ["areaId"] = 64,
               },
            },
            ["Tirisfal"] = {
               "s;Östliche Königreiche;Tirisfal;Brill", -- [1]
               "s;Östliche Königreiche;Tirisfal;Deathknell;Nachtwebergrund", -- [2]
               "s;Östliche Königreiche;Tirisfal;Deathknell", -- [3]
               ["s;Östliche Königreiche;Tirisfal;Deathknell"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1588.2028,
                  ["worldX"] = 1879.8323,
                  ["areaId"] = 154,
               },
               ["s;Östliche Königreiche;Tirisfal;Deathknell;Nachtwebergrund"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1829.45,
                  ["worldX"] = 2046.11,
                  ["areaId"] = 155,
               },
               ["s;Östliche Königreiche;Tirisfal;Brill"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -278.41385,
                  ["worldX"] = 2249.85,
                  ["areaId"] = 159,
               },
            },
            ["Sümpfe des Elends"] = {
               "s;Östliche Königreiche;Sümpfe des Elends;Nebelschilfstrand;Nebelschilfposten", -- [1]
               "s;Östliche Königreiche;Sümpfe des Elends;Stagalbog;Stagalboghöhle", -- [2]
               "s;Östliche Königreiche;Sümpfe des Elends;Stonard", -- [3]
               "s;Östliche Königreiche;Sümpfe des Elends;Tränenteich;Der Tempel von Atal'Hakkar", -- [4]
               ["s;Östliche Königreiche;Sümpfe des Elends;Stonard"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -3277.49,
                  ["worldX"] = -10443.7,
                  ["areaId"] = 75,
               },
               ["s;Östliche Königreiche;Sümpfe des Elends;Tränenteich;Der Tempel von Atal'Hakkar"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 109,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -3828.52,
                  ["worldX"] = -10429.9,
                  ["areaId"] = 1477,
               },
               ["s;Östliche Königreiche;Sümpfe des Elends;Stagalbog;Stagalboghöhle"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -3739.01,
                  ["worldX"] = -10803.2,
                  ["areaId"] = 1817,
               },
               ["s;Östliche Königreiche;Sümpfe des Elends;Nebelschilfstrand;Nebelschilfposten"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -4093.43,
                  ["worldX"] = -10854.8,
                  ["areaId"] = 1978,
               },
            },
            ["Rotkammgebirge"] = {
               "s;Östliche Königreiche;Rotkammgebirge;Galardelltal;Der Turm von Ilgalar", -- [1]
               "s;Östliche Königreiche;Rotkammgebirge;Renders Lager;Renders Fels", -- [2]
               "s;Östliche Königreiche;Rotkammgebirge;Rethbanhöhlen", -- [3]
               "s;Östliche Königreiche;Rotkammgebirge;Seenhain", -- [4]
               ["s;Östliche Königreiche;Rotkammgebirge;Renders Lager;Renders Fels"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2290.05,
                  ["worldX"] = -8674.12,
                  ["areaId"] = 998,
               },
               ["s;Östliche Königreiche;Rotkammgebirge;Rethbanhöhlen"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2002.7,
                  ["worldX"] = -8970.76,
                  ["areaId"] = 98,
               },
               ["s;Östliche Königreiche;Rotkammgebirge;Galardelltal;Der Turm von Ilgalar"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -3318.81,
                  ["worldX"] = -9281.33,
                  ["areaId"] = 96,
               },
               ["s;Östliche Königreiche;Rotkammgebirge;Seenhain"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2201.47,
                  ["worldX"] = -9227.69,
                  ["areaId"] = 69,
               },
            },
            ["Sengende Schlucht"] = {
               "s;Östliche Königreiche;Sengende Schlucht;Firewatchgrat;Thoriumspitze", -- [1]
               ["s;Östliche Königreiche;Sengende Schlucht;Firewatchgrat;Thoriumspitze"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1142.76,
                  ["worldX"] = -6513.68,
                  ["areaId"] = 1446,
               },
            },
            ["Schlingendorntal"] = {
               "s;Östliche Königreiche;Schlingendorntal;Booty Bay;Janeirospitze", -- [1]
               "s;Östliche Königreiche;Schlingendorntal;Booty Bay", -- [2]
               "s;Östliche Königreiche;Schlingendorntal;Das Basislager von Grom'gol", -- [3]
               "s;Östliche Königreiche;Schlingendorntal;Die Insel Yojamba", -- [4]
               "s;Östliche Königreiche;Schlingendorntal;Nebeltal;Geisterhöhlenbau", -- [5]
               ["s;Östliche Königreiche;Schlingendorntal;Booty Bay"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -487.139,
                  ["worldX"] = -14383.3,
                  ["areaId"] = 35,
               },
               ["s;Östliche Königreiche;Schlingendorntal;Nebeltal;Geisterhöhlenbau"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -18.3165,
                  ["worldX"] = -13751.4,
                  ["areaId"] = 1742,
               },
               ["s;Östliche Königreiche;Schlingendorntal;Das Basislager von Grom'gol"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -185.734,
                  ["worldX"] = -12378.4,
                  ["areaId"] = 117,
               },
               ["s;Östliche Königreiche;Schlingendorntal;Die Insel Yojamba"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1250.73,
                  ["worldX"] = -11874.6,
                  ["areaId"] = 3357,
               },
               ["s;Östliche Königreiche;Schlingendorntal;Booty Bay;Janeirospitze"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -718,
                  ["worldX"] = -14179.6,
                  ["areaId"] = 312,
               },
            },
            ["Silberwald"] = {
               "s;Östliche Königreiche;Silberwald;Das Grabmal", -- [1]
               "s;Östliche Königreiche;Silberwald;Valgans Feld;Valgans Feld", -- [2]
               ["s;Östliche Königreiche;Silberwald;Valgans Feld;Valgans Feld"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1255.63,
                  ["worldX"] = 908.754,
                  ["areaId"] = 227,
               },
               ["s;Östliche Königreiche;Silberwald;Das Grabmal"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1619.02,
                  ["worldX"] = 508.073,
                  ["areaId"] = 228,
               },
            },
            ["Brennende Steppe"] = {
               "s;Östliche Königreiche;Brennende Steppe;Die Ruinen von Thaurissan;Flammenkamm", -- [1]
               "s;Östliche Königreiche;Brennende Steppe;Schreckenspfad;Schlitterfels", -- [2]
               ["s;Östliche Königreiche;Brennende Steppe;Die Ruinen von Thaurissan;Flammenkamm"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2186.4,
                  ["worldX"] = -7479.77,
                  ["areaId"] = 251,
               },
               ["s;Östliche Königreiche;Brennende Steppe;Schreckenspfad;Schlitterfels"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -3030.61,
                  ["worldX"] = -7652.52,
                  ["areaId"] = 2419,
               },
            },
            ["Ödland"] = {
               "s;Östliche Königreiche;Ödland;Camp Cagg;Die Staubspeiergrotte", -- [1]
               "s;Östliche Königreiche;Ödland;Festung Angor", -- [2]
               "s;Östliche Königreiche;Ödland;Kargath", -- [3]
               "s;Östliche Königreiche;Ödland;Terrasse des Schöpfers;Uldaman", -- [4]
               ["s;Östliche Königreiche;Ödland;Terrasse des Schöpfers;Uldaman"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 70,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -3179.35,
                  ["worldX"] = -6092.01,
                  ["areaId"] = 1337,
               },
               ["s;Östliche Königreiche;Ödland;Kargath"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2186.68,
                  ["worldX"] = -6676.42,
                  ["areaId"] = 340,
               },
               ["s;Östliche Königreiche;Ödland;Festung Angor"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -3158,
                  ["worldX"] = -6392.65,
                  ["areaId"] = 338,
               },
               ["s;Östliche Königreiche;Ödland;Camp Cagg;Die Staubspeiergrotte"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2265.09,
                  ["worldX"] = -7320.59,
                  ["areaId"] = 347,
               },
            },
            ["Hinterland"] = {
               "s;Östliche Königreiche;Hinterland;Aerie Peak;Burg Wildhammer", -- [1]
               "s;Östliche Königreiche;Hinterland;Aerie Peak", -- [2]
               "s;Östliche Königreiche;Hinterland;Die Aussichtsklippen;Revantusk", -- [3]
               ["s;Östliche Königreiche;Hinterland;Die Aussichtsklippen;Revantusk"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -4590.51,
                  ["worldX"] = -573.459,
                  ["areaId"] = 3317,
               },
               ["s;Östliche Königreiche;Hinterland;Aerie Peak;Burg Wildhammer"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2119.3,
                  ["worldX"] = 316.946,
                  ["areaId"] = 349,
               },
               ["s;Östliche Königreiche;Hinterland;Aerie Peak"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2127.76,
                  ["worldX"] = 234.85,
                  ["areaId"] = 348,
               },
            },
            ["Dun Morogh"] = {
               "s;Östliche Königreiche;Dun Morogh;Das Coldridgetal;Anvilmar", -- [1]
               "s;Östliche Königreiche;Dun Morogh;Helmsbedsee;Ironbands Truppenlager", -- [2]
               "s;Östliche Königreiche;Dun Morogh;Kharanos;Steelgrills Depot", -- [3]
               "s;Östliche Königreiche;Dun Morogh;Kharanos", -- [4]
               ["s;Östliche Königreiche;Dun Morogh;Helmsbedsee;Ironbands Truppenlager"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2004.1,
                  ["worldX"] = -5858.7,
                  ["areaId"] = 716,
               },
               ["s;Östliche Königreiche;Dun Morogh;Das Coldridgetal;Anvilmar"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -383.763,
                  ["worldX"] = -6134.28,
                  ["areaId"] = 77,
               },
               ["s;Östliche Königreiche;Dun Morogh;Kharanos"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -482.12653,
                  ["worldX"] = -5585.9507,
                  ["areaId"] = 131,
               },
               ["s;Östliche Königreiche;Dun Morogh;Kharanos;Steelgrills Depot"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -658.67,
                  ["worldX"] = -5488.04,
                  ["areaId"] = 189,
               },
            },
            ["Westliche Pestländer"] = {
               "s;Östliche Königreiche;Westliche Pestländer;Die weinende Höhle;Die weinende Höhle", -- [1]
               "s;Östliche Königreiche;Westliche Pestländer;Scholomance", -- [2]
               "s;Östliche Königreiche;Westliche Pestländer;Sorrow Hill;Chillwind-Lager", -- [3]
               "s;Östliche Königreiche;Westliche Pestländer;Sorrow Hill;Uthers Grabmal", -- [4]
               ["s;Östliche Königreiche;Westliche Pestländer;Sorrow Hill;Chillwind-Lager"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1421.46,
                  ["worldX"] = 921.054,
                  ["areaId"] = 3197,
               },
               ["s;Östliche Königreiche;Westliche Pestländer;Die weinende Höhle;Die weinende Höhle"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2389.63,
                  ["worldX"] = 2249.61,
                  ["areaId"] = 198,
               },
               ["s;Östliche Königreiche;Westliche Pestländer;Scholomance"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 289,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -2579.41,
                  ["worldX"] = 1262.19,
                  ["areaId"] = 2057,
               },
               ["s;Östliche Königreiche;Westliche Pestländer;Sorrow Hill;Uthers Grabmal"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -1825.52,
                  ["worldX"] = 969.176,
                  ["areaId"] = 196,
               },
            },
            ["Eisenschmiede"] = {
               "s;Östliche Königreiche;Hauptstadt;Ironforge", -- [1]
               ["s;Östliche Königreiche;Hauptstadt;Ironforge"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -834.059,
                  ["worldX"] = -5021,
                  ["areaId"] = 1537,
               },
            },
            ["Sturmwind"] = {
               "s;Östliche Königreiche;Hauptstadt;Stormwind", -- [2]
               ["s;Östliche Königreiche;Hauptstadt;Stormwind"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -364.057,
                  ["worldX"] = -9153.77,
                  ["areaId"] = 1519,
               },
      
            },
            ["Unterstadt"] = {
               "s;Östliche Königreiche;Hauptstadt;Undercity", -- [3]
               ["s;Östliche Königreiche;Hauptstadt;Undercity"] = {
                  ["createdAt"] = "Sun Apr 25 23:32:35 2021",
                  ["contintentId"] = 0,
                  ["createdBy"] = "SkuNav",
                  ["worldY"] = -235.699,
                  ["worldX"] = 1849.69,
                  ["areaId"] = 1497,
               },
            },
         },
      },
      ["Postbox"] = {
         "Allianz", -- [1]
         "Horde", -- [2]
         "Unbekannt", -- [3]
         ["Horde"] = {
            "s;h;Briefkasten;Durotar", -- [1]
            "s;h;Briefkasten;Mulgore", -- [2]
            "s;h;Briefkasten;Ödland", -- [3]
            "s;h;Briefkasten;1;Orgrimmar", -- [4]
            "s;h;Briefkasten;2;Orgrimmar", -- [5]
            "s;h;Briefkasten;1;Silberwald", -- [6]
            "s;h;Briefkasten;2;Silberwald", -- [7]
            "s;h;Briefkasten;Thunder Bluff", -- [8]
            "s;h;Briefkasten;Tirisfal", -- [9]
            "s;h;Briefkasten;Undercity", -- [10]
            ["s;h;Briefkasten;Tirisfal"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 258.8207397460938,
               ["worldX"] = 2237.8623046875,
               ["areaId"] = 85,
            },
            ["s;h;Briefkasten;Mulgore"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -366.7083740234375,
               ["worldX"] = -2338.19140625,
               ["areaId"] = 215,
            },
            ["s;h;Briefkasten;1;Orgrimmar"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -4387.513671875,
               ["worldX"] = 1612.53759765625,
               ["areaId"] = 1637,
            },
            ["s;h;Briefkasten;Thunder Bluff"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 46.97917175292969,
               ["worldX"] = -1261.933227539063,
               ["areaId"] = 1638,
            },
            ["s;h;Briefkasten;Undercity"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 221.7769775390625,
               ["worldX"] = 1632.145385742188,
               ["areaId"] = 1497,
            },
            ["s;h;Briefkasten;Durotar"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -4706.71240234375,
               ["worldX"] = 324.3082275390625,
               ["areaId"] = 14,
            },
            ["s;h;Briefkasten;2;Orgrimmar"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -4551.61865234375,
               ["worldX"] = 1895.033569335938,
               ["areaId"] = 1637,
            },
            ["s;h;Briefkasten;2;Silberwald"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 1627.199829101563,
               ["worldX"] = 507.4665832519531,
               ["areaId"] = 130,
            },
            ["s;h;Briefkasten;1;Silberwald"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 1517.999755859375,
               ["worldX"] = 490.666748046875,
               ["areaId"] = 130,
            },
            ["s;h;Briefkasten;Ödland"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -2176.17919921875,
               ["worldX"] = -6673.974609375,
               ["areaId"] = 3,
            },
         },
         ["Unbekannt"] = {
            "s;u;Briefkasten;Arathihochland", -- [1]
            "s;u;Briefkasten;1;Ashenvale", -- [2]
            "s;u;Briefkasten;2;Ashenvale", -- [3]
            "s;u;Briefkasten;1;Brachland", -- [4]
            "s;u;Briefkasten;2;Brachland", -- [5]
            "s;u;Briefkasten;3;Brachland", -- [6]
            "s;u;Briefkasten;Dämmerwald", -- [7]
            "s;u;Briefkasten;1;Desolace", -- [8]
            "s;u;Briefkasten;2;Desolace", -- [9]
            "s;u;Briefkasten;Dunkelküste", -- [10]
            "s;u;Briefkasten;1;Feralas", -- [11]
            "s;u;Briefkasten;2;Feralas", -- [12]
            "s;u;Briefkasten;1;Hinterland", -- [13]
            "s;u;Briefkasten;2;Hinterland", -- [14]
            "s;u;Briefkasten;Marschen von Dustwallow", -- [15]
            "s;u;Briefkasten;1;Östliche Pestländer", -- [16]
            "s;u;Briefkasten;2;Östliche Pestländer", -- [17]
            "s;u;Briefkasten;1;Rotkammgebirge", -- [18]
            "s;u;Briefkasten;2;Rotkammgebirge", -- [19]
            "s;u;Briefkasten;1;Schlingendorntal", -- [20]
            "s;u;Briefkasten;2;Schlingendorntal", -- [21]
            "s;u;Briefkasten;3;Schlingendorntal", -- [22]
            "s;u;Briefkasten;Silithus", -- [23]
            "s;u;Briefkasten;1;Steinkrallengebirge", -- [24]
            "s;u;Briefkasten;2;Steinkrallengebirge", -- [25]
            "s;u;Briefkasten;Sümpfe des Elends", -- [26]
            "s;u;Briefkasten;Sumpfland", -- [27]
            "s;u;Briefkasten;Tanaris", -- [28]
            "s;u;Briefkasten;Tausend Nadeln", -- [29]
            "s;u;Briefkasten;Teldrassil", -- [30]
            "s;u;Briefkasten;Teufelswald", -- [31]
            "s;u;Briefkasten;Verwüstete Lande", -- [32]
            "s;u;Briefkasten;1;Vorgebirge von Hillsbrad", -- [33]
            "s;u;Briefkasten;2;Vorgebirge von Hillsbrad", -- [34]
            "s;u;Briefkasten;Winterspring", -- [35]
            ["s;u;Briefkasten;1;Desolace"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 3118.3662109375,
               ["worldX"] = -1610.4833984375,
               ["areaId"] = 405,
            },
            ["s;u;Briefkasten;2;Steinkrallengebirge"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 901.8333129882812,
               ["worldX"] = 927.0978393554688,
               ["areaId"] = 406,
            },
            ["s;u;Briefkasten;3;Brachland"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -3680.0166015625,
               ["worldX"] = -1035.949951171875,
               ["areaId"] = 17,
            },
            ["s;u;Briefkasten;Tausend Nadeln"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -2452.93310546875,
               ["worldX"] = -5462.66650390625,
               ["areaId"] = 400,
            },
            ["s;u;Briefkasten;2;Brachland"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -2646.41650390625,
               ["worldX"] = -441.4000244140625,
               ["areaId"] = 17,
            },
            ["s;u;Briefkasten;1;Feralas"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 3273.2666015625,
               ["worldX"] = -4396.06640625,
               ["areaId"] = 357,
            },
            ["s;u;Briefkasten;Silithus"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 736.6162109375,
               ["worldX"] = -6838.71875,
               ["areaId"] = 1377,
            },
            ["s;u;Briefkasten;1;Östliche Pestländer"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -5088.54150390625,
               ["worldX"] = 2457.75,
               ["areaId"] = 139,
            },
            ["s;u;Briefkasten;1;Ashenvale"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -393.300048828125,
               ["worldX"] = 2739.51025390625,
               ["areaId"] = 331,
            },
            ["s;u;Briefkasten;Verwüstete Lande"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -3389.016357421875,
               ["worldX"] = -10997.69921875,
               ["areaId"] = 4,
            },
            ["s;u;Briefkasten;Arathihochland"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -3523.46630859375,
               ["worldX"] = -927.7333374023438,
               ["areaId"] = 45,
            },
            ["s;u;Briefkasten;Teldrassil"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 958.1583862304688,
               ["worldX"] = 9849.30078125,
               ["areaId"] = 141,
            },
            ["s;u;Briefkasten;2;Feralas"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 236.11669921875,
               ["worldX"] = -4405.3330078125,
               ["areaId"] = 357,
            },
            ["s;u;Briefkasten;Dämmerwald"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -1159.2666015625,
               ["worldX"] = -10548.265625,
               ["areaId"] = 10,
            },
            ["s;u;Briefkasten;1;Vorgebirge von Hillsbrad"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -546.13330078125,
               ["worldX"] = -850.1333618164062,
               ["areaId"] = 267,
            },
            ["s;u;Briefkasten;1;Schlingendorntal"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 517.0396728515625,
               ["worldX"] = -14418.9326171875,
               ["areaId"] = 33,
            },
            ["s;u;Briefkasten;Marschen von Dustwallow"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -4434.75,
               ["worldX"] = -3618.8330078125,
               ["areaId"] = 15,
            },
            ["s;u;Briefkasten;2;Ashenvale"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -2544.2666015625,
               ["worldX"] = 2332.07275390625,
               ["areaId"] = 331,
            },
            ["s;u;Briefkasten;3;Schlingendorntal"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 480.0283203125,
               ["worldX"] = -14461.8994140625,
               ["areaId"] = 33,
            },
            ["s;u;Briefkasten;2;Vorgebirge von Hillsbrad"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -930.13330078125,
               ["worldX"] = -22.39999389648438,
               ["areaId"] = 267,
            },
            ["s;u;Briefkasten;2;Östliche Pestländer"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -5316.9208984375,
               ["worldX"] = 2292.5498046875,
               ["areaId"] = 139,
            },
            ["s;u;Briefkasten;Teufelswald"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -360.483154296875,
               ["worldX"] = 5103.5830078125,
               ["areaId"] = 361,
            },
            ["s;u;Briefkasten;1;Rotkammgebirge"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -2243.79150390625,
               ["worldX"] = -9270,
               ["areaId"] = 44,
            },
            ["s;u;Briefkasten;Winterspring"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -4668.96630859375,
               ["worldX"] = 6706.26611328125,
               ["areaId"] = 618,
            },
            ["s;u;Briefkasten;Sumpfland"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -836.2083740234375,
               ["worldX"] = -3793.397705078125,
               ["areaId"] = 11,
            },
            ["s;u;Briefkasten;2;Desolace"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 1293.058227539063,
               ["worldX"] = 245.2270660400391,
               ["areaId"] = 405,
            },
            ["s;u;Briefkasten;Sümpfe des Elends"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -3264.279052734375,
               ["worldX"] = -10461.875,
               ["areaId"] = 8,
            },
            ["s;u;Briefkasten;1;Steinkrallengebirge"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 1487.833251953125,
               ["worldX"] = 2678.960205078125,
               ["areaId"] = 406,
            },
            ["s;u;Briefkasten;Tanaris"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -3827.44970703125,
               ["worldX"] = -7153.7998046875,
               ["areaId"] = 440,
            },
            ["s;u;Briefkasten;2;Schlingendorntal"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 153.308349609375,
               ["worldX"] = -12389.6953125,
               ["areaId"] = 33,
            },
            ["s;u;Briefkasten;1;Brachland"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -1947.216796875,
               ["worldX"] = -2353.4189453125,
               ["areaId"] = 17,
            },
            ["s;u;Briefkasten;2;Rotkammgebirge"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -2143.93310546875,
               ["worldX"] = -9249.728515625,
               ["areaId"] = 44,
            },
            ["s;u;Briefkasten;Dunkelküste"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 498.5164794921875,
               ["worldX"] = 6420.7333984375,
               ["areaId"] = 148,
            },
            ["s;u;Briefkasten;1;Hinterland"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -2117.849853515625,
               ["worldX"] = 293.6999816894531,
               ["areaId"] = 47,
            },
            ["s;u;Briefkasten;2;Hinterland"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -4612.64990234375,
               ["worldX"] = -599.5,
               ["areaId"] = 47,
            },
         },
         ["Allianz"] = {
            "s;a;Briefkasten;1;Darnassus", -- [1]
            "s;a;Briefkasten;2;Darnassus", -- [2]
            "s;a;Briefkasten;Dun Morogh", -- [3]
            "s;a;Briefkasten;1;Ironforge", -- [4]
            "s;a;Briefkasten;2;Ironforge", -- [5]
            "s;a;Briefkasten;3;Ironforge", -- [6]
            "s;a;Briefkasten;4;Ironforge", -- [7]
            "s;a;Briefkasten;Loch Modan", -- [8]
            "s;a;Briefkasten;1;Stormwind", -- [9]
            "s;a;Briefkasten;2;Stormwind", -- [10]
            "s;a;Briefkasten;3;Stormwind", -- [11]
            "s;a;Briefkasten;4;Stormwind", -- [12]
            "s;a;Briefkasten;Wald von Elwynn", -- [13]
            "s;a;Briefkasten;Westfall", -- [14]
            ["s;a;Briefkasten;2;Ironforge"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -973.70703125,
               ["worldX"] = -4911.65625,
               ["areaId"] = 1537,
            },
            ["s;a;Briefkasten;2;Stormwind"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 845.95166015625,
               ["worldX"] = -9036.26953125,
               ["areaId"] = 1519,
            },
            ["s;a;Briefkasten;2;Darnassus"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 2227.37451171875,
               ["worldX"] = 10122.08203125,
               ["areaId"] = 1657,
            },
            ["s;a;Briefkasten;1;Stormwind"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 1083.887573242188,
               ["worldX"] = -8793.3583984375,
               ["areaId"] = 1519,
            },
            ["s;a;Briefkasten;4;Ironforge"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -1282.841430664063,
               ["worldX"] = -4824.6015625,
               ["areaId"] = 1537,
            },
            ["s;a;Briefkasten;Loch Modan"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -2953.64990234375,
               ["worldX"] = -5364.98095703125,
               ["areaId"] = 38,
            },
            ["s;a;Briefkasten;4;Stormwind"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 427.8834533691406,
               ["worldX"] = -8640.0810546875,
               ["areaId"] = 1519,
            },
            ["s;a;Briefkasten;1;Ironforge"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -880.4132690429688,
               ["worldX"] = -4848.34375,
               ["areaId"] = 1537,
            },
            ["s;a;Briefkasten;1;Darnassus"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 2500.212646484375,
               ["worldX"] = 9941.205078125,
               ["areaId"] = 1657,
            },
            ["s;a;Briefkasten;3;Stormwind"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 648.3438110351562,
               ["worldX"] = -8875.822265625,
               ["areaId"] = 1519,
            },
            ["s;a;Briefkasten;Westfall"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 1161.666748046875,
               ["worldX"] = -10648.3330078125,
               ["areaId"] = 40,
            },
            ["s;a;Briefkasten;Wald von Elwynn"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 46.42913818359375,
               ["worldX"] = -9453.3203125,
               ["areaId"] = 12,
            },
            ["s;a;Briefkasten;3;Ironforge"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -1274.14453125,
               ["worldX"] = -4950.69921875,
               ["areaId"] = 1537,
            },
            ["s;a;Briefkasten;Dun Morogh"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -512.6666870117188,
               ["worldX"] = -5597.5498046875,
               ["areaId"] = 1,
            },
         },
      },
      ["Taxi"] = {
         "Horde", -- [1]
         "Allianz", -- [2]
         ["Horde"] = {
            "s;h;Flugpunkt;Arathihochland;Urda", -- [1]
            "s;h;Flugpunkt;Ashenvale;Andruk", -- [2]
            "s;h;Flugpunkt;Ashenvale;Vhulgra", -- [3]
            "s;h;Flugpunkt;Azshara;Kroum", -- [4]
            "s;h;Flugpunkt;Brachland;Bragok", -- [5]
            "s;h;Flugpunkt;Brachland;Devrak", -- [6]
            "s;h;Flugpunkt;Brachland;Omusa Thunderhorn", -- [7]
            "s;h;Flugpunkt;Brennende Steppe;Vahgruk", -- [8]
            "s;h;Flugpunkt;Desolace;Thalon", -- [9]
            "s;h;Flugpunkt;Feralas;Shyn", -- [10]
            "s;h;Flugpunkt;Hinterland;Gorkas", -- [11]
            "s;h;Flugpunkt;Marschen von Dustwallow;Shardi", -- [12]
            "s;h;Flugpunkt;Moonglade;Faustron", -- [13]
            "s;h;Flugpunkt;Ödland;Gorrik", -- [14]
            "s;h;Flugpunkt;Orgrimmar;Doras", -- [15]
            "s;h;Flugpunkt;Östliche Pestländer;Georgia", -- [16]
            "s;h;Flugpunkt;Schlingendorntal;Gringer", -- [17]
            "s;h;Flugpunkt;Schlingendorntal;Thysta", -- [18]
            "s;h;Flugpunkt;Sengende Schlucht;Grisha", -- [19]
            "s;h;Flugpunkt;Silberwald;Karos Razok", -- [20]
            "s;h;Flugpunkt;Silithus;Runk Windtamer", -- [21]
            "s;h;Flugpunkt;Steinkrallengebirge;Tharm", -- [22]
            "s;h;Flugpunkt;Sümpfe des Elends;Breyk", -- [23]
            "s;h;Flugpunkt;Tanaris;Bulkrek Ragefist", -- [24]
            "s;h;Flugpunkt;Tausend Nadeln;Nyse", -- [25]
            "s;h;Flugpunkt;Teufelswald;Brakkar", -- [26]
            "s;h;Flugpunkt;Thunder Bluff;Tal", -- [27]
            "s;h;Flugpunkt;Undercity;Michael Garrett", -- [28]
            "s;h;Flugpunkt;Un'Goro-Krater;Gryfe", -- [29]
            "s;h;Flugpunkt;Vorgebirge von Hillsbrad;Zarise", -- [30]
            "s;h;Flugpunkt;Winterspring;Yugrek", -- [31]
            ["s;h;Flugpunkt;Arathihochland;Urda"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -3496.826416015625,
               ["worldX"] = -917.6532592773438,
               ["areaId"] = 45,
            },
            ["s;h;Flugpunkt;Schlingendorntal;Gringer"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 506.19140625,
               ["worldX"] = -14448.7119140625,
               ["areaId"] = 33,
            },
            ["s;h;Flugpunkt;Silberwald;Karos Razok"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 1533.959838867188,
               ["worldX"] = 473.8666687011719,
               ["areaId"] = 130,
            },
            ["s;h;Flugpunkt;Winterspring;Yugrek"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -4610.03662109375,
               ["worldX"] = 6815.1328125,
               ["areaId"] = 618,
            },
            ["s;h;Flugpunkt;Tanaris;Bulkrek Ragefist"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -3779.149658203125,
               ["worldX"] = -7045.240234375,
               ["areaId"] = 440,
            },
            ["s;h;Flugpunkt;Silithus;Runk Windtamer"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 841.8131103515625,
               ["worldX"] = -6810.1474609375,
               ["areaId"] = 1377,
            },
            ["s;h;Flugpunkt;Un'Goro-Krater;Gryfe"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -1140.176635742188,
               ["worldX"] = -6110.47265625,
               ["areaId"] = 490,
            },
            ["s;h;Flugpunkt;Sengende Schlucht;Grisha"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -1100.284057617188,
               ["worldX"] = -6559.19140625,
               ["areaId"] = 51,
            },
            ["s;h;Flugpunkt;Orgrimmar;Doras"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -4313.4560546875,
               ["worldX"] = 1676.239501953125,
               ["areaId"] = 1637,
            },
            ["s;h;Flugpunkt;Brachland;Bragok"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -3769.18994140625,
               ["worldX"] = -898.1226196289062,
               ["areaId"] = 17,
            },
            ["s;h;Flugpunkt;Sümpfe des Elends;Breyk"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -3279.647216796875,
               ["worldX"] = -10459.275390625,
               ["areaId"] = 8,
            },
            ["s;h;Flugpunkt;Ashenvale;Vhulgra"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -2520.046630859375,
               ["worldX"] = 2305.551025390625,
               ["areaId"] = 331,
            },
            ["s;h;Flugpunkt;Undercity;Michael Garrett"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 266.3879089355469,
               ["worldX"] = 1567.11083984375,
               ["areaId"] = 1497,
            },
            ["s;h;Flugpunkt;Marschen von Dustwallow;Shardi"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -2841.900146484375,
               ["worldX"] = -3149.13330078125,
               ["areaId"] = 15,
            },
            ["s;h;Flugpunkt;Östliche Pestländer;Georgia"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -5290.59912109375,
               ["worldX"] = 2328.42919921875,
               ["areaId"] = 139,
            },
            ["s;h;Flugpunkt;Ashenvale;Andruk"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 994.159912109375,
               ["worldX"] = 3373.72900390625,
               ["areaId"] = 331,
            },
            ["s;h;Flugpunkt;Vorgebirge von Hillsbrad;Zarise"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -857.8133544921875,
               ["worldX"] = 2.773345947265625,
               ["areaId"] = 267,
            },
            ["s;h;Flugpunkt;Azshara;Kroum"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -4390.63818359375,
               ["worldX"] = 3663.890625,
               ["areaId"] = 16,
            },
            ["s;h;Flugpunkt;Teufelswald;Brakkar"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -338.6331787109375,
               ["worldX"] = 5064.8662109375,
               ["areaId"] = 361,
            },
            ["s;h;Flugpunkt;Thunder Bluff;Tal"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 26.1041259765625,
               ["worldX"] = -1196.733642578125,
               ["areaId"] = 1638,
            },
            ["s;h;Flugpunkt;Tausend Nadeln;Nyse"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -2419.4931640625,
               ["worldX"] = -5407.2265625,
               ["areaId"] = 400,
            },
            ["s;h;Flugpunkt;Ödland;Gorrik"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -2178.417724609375,
               ["worldX"] = -6632.1845703125,
               ["areaId"] = 3,
            },
            ["s;h;Flugpunkt;Brennende Steppe;Vahgruk"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -2190.836181640625,
               ["worldX"] = -7504.0439453125,
               ["areaId"] = 46,
            },
            ["s;h;Flugpunkt;Brachland;Devrak"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -2595.75,
               ["worldX"] = -437.346435546875,
               ["areaId"] = 17,
            },
            ["s;h;Flugpunkt;Schlingendorntal;Thysta"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 144.37451171875,
               ["worldX"] = -12417.34765625,
               ["areaId"] = 33,
            },
            ["s;h;Flugpunkt;Desolace;Thalon"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 3262.233154296875,
               ["worldX"] = -1770.272216796875,
               ["areaId"] = 405,
            },
            ["s;h;Flugpunkt;Moonglade;Faustron"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -2121.994140625,
               ["worldX"] = 7466.14990234375,
               ["areaId"] = 493,
            },
            ["s;h;Flugpunkt;Hinterland;Gorkas"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -4720.44970703125,
               ["worldX"] = -631.8399658203125,
               ["areaId"] = 47,
            },
            ["s;h;Flugpunkt;Feralas;Shyn"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 197.8919677734375,
               ["worldX"] = -4422.0126953125,
               ["areaId"] = 357,
            },
            ["s;h;Flugpunkt;Brachland;Omusa Thunderhorn"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -1881.349975585938,
               ["worldX"] = -2383.82177734375,
               ["areaId"] = 17,
            },
            ["s;h;Flugpunkt;Steinkrallengebirge;Tharm"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 1042.473266601563,
               ["worldX"] = 968.1265869140625,
               ["areaId"] = 406,
            },
         },
         ["Allianz"] = {
            "s;a;Flugpunkt;Arathihochland;Cedrik Prose", -- [1]
            "s;a;Flugpunkt;Ashenvale;Daelyshia", -- [2]
            "s;a;Flugpunkt;Azshara;Jarrodenus", -- [3]
            "s;a;Flugpunkt;Brachland;Bragok", -- [4]
            "s;a;Flugpunkt;Brennende Steppe;Borgus Stoutarm", -- [5]
            "s;a;Flugpunkt;Dämmerwald;Felicia Maline", -- [6]
            "s;a;Flugpunkt;Desolace;Baritanas Skyriver", -- [7]
            "s;a;Flugpunkt;Dunkelküste;Caylais Moonfeather", -- [8]
            "s;a;Flugpunkt;Feralas;Fyldren Moonfeather", -- [9]
            "s;a;Flugpunkt;Feralas;Thyssiana", -- [10]
            "s;a;Flugpunkt;Hinterland;Guthrum Thunderfist", -- [11]
            "s;a;Flugpunkt;Ironforge;Gryth Thurden", -- [12]
            "s;a;Flugpunkt;Loch Modan;Thorgrum Borrelson", -- [13]
            "s;a;Flugpunkt;Marschen von Dustwallow;Baldruc", -- [14]
            "s;a;Flugpunkt;Moonglade;Sindrayl", -- [15]
            "s;a;Flugpunkt;Östliche Pestländer;Khaelyn Steelwing", -- [16]
            "s;a;Flugpunkt;Rotkammgebirge;Ariena Stormfeather", -- [17]
            "s;a;Flugpunkt;Schlingendorntal;Gyll", -- [18]
            "s;a;Flugpunkt;Sengende Schlucht;Lanie Reed", -- [19]
            "s;a;Flugpunkt;Silithus;Cloud Skydancer", -- [20]
            "s;a;Flugpunkt;Steinkrallengebirge;Teloren", -- [21]
            "s;a;Flugpunkt;Stormwind;Dungar Longdrink", -- [22]
            "s;a;Flugpunkt;Sumpfland;Shellei Brondir", -- [23]
            "s;a;Flugpunkt;Tanaris;Bera Stonehammer", -- [24]
            "s;a;Flugpunkt;Teldrassil;Vesprystus", -- [25]
            "s;a;Flugpunkt;Teufelswald;Mishellena", -- [26]
            "s;a;Flugpunkt;Un'Goro-Krater;Gryfe", -- [27]
            "s;a;Flugpunkt;Verwüstete Lande;Alexandra Constantine", -- [28]
            "s;a;Flugpunkt;Vorgebirge von Hillsbrad;Darla Harris", -- [29]
            "s;a;Flugpunkt;Westfall;Thor", -- [30]
            "s;a;Flugpunkt;Westliche Pestländer;Bibilfaz Featherwhistle", -- [31]
            "s;a;Flugpunkt;Winterspring;Maethrya", -- [32]
            ["s;a;Flugpunkt;Ashenvale;Daelyshia"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -284.31005859375,
               ["worldX"] = 2828.30078125,
               ["areaId"] = 331,
            },
            ["s;a;Flugpunkt;Brennende Steppe;Borgus Stoutarm"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -2736.832763671875,
               ["worldX"] = -8365.1083984375,
               ["areaId"] = 46,
            },
            ["s;a;Flugpunkt;Östliche Pestländer;Khaelyn Steelwing"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -5345.56494140625,
               ["worldX"] = 2269.8349609375,
               ["areaId"] = 139,
            },
            ["s;a;Flugpunkt;Winterspring;Maethrya"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -4742.0966796875,
               ["worldX"] = 6800.4599609375,
               ["areaId"] = 618,
            },
            ["s;a;Flugpunkt;Marschen von Dustwallow;Baldruc"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -4517.69970703125,
               ["worldX"] = -3828.8330078125,
               ["areaId"] = 15,
            },
            ["s;a;Flugpunkt;Sengende Schlucht;Lanie Reed"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -1169.452880859375,
               ["worldX"] = -6559.04248046875,
               ["areaId"] = 51,
            },
            ["s;a;Flugpunkt;Westfall;Thor"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 1037.41650390625,
               ["worldX"] = -10628.2666015625,
               ["areaId"] = 40,
            },
            ["s;a;Flugpunkt;Verwüstete Lande;Alexandra Constantine"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -3437.256591796875,
               ["worldX"] = -11110.259765625,
               ["areaId"] = 4,
            },
            ["s;a;Flugpunkt;Feralas;Fyldren Moonfeather"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 3339.98681640625,
               ["worldX"] = -4370.5830078125,
               ["areaId"] = 357,
            },
            ["s;a;Flugpunkt;Hinterland;Guthrum Thunderfist"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -2001.194946289063,
               ["worldX"] = 282.1499938964844,
               ["areaId"] = 47,
            },
            ["s;a;Flugpunkt;Schlingendorntal;Gyll"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 464.0750732421875,
               ["worldX"] = -14478.06640625,
               ["areaId"] = 33,
            },
            ["s;a;Flugpunkt;Un'Goro-Krater;Gryfe"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -1140.176635742188,
               ["worldX"] = -6110.47265625,
               ["areaId"] = 490,
            },
            ["s;a;Flugpunkt;Teufelswald;Mishellena"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -1951.507934570313,
               ["worldX"] = 6204.13330078125,
               ["areaId"] = 361,
            },
            ["s;a;Flugpunkt;Dämmerwald;Felicia Maline"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -1258.896728515625,
               ["worldX"] = -10513.88671875,
               ["areaId"] = 10,
            },
            ["s;a;Flugpunkt;Teldrassil;Vesprystus"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 841.0501098632812,
               ["worldX"] = 8640.4462890625,
               ["areaId"] = 141,
            },
            ["s;a;Flugpunkt;Steinkrallengebirge;Teloren"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 1466.346557617188,
               ["worldX"] = 2682.86767578125,
               ["areaId"] = 406,
            },
            ["s;a;Flugpunkt;Azshara;Jarrodenus"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -3880.512451171875,
               ["worldX"] = 2718.15478515625,
               ["areaId"] = 16,
            },
            ["s;a;Flugpunkt;Silithus;Cloud Skydancer"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 775.629638671875,
               ["worldX"] = -6758.57861328125,
               ["areaId"] = 1377,
            },
            ["s;a;Flugpunkt;Feralas;Thyssiana"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -778.5831909179688,
               ["worldX"] = -4491.0498046875,
               ["areaId"] = 357,
            },
            ["s;a;Flugpunkt;Rotkammgebirge;Ariena Stormfeather"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -2234.89111328125,
               ["worldX"] = -9435.20703125,
               ["areaId"] = 44,
            },
            ["s;a;Flugpunkt;Tanaris;Bera Stonehammer"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -3738.439697265625,
               ["worldX"] = -7224.6396484375,
               ["areaId"] = 440,
            },
            ["s;a;Flugpunkt;Desolace;Baritanas Skyriver"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 1326.327270507813,
               ["worldX"] = 136.1028747558594,
               ["areaId"] = 405,
            },
            ["s;a;Flugpunkt;Dunkelküste;Caylais Moonfeather"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 561.3966064453125,
               ["worldX"] = 6343.0068359375,
               ["areaId"] = 148,
            },
            ["s;a;Flugpunkt;Ironforge;Gryth Thurden"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -1152.388305664063,
               ["worldX"] = -4821.11962890625,
               ["areaId"] = 1537,
            },
            ["s;a;Flugpunkt;Stormwind;Dungar Longdrink"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = 490.1231689453125,
               ["worldX"] = -8835.755859375,
               ["areaId"] = 1519,
            },
            ["s;a;Flugpunkt;Brachland;Bragok"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -3769.18994140625,
               ["worldX"] = -898.1226196289062,
               ["areaId"] = 17,
            },
            ["s;a;Flugpunkt;Arathihochland;Cedrik Prose"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -2514.026611328125,
               ["worldX"] = -1239.973388671875,
               ["areaId"] = 45,
            },
            ["s;a;Flugpunkt;Loch Modan;Thorgrum Borrelson"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -2929.92822265625,
               ["worldX"] = -5424.767578125,
               ["areaId"] = 38,
            },
            ["s;a;Flugpunkt;Sumpfland;Shellei Brondir"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -782.0343017578125,
               ["worldX"] = -3793.1220703125,
               ["areaId"] = 11,
            },
            ["s;a;Flugpunkt;Westliche Pestländer;Bibilfaz Featherwhistle"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -1428.893188476563,
               ["worldX"] = 928.2799072265625,
               ["areaId"] = 28,
            },
            ["s;a;Flugpunkt;Moonglade;Sindrayl"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 1,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -2491.558349609375,
               ["worldX"] = 7454.9111328125,
               ["areaId"] = 493,
            },
            ["s;a;Flugpunkt;Vorgebirge von Hillsbrad;Darla Harris"] = {
               ["createdAt"] = "Sun Apr 25 23:32:35 2021",
               ["contintentId"] = 0,
               ["createdBy"] = "SkuNav",
               ["worldY"] = -512.2133178710938,
               ["worldX"] = -715.0933227539062,
               ["areaId"] = 267,
            },
         },
      },
   },
}
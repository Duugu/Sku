local MODULE_NAME = "SkuCore"
local _G = _G
local L = Sku.L

SkuCore.ScanTypes = {
	[1] = {
		name = L["180 front"],
		desc = L["180 degrees 5-35 meters 10 seconds"],
		hStepSizeDeg = 7,
		hStepsMax = 7,
		vMoveSpeed = 0.3,
		vStepsMax = 19,
		hStart = 0.6,
	},
	[2] = {
		name = L["360 10 fast"],
		desc = L["360 degrees 0-10 meters 4 seconds"],
		hStepSizeDeg = 11,
		hStepsMax = 18,
		vMoveSpeed = 1.0,
		vStepsMax = 6,
		hStart = 0.50,
	},
	[3] = {
		name = L["360 30 fast"],
		desc = L["360 degrees 3-30 meters 10 seconds"],
		hStepSizeDeg = 11,
		hStepsMax = 15,
		vMoveSpeed = 0.4,
		vStepsMax = 9,
		hStart = 0.65,
	},
	[4] = {
		name = L["360 10 accurate"],
		desc = L["360 degrees 0-10 meters 10 seconds"],
		hStepSizeDeg = 7,
		hStepsMax = 25,
		vMoveSpeed = 1.0,
		vStepsMax = 6,
		hStart = 0.50,
	},
	[5] = {
		name = L["360 30 accurate"],
		desc = L["360 degrees 3-30 meters 20 seconds"],
		hStepSizeDeg = 9,
		hStepsMax = 20,
		vMoveSpeed = 0.2,
		vStepsMax = 11,
		hStart = 0.65,
	},		
	[6] = {
		name = L["360 10 very fast"],
		desc = L["360 degrees 0-10 meters 2 second"],
		hStepSizeDeg = 150,
		hStepsMax = 2,
		vMoveSpeed = 6.0,
		vStepsMax = 8,
		hStart = 0.50,
	},
	[7] = {
		name = L["360+180 3-10 fast"],
		desc = L["360 degrees from top to bottom 3-10 meters 15 seconds"],
		hStepSizeDeg = 50,
		hStepsMax = 6,
		vMoveSpeed = 1.0,
		vStepsMax = 18,
		hStart = 0.8,
	},

}

SkuCore.ScanObjects = {
	[1] = "CorpseLootable",
	[2] = "CorpseSkinnable",
	[3] = "CorpseNotLootable",
	[4] = "CreaturePlayerTarget",
	[5] = "CreatureAny",
	[6] = "ObjectCurrentQuest",
	[7] = "ObjectHerb",
	[8] = "ObjectVein",
	[9] = "Bobber",
	[10] = "ObjectUsable",
	[11] = "ObjectAny",
	[12] = "Any",
}

SkuCore.Keys = {}
SkuCore.Keys.SkuDefaultBindings = {
	["BINDING_HEADER_MULTICASTFUNCTIONS"] = {
		["MULTICASTACTIONBUTTON1"] = {
			["index"] = 112,
		},
		["MULTICASTACTIONBUTTON2"] = {
			["index"] = 113,
		},
		["MULTICASTACTIONBUTTON3"] = {
			["index"] = 114,
		},
		["MULTICASTACTIONBUTTON4"] = {
			["index"] = 115,
		},
		["MULTICASTACTIONBUTTON5"] = {
			["index"] = 116,
		},
		["MULTICASTACTIONBUTTON6"] = {
			["index"] = 117,
		},
		["MULTICASTACTIONBUTTON7"] = {
			["index"] = 118,
		},
		["MULTICASTACTIONBUTTON8"] = {
			["index"] = 119,
		},
		["MULTICASTACTIONBUTTON9"] = {
			["index"] = 120,
		},
		["MULTICASTACTIONBUTTON10"] = {
			["index"] = 121,
		},
		["MULTICASTACTIONBUTTON11"] = {
			["index"] = 122,
		},
		["MULTICASTACTIONBUTTON12"] = {
			["index"] = 123,
		},
	},		
	["BINDING_HEADER_RAID_TARGET"] = {
		["RAIDTARGET1"] = {
			["index"] = 236,
		},
		["RAIDTARGET6"] = {
			["key1"] = "CTRL-NUMPAD4",
			["index"] = 231,
		},
		["RAIDTARGET3"] = {
			["index"] = 234,
		},
		["RAIDTARGET2"] = {
			["index"] = 235,
		},
		["RAIDTARGET8"] = {
			["key1"] = "CTRL-NUMPAD1",
			["index"] = 229,
		},
		["RAIDTARGET4"] = {
			["key1"] = "CTRL-NUMPAD3",
			["index"] = 233,
		},
		["RAIDTARGET5"] = {
			["key1"] = "CTRL-NUMPAD5",
			["index"] = 232,
		},
		["RAIDTARGET7"] = {
			["key1"] = "CTRL-NUMPAD2",
			["index"] = 230,
		},
		["RAIDTARGETNONE"] = {
			["key1"] = "CTRL-NUMPAD0",
			["index"] = 237,
		},
	},
	["BINDING_HEADER_CAMERA"] = {
		["SAVEVIEW5"] = {
			["index"] = 222,
		},
		["RESETVIEW4"] = {
			["index"] = 226,
		},
		["SETVIEW5"] = {
			["index"] = 217,
		},
		["SETVIEW2"] = {
			["key1"] = "CTRL-NUMPAD7",
			["index"] = 214,
		},
		["RESETVIEW1"] = {
			["index"] = 223,
		},
		["SAVEVIEW1"] = {
			["index"] = 218,
		},
		["SETVIEW3"] = {
			["index"] = 215,
		},
		["SETVIEW4"] = {
			["key1"] = "CTRL-NUMPAD8",
			["index"] = 216,
		},
		["PREVVIEW"] = {
			["index"] = 210,
		},
		["FLIPCAMERAYAW"] = {
			["index"] = 228,
		},
		["SETVIEW1"] = {
			["index"] = 213,
		},
		["SAVEVIEW2"] = {
			["index"] = 219,
		},
		["SAVEVIEW3"] = {
			["index"] = 220,
		},
		["CAMERAZOOMOUT"] = {
			["key1"] = "MOUSEWHEELDOWN",
			["index"] = 212,
		},
		["RESETVIEW2"] = {
			["index"] = 224,
		},
		["RESETVIEW5"] = {
			["index"] = 227,
		},
		["RESETVIEW3"] = {
			["index"] = 225,
		},
		["NEXTVIEW"] = {
			["index"] = 209,
		},
		["CAMERAZOOMIN"] = {
			["key1"] = "MOUSEWHEELUP",
			["index"] = 211,
		},
		["SAVEVIEW4"] = {
			["index"] = 221,
		},
	},	
	["BINDING_HEADER_MULTIACTIONBAR"] = {

		--1
		["MULTIACTIONBAR1BUTTON1"] = {
			["key1"] = "F1",
			["index"] = 73,
		},
		["MULTIACTIONBAR1BUTTON2"] = {
			["key1"] = "F2",
			["index"] = 74,
		},
		["MULTIACTIONBAR1BUTTON3"] = {
			["key1"] = "F3",
			["index"] = 75,
		},
		["MULTIACTIONBAR1BUTTON4"] = {
			["key1"] = "F4",
			["index"] = 76,
		},
		["MULTIACTIONBAR1BUTTON5"] = {
			["key1"] = "F5",
			["index"] = 77,
		},
		["MULTIACTIONBAR1BUTTON6"] = {
			["key1"] = "F6",
			["index"] = 78,
		},
		["MULTIACTIONBAR1BUTTON7"] = {
			["key1"] = "F7",
			["index"] = 79,
		},
		["MULTIACTIONBAR1BUTTON8"] = {
			["key1"] = "F8",
			["index"] = 80,
		},
		["MULTIACTIONBAR1BUTTON9"] = {
			["key1"] = "F9",
			["index"] = 81,
		},
		["MULTIACTIONBAR1BUTTON10"] = {
			["key1"] = "F10",
			["index"] = 82,
		},
		["MULTIACTIONBAR1BUTTON11"] = {
			["key1"] = "F11",
			["index"] = 83,
		},
		["MULTIACTIONBAR1BUTTON12"] = {
			["key1"] = "F12",
			["index"] = 84,
		},

		["HEADER_BLANK4"] = {
			["index"] = 85,
		},

		--2
		["MULTIACTIONBAR2BUTTON1"] = {
			--["key1"] = "",
			["index"] = 86,
		},
		["MULTIACTIONBAR2BUTTON2"] = {
			--["key1"] = "",
			["index"] = 87,
		},
		["MULTIACTIONBAR2BUTTON3"] = {
			--["key1"] = "",
			["index"] = 88,
		},
		["MULTIACTIONBAR2BUTTON4"] = {
			--["key1"] = "",
			["index"] = 89,
		},
		["MULTIACTIONBAR2BUTTON5"] = {
			--["key1"] = "",
			["index"] = 90,
		},
		["MULTIACTIONBAR2BUTTON6"] = {
			--["key1"] = "",
			["index"] = 91,
		},
		["MULTIACTIONBAR2BUTTON7"] = {
			--["key1"] = "",
			["index"] = 92,
		},
		["MULTIACTIONBAR2BUTTON8"] = {
			--["key1"] = "",
			["index"] = 93,
		},
		["MULTIACTIONBAR2BUTTON9"] = {
			--["key1"] = "",
			["index"] = 94,
		},
		["MULTIACTIONBAR2BUTTON10"] = {
			--["key1"] = "",
			["index"] = 95,
		},
		["MULTIACTIONBAR2BUTTON11"] = {
			--["key1"] = "",
			["index"] = 96,
		},
		["MULTIACTIONBAR2BUTTON12"] = {
			--["key1"] = "",
			["index"] = 97,
		},

		--3
		["MULTIACTIONBAR3BUTTON1"] = {
			--["key1"] = "CTRL-F1",
			["index"] = 99,
		},
		["MULTIACTIONBAR3BUTTON2"] = {
			--["key1"] = "CTRL-F2",
			["index"] = 100,
		},
		["MULTIACTIONBAR3BUTTON3"] = {
			--["key1"] = "CTRL-F3",
			["index"] = 101,
		},
		["MULTIACTIONBAR3BUTTON4"] = {
			--["key1"] = "CTRL-F4",
			["index"] = 102,
		},
		["MULTIACTIONBAR3BUTTON5"] = {
			--["key1"] = "CTRL-F5",
			["index"] = 103,
		},
		["MULTIACTIONBAR3BUTTON6"] = {
			--["key1"] = "CTRL-F6",
			["index"] = 104,
		},
		["MULTIACTIONBAR3BUTTON7"] = {
			["index"] = 105,
		},
		["MULTIACTIONBAR3BUTTON8"] = {
			["index"] = 106,
		},
		["MULTIACTIONBAR3BUTTON9"] = {
			["index"] = 107,
		},
		["MULTIACTIONBAR3BUTTON10"] = {
			["index"] = 108,
		},
		["MULTIACTIONBAR3BUTTON11"] = {
			["index"] = 109,
		},
		["MULTIACTIONBAR3BUTTON12"] = {
			["index"] = 110,
		},

		--4
		["MULTIACTIONBAR4BUTTON1"] = {
			--["key1"] = "CTRL-F7",
			["index"] = 112,
		},
		["MULTIACTIONBAR4BUTTON2"] = {
			--["key1"] = "CTRL-F8",
			["index"] = 113,
		},
		["MULTIACTIONBAR4BUTTON3"] = {
			--["key1"] = "CTRL-F9",
			["index"] = 114,
		},
		["MULTIACTIONBAR4BUTTON4"] = {
			--["key1"] = "CTRL-F10",
			["index"] = 115,
		},
		["MULTIACTIONBAR4BUTTON5"] = {
			--["key1"] = "CTRL-F11",
			["index"] = 116,
		},
		["MULTIACTIONBAR4BUTTON6"] = {
			--["key1"] = "CTRL-F12",
			["index"] = 117,
		},
		["MULTIACTIONBAR4BUTTON7"] = {
			["index"] = 118,
		},
		["MULTIACTIONBAR4BUTTON8"] = {
			["index"] = 119,
		},
		["MULTIACTIONBAR4BUTTON9"] = {
			["index"] = 120,
		},
		["MULTIACTIONBAR4BUTTON10"] = {
			["index"] = 121,
		},
		["MULTIACTIONBAR4BUTTON11"] = {
			["index"] = 122,
		},
		["MULTIACTIONBAR4BUTTON12"] = {
			["index"] = 123,
		},

	},
	["BINDING_HEADER_MOVEMENT"] = {
		["SITORSTAND"] = {
			["index"] = 9,
		},
		["STRAFERIGHT"] = {
			["key1"] = ".",
			["index"] = 7,
		},
		["FOLLOWTARGET"] = {
			["key1"] = "NUMPAD0",
			["index"] = 17,
			["key2"] = "F",
		},
		["STOPAUTORUN"] = {
			["index"] = 13,
		},
		["PITCHUP"] = {
			["key1"] = "INSERT",
			["index"] = 14,
		},
		["MOVEBACKWARD"] = {
			["key1"] = "S",
			["index"] = 3,
			["key2"] = "DOWN",
		},
		["STRAFELEFT"] = {
			["key1"] = ",",
			["index"] = 6,
		},
		["TOGGLEAUTORUN"] = {
			["key1"] = "ALT-W",
			["index"] = 11,
			["key2"] = "BUTTON4",
		},
		["TOGGLERUN"] = {
			["index"] = 16,
		},
		["TOGGLESHEATH"] = {
			["index"] = 10,
		},
		["STARTAUTORUN"] = {
			["index"] = 12,
		},
		["TURNRIGHT"] = {
			["key1"] = "D",
			["index"] = 5,
		},
		["MOVEANDSTEER"] = {
			["key1"] = "BUTTON3",
			["index"] = 1,
		},
		["PITCHDOWN"] = {
			["key1"] = "DELETE",
			["index"] = 15,
		},
		["MOVEFORWARD"] = {
			["key1"] = "W",
			["index"] = 2,
			["key2"] = "UP",
		},
		["TURNLEFT"] = {
			["key1"] = "A",
			["index"] = 4,
			["key2"] = "LEFT",
		},
		["JUMP"] = {
			["index"] = 8,
		},
	},
	["BINDING_HEADER_ACTIONBAR"] = {
		["ACTIONBUTTON8"] = {
			["key1"] = "8",
			["index"] = 38,
		},
		["ACTIONPAGE4"] = {
			["key1"] = "SHIFT-4",
			["index"] = 66,
		},
		["NEXTACTIONPAGE"] = {
			["key1"] = "SHIFT-DOWN",
			["index"] = 70,
			["key2"] = "SHIFT-MOUSEWHEELDOWN",
		},
		["BONUSACTIONBUTTON7"] = {
			["key1"] = "CTRL-7",
			["index"] = 59,
		},
		["SHAPESHIFTBUTTON2"] = {
			["key1"] = "CTRL-F2",
			["index"] = -1,
		},
		["ACTIONPAGE2"] = {
			["key1"] = "SHIFT-2",
			["index"] = 64,
		},
		["ACTIONPAGE3"] = {
			["key1"] = "SHIFT-3",
			["index"] = 65,
		},
		["SHAPESHIFTBUTTON4"] = {
			["key1"] = "CTRL-F4",
			["index"] = -1,
		},
		["ACTIONBUTTON3"] = {
			["key1"] = "3",
			["index"] = 33,
		},
		["BONUSACTIONBUTTON5"] = {
			["key1"] = "CTRL-5",
			["index"] = 57,
		},
		["ACTIONBUTTON6"] = {
			["key1"] = "6",
			["index"] = 36,
		},
		["SHAPESHIFTBUTTON10"] = {
			["key1"] = "CTRL-F10",
			["index"] = -1,
		},
		["BONUSACTIONBUTTON9"] = {
			["key1"] = "CTRL-9",
			["index"] = 61,
		},
		["SHAPESHIFTBUTTON7"] = {
			["key1"] = "CTRL-F7",
			["index"] = -1,
		},
		["SHAPESHIFTBUTTON5"] = {
			["key1"] = "CTRL-F5",
			["index"] = -1,
		},
		["BONUSACTIONBUTTON4"] = {
			["key1"] = "CTRL-4",
			["index"] = 56,
		},
		["ACTIONBUTTON12"] = {
			["key1"] = "´",
			["index"] = 42,
		},
		["ACTIONBUTTON10"] = {
			["key1"] = "0",
			["index"] = 40,
		},
		["ACTIONBUTTON4"] = {
			["key1"] = "4",
			["index"] = 34,
		},
		["SHAPESHIFTBUTTON1"] = {
			["key1"] = "CTRL-F1",
			["index"] = -1,
		},
		["BONUSACTIONBUTTON2"] = {
			["key1"] = "CTRL-2",
			["index"] = 54,
		},
		["PREVIOUSACTIONPAGE"] = {
			["index"] = 69,
			["key2"] = "SHIFT-MOUSEWHEELUP",
		},
		["TOGGLEAUTOSELFCAST"] = {
			["index"] = 72,
		},
		["TOGGLEACTIONBARLOCK"] = {
			["index"] = 71,
		},
		["SHAPESHIFTBUTTON8"] = {
			["key1"] = "CTRL-F8",
			["index"] = -1,
		},
		["BONUSACTIONBUTTON3"] = {
			["key1"] = "CTRL-3",
			["index"] = 55,
		},
		["SHAPESHIFTBUTTON3"] = {
			["key1"] = "CTRL-F3",
			["index"] = -1,
		},
		["BONUSACTIONBUTTON8"] = {
			["key1"] = "CTRL-8",
			["index"] = 60,
		},
		["ACTIONPAGE5"] = {
			["key1"] = "SHIFT-5",
			["index"] = 67,
		},
		["ACTIONPAGE1"] = {
			["key1"] = "SHIFT-1",
			["index"] = 63,
		},
		["ACTIONBUTTON2"] = {
			["key1"] = "2",
			["index"] = 32,
		},
		["SHAPESHIFTBUTTON6"] = {
			["key1"] = "CTRL-F6",
			["index"] = -1,
		},
		["ACTIONPAGE6"] = {
			["key1"] = "SHIFT-6",
			["index"] = 68,
		},
		["SHAPESHIFTBUTTON9"] = {
			["key1"] = "CTRL-F9",
			["index"] = -1,
		},
		["ACTIONBUTTON7"] = {
			["key1"] = "7",
			["index"] = 37,
		},
		["BONUSACTIONBUTTON6"] = {
			["key1"] = "CTRL-6",
			["index"] = 58,
		},
		["BONUSACTIONBUTTON10"] = {
			["key1"] = "CTRL-0",
			["index"] = 62,
		},
		["ACTIONBUTTON1"] = {
			["key1"] = "1",
			["index"] = 31,
		},
		["BONUSACTIONBUTTON1"] = {
			["key1"] = "CTRL-1",
			["index"] = 53,
		},
		["ACTIONBUTTON5"] = {
			["key1"] = "5",
			["index"] = 35,
		},
		["ACTIONBUTTON11"] = {
			["key1"] = "ß",
			["index"] = 41,
		},
		["ACTIONBUTTON9"] = {
			["key1"] = "9",
			["index"] = 39,
		},
	},
	["BINDING_HEADER_VEHICLE"] = {
		["VEHICLEEXIT"] = {
			["index"] = 258,
		},
		["VEHICLEPREVSEAT"] = {
			["index"] = 259,
		},
		["VEHICLENEXTSEAT"] = {
			["index"] = 260,
		},
		["VEHICLEAIMUP"] = {
			["index"] = 261,
		},
		["VEHICLEAIMDOWN"] = {
			["index"] = 262,
		},
		["VEHICLEAIMINCREMENT"] = {
			["index"] = 263,
		},
		["VEHICLEAIMDECREMENT"] = {
			["index"] = 264,
		},
	},	
	["BINDING_HEADER_INTERFACE"] = {
		["TOGGLEBAG1"] = {
			["index"] = 160,
		},
		["TOGGLECHARACTER2"] = {
			["key1"] = "U",
			["index"] = 168,
		},
		["TOGGLEWHOTAB"] = {
			["index"] = 185,
		},
		["TOGGLEMINIMAP"] = {
			["index"] = 178,
		},
		["TOGGLERAIDTAB"] = {
			["index"] = 187,
		},
		["TOGGLEQUESTLOG"] = {
			["key1"] = "L",
			["index"] = 176,
		},
		["TOGGLEPETBOOK"] = {
			["index"] = 173,
		},
		["TOGGLESPELLBOOK"] = {
			["key1"] = "P",
			["index"] = 172,
		},
		["TOGGLEBLIZZARDGROUPSTAB"] = {
			["index"] = 188,
		},
		["HEADER_BLANK8"] = {
			["index"] = 165,
		},
		["HEADER_BLANK11"] = {
			["index"] = 175,
		},
		["OPENALLBAGS"] = {
			["key1"] = "B",
			["index"] = 164,
		},
		["TOGGLELFGTAB"] = {
			["index"] = 191,
		},
		["TOGGLECHATTAB"] = {
			["index"] = 189,
		},
		["TOGGLEBAG3"] = {
			["index"] = 162,
		},
		["TOGGLECHARACTER1"] = {
			["index"] = 169,
		},
		["TOGGLEBAG4"] = {
			["index"] = 163,
		},
		["TOGGLEGAMEMENU"] = {
			["key1"] = "ESCAPE",
			["index"] = 158,
		},
		["TOGGLEBATTLEFIELDMINIMAP"] = {
			["index"] = 180,
		},
		["HEADER_BLANK7"] = {
			["index"] = 171,
		},
		["TOGGLEFRIENDSTAB"] = {
			["index"] = 184,
		},
		["TOGGLEBAG2"] = {
			["index"] = 161,
		},
		["TOGGLECHARACTER3"] = {
			["index"] = 167,
		},
		["TOGGLEMINIMAPROTATION"] = {
			["index"] = 179,
		},
		["TOGGLELFMTAB"] = {
			["index"] = 192,
		},
		["TOGGLEWORLDMAP"] = {
			["key1"] = "M",
			["index"] = 177,
		},
		["TOGGLELFGPARENT"] = {
			["index"] = 190,
		},
		["TOGGLETALENTS"] = {
			["key1"] = "N",
			["index"] = 174,
		},
		["TOGGLECHARACTER4"] = {
			["index"] = 170,
		},
		["TOGGLEGUILDTAB"] = {
			["key1"] = "J",
			["index"] = 186,
		},
		["TOGGLESOCIAL"] = {
			["key1"] = "O",
			["index"] = 183,
		},
		["HEADER_BLANK12"] = {
			["index"] = 182,
		},
		["TOGGLEWORLDSTATESCORES"] = {
			["key1"] = "SHIFT-SPACE",
			["index"] = 181,
		},
		["TOGGLEBACKPACK"] = {
			["key1"] = "SHIFT-B",
			["index"] = 159,
		},
		["TOGGLECHARACTER0"] = {
			["index"] = 166,
		},
		["TOGGLELFGPARENT"] = {
			["index"] = 268,
		},
		["TOGGLELFGLISTINGTAB"] = {
			["index"] = 269,
		},
		["TOGGLEACHIEVEMENT"] = {
			["index"] = 202,
		},
		["TOGGLESTATISTICS"] = {
			["index"] = 203,
		},
	},
	["BINDING_HEADER_TARGETING"] = {
		["TARGETNEARESTENEMYPLAYER"] = {
			["index"] = 129,
		},
		["TARGETPARTYPET4"] = {
			["index"] = 142,
		},
		["TARGETPARTYMEMBER2"] = {
			["key1"] = "NUMPAD3",
			["index"] = 135,
		},
		["TARGETPARTYMEMBER4"] = {
			["key1"] = "NUMPAD5",
			["index"] = 137,
		},
		["TARGETTALKER"] = {
			["index"] = 157,
		},
		["TARGETPARTYPET3"] = {
			["index"] = 141,
		},
		["TARGETPREVIOUSFRIEND"] = {
			["key1"] = "CTRL-SHIFT-TAB",
			["index"] = 128,
		},
		["TARGETSELF"] = {
			["key1"] = "E",
			["index"] = 133,
			["key2"] = "NUMPAD1",
		},
		["TARGETPARTYPET2"] = {
			["index"] = 140,
		},
		["INTERACTMOUSEOVER"] = {
			["key1"] = "SHIFT-G",
			["index"] = 148,
		},
		["TARGETPREVIOUSENEMY"] = {
			["key1"] = "SHIFT-TAB",
			["index"] = 125,
		},
		["FRIENDNAMEPLATES"] = {
			["key1"] = "SHIFT-V",
			["index"] = 146,
		},
		["TARGETPREVIOUSENEMYPLAYER"] = {
			["index"] = 130,
		},
		["TARGETSCANENEMY"] = {
			["index"] = 126,
		},
		["TARGETNEARESTENEMY"] = {
			["key1"] = "TAB",
			["index"] = 124,
		},
		["TARGETLASTTARGET"] = {
			["key1"] = "H",
			["index"] = 144,
		},
		["TARGETPARTYMEMBER1"] = {
			["key1"] = "Q",
			["index"] = 134,
			["key2"] = "NUMPAD2",
		},
		["ALLNAMEPLATES"] = {
			["key1"] = "CTRL-V",
			["index"] = 147,
		},
		["TARGETNEARESTFRIEND"] = {
			["key1"] = "CTRL-TAB",
			["index"] = 127,
		},
		["TARGETPARTYPET1"] = {
			["index"] = 139,
		},
		["TARGETMOUSEOVER"] = {
			["index"] = 156,
		},
		["TARGETPET"] = {
			["key1"] = "SHIFT-F1",
			["index"] = 138,
		},
		["TARGETFOCUS"] = {
			["key1"] = "NUMPAD6",
			["index"] = 155,
		},
		["NAMEPLATES"] = {
			["index"] = 145,
		},
		["FOCUSTARGET"] = {
			["key1"] = "CTRL-NUMPAD6",
			["index"] = 154,
		},
		["PETATTACK"] = {
			["key1"] = "SHIFT-T",
			["index"] = 153,
		},
		["TARGETNEARESTFRIENDPLAYER"] = {
			["index"] = 131,
		},
		["STARTATTACK"] = {
			["index"] = 152,
		},
		["TARGETLASTHOSTILE"] = {
			["index"] = 143,
		},
		["ATTACKTARGET"] = {
			["key1"] = "T",
			["index"] = 151,
		},
		["ASSISTTARGET"] = {
			["key1"] = "R",
			["index"] = 150,
			["key2"] = "NUMPADDECIMAL",
		},
		["INTERACTTARGET"] = {
			["key1"] = "G",
			["index"] = 149,
		},
		["TARGETPREVIOUSFRIENDPLAYER"] = {
			["index"] = 132,
		},
		["TARGETPARTYMEMBER3"] = {
			["key1"] = "NUMPAD4",
			["index"] = 136,
		},
	},
	["BINDING_HEADER_CHAT"] = {
		["REPLY2"] = {
			["key1"] = "SHIFT-R",
			["index"] = 24,
		},
		["TOGGLE_VOICE_SELF_DEAFEN"] = {
			["index"] = 29,
		},
		["TOGGLE_VOICE_PUSH_TO_TALK"] = {
			["index"] = 30,
		},
		["CHATPAGEUP"] = {
			["key1"] = "PAGEUP",
			["index"] = 20,
		},
		["OPENCHATSLASH"] = {
			["index"] = 19,
		},
		["TOGGLE_VOICE_SELF_MUTE"] = {
			["index"] = 28,
		},
		["CHATBOTTOM"] = {
			["key1"] = "SHIFT-PAGEDOWN",
			["index"] = 22,
		},
		["COMBATLOGBOTTOM"] = {
			["key1"] = "CTRL-SHIFT-PAGEDOWN",
			["index"] = 27,
		},
		["REPLY"] = {
			["index"] = 23,
		},
		["COMBATLOGPAGEUP"] = {
			["key1"] = "CTRL-PAGEUP",
			["index"] = 25,
		},
		["CHATPAGEDOWN"] = {
			["key1"] = "PAGEDOWN",
			["index"] = 21,
		},
		["OPENCHAT"] = {
			["key1"] = "ENTER",
			["index"] = 18,
		},
		["COMBATLOGPAGEDOWN"] = {
			["key1"] = "CTRL-PAGEDOWN",
			["index"] = 26,
		},
	},
	["BINDING_HEADER_MISC"] = {
		["TOGGLESELFHIGHLIGHT"] = {
			["index"] = 207,
		},
		["TOGGLEGRAPHICSSETTINGS"] = {
			["index"] = 206,
		},
		["TOGGLEMUSIC"] = {
			["key1"] = "CTRL-M",
			["index"] = 198,
		},
		["STOPATTACK"] = {
			["index"] = 194,
		},
		["STOPCASTING"] = {
			["index"] = 193,
		},
		["TOGGLEWINDOWED"] = {
			["index"] = 208,
		},
		["ITEMCOMPARISONCYCLING"] = {
			["key1"] = "SHIFT-C",
			["index"] = 205,
		},
		["SCREENSHOT"] = {
			["key1"] = "PRINTSCREEN",
			["index"] = 204,
		},
		["MINIMAPZOOMOUT"] = {
			["key1"] = "NUMPADMINUS",
			["index"] = 197,
		},
		["TOGGLEFPS"] = {
			["key1"] = "CTRL-R",
			["index"] = 203,
		},
		["TOGGLESOUND"] = {
			["key1"] = "CTRL-S",
			["index"] = 199,
		},
		["MASTERVOLUMEUP"] = {
			["key1"] = "CTRL-´",
			["index"] = 200,
		},
		["MASTERVOLUMEDOWN"] = {
			["key1"] = "CTRL-ß",
			["index"] = 201,
		},
		["DISMOUNT"] = {
			["index"] = 195,
		},
		["TOGGLEUI"] = {
			["key1"] = "ALT-Y",
			["index"] = 202,
		},
		["MINIMAPZOOMIN"] = {
			["key1"] = "NUMPADPLUS",
			["index"] = 196,
		},
	},
}

SkuCore.Keys.LocNames = {
	["CTRL"] = CTRL_KEY_TEXT,
	["BACKSPACE"] = KEY_BACKSPACE,
	["BACKSPACE_MAC"] = KEY_BACKSPACE_MAC,
	["DELETE"] = KEY_DELETE,
	["DELETE_MAC"] = KEY_DELETE_MAC,
	["DOWN"] = KEY_DOWN,
	["END"] = KEY_END,
	["ENTER"] = KEY_ENTER,
	["ENTER_MAC"] = KEY_ENTER_MAC,
	["ESCAPE"] = KEY_ESCAPE,
	["HOME"] = KEY_HOME,
	["INSERT"] = KEY_INSERT,
	["INSERT_MAC"] = KEY_INSERT_MAC,
	["LEFT"] = KEY_LEFT,
	["NUMLOCK"] = KEY_NUMLOCK,
	["NUMLOCK_MAC"] = KEY_NUMLOCK_MAC,
	["NUMPAD0"] = KEY_NUMPAD0,
	["NUMPAD1"] = KEY_NUMPAD1,
	["NUMPAD2"] = KEY_NUMPAD2,
	["NUMPAD3"] = KEY_NUMPAD3,
	["NUMPAD4"] = KEY_NUMPAD4,
	["NUMPAD5"] = KEY_NUMPAD5,
	["NUMPAD6"] = KEY_NUMPAD6,
	["NUMPAD7"] = KEY_NUMPAD7,
	["NUMPAD8"] = KEY_NUMPAD8,
	["NUMPAD9"] = KEY_NUMPAD9,
	["NUMPADDECIMAL"] = KEY_NUMPADDECIMAL,
	["NUMPADDIVIDE"] = KEY_NUMPADDIVIDE,
	["NUMPADMINUS"] = KEY_NUMPADMINUS,
	["NUMPADMULTIPLY"] = KEY_NUMPADMULTIPLY,
	["NUMPADPLUS"] = KEY_NUMPADPLUS,
	["PAGEDOWN"] = KEY_PAGEDOWN,
	["PAGEUP"] = KEY_PAGEUP,
	["PAUSE"] = KEY_PAUSE,
	["PAUSE_MAC"] = KEY_PAUSE_MAC,
	["PRINTSCREEN"] = KEY_PRINTSCREEN,
	["PRINTSCREEN_MAC"] = KEY_PRINTSCREEN_MAC,
	["RIGHT"] = KEY_RIGHT,
	["SCROLLLOCK"] = KEY_SCROLLLOCK,
	["SCROLLLOCK_MAC"] = KEY_SCROLLLOCK_MAC,
	["SPACE"] = KEY_SPACE,
	["TAB"] = KEY_TAB,
	["TILDE"] = KEY_TILDE,
	["'"] = L["Apostrophe"],
	["%+"] = L["Plus"],
	["´"] = L["Accent"],
	[","] = L["Comma"],
	["#"] = L["channel"],
}

SkuCore.Errors = SkuCore.Errors or {}

if Sku.Loc == "deDE" then
	SkuCore.Errors.Sounds = {
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_brang.ogg"] = L["error;sound"].."#"..L["brang"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_bring.ogg"] = L["error;sound"].."#"..L["bring"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_dang.ogg"] = L["error;sound"].."#"..L["dang"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_drmm.ogg"] = L["error;sound"].."#"..L["drmm"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_shhhup.ogg"] = L["error;sound"].."#"..L["shhhup"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_spoing.ogg"] = L["error;sound"].."#"..L["spoing"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_swoosh.ogg"] = L["error;sound"].."#"..L["swoosh"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_tsching.ogg"] = L["error;sound"].."#"..L["tsching"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_silent.mp3"] = L["error;sound"].."#"..L["silent"],
		["voice"] = L["vocalized"],
--[[
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_de-de\\error_Range.mp3"] = L["error;sound"].."#"..L["Range"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_de-de\\error_Move.mp3"] = L["error;sound"].."#"..L["Move"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_de-de\\error_LOS.mp3"] = L["error;sound"].."#"..L["LOS"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_de-de\\error_Target.mp3"] = L["error;sound"].."#"..L["Target"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_de-de\\error_IC.mp3"] = L["error;sound"].."#"..L["IC"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_de-de\\error_Res.mp3"] = L["error;sound"].."#"..L["Res"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_de-de\\error_Busy.mp3"] = L["error;sound"].."#"..L["Busy"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_de-de\\error_Dir.mp3"] = L["error;sound"].."#"..L["Dir"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_de-de\\error_Stun.mp3"] = L["error;sound"].."#"..L["Stun"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_de-de\\error_Inter.mp3"] = L["error;sound"].."#"..L["Inter"],

		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_de-de\\error_Range.mp3"] = L["error;sound"].."#Hans;"..L["Range"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_de-de\\error_Move.mp3"] = L["error;sound"].."#Hans;"..L["Move"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_de-de\\error_LOS.mp3"] = L["error;sound"].."#Hans;"..L["LOS"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_de-de\\error_Target.mp3"] = L["error;sound"].."#Hans;"..L["Target"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_de-de\\error_IC.mp3"] = L["error;sound"].."#Hans;"..L["IC"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_de-de\\error_Res.mp3"] = L["error;sound"].."#Hans;"..L["Res"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_de-de\\error_Busy.mp3"] = L["error;sound"].."#Hans;"..L["Busy"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_de-de\\error_Dir.mp3"] = L["error;sound"].."#Hans;"..L["Dir"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_de-de\\error_Stun.mp3"] = L["error;sound"].."#Hans;"..L["Stun"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_de-de\\error_Inter.mp3"] = L["error;sound"].."#Hans;"..L["Inter"],
	]]
	}
elseif Sku.Loc == "enUS" or Sku.Loc == "enGB"  or Sku.Loc == "enAU" then
	SkuCore.Errors.Sounds = {
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_brang.ogg"] = L["error;sound"].."#"..L["brang"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_bring.ogg"] = L["error;sound"].."#"..L["bring"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_dang.ogg"] = L["error;sound"].."#"..L["dang"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_drmm.ogg"] = L["error;sound"].."#"..L["drmm"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_shhhup.ogg"] = L["error;sound"].."#"..L["shhhup"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_spoing.ogg"] = L["error;sound"].."#"..L["spoing"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_swoosh.ogg"] = L["error;sound"].."#"..L["swoosh"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_tsching.ogg"] = L["error;sound"].."#"..L["tsching"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_silent.mp3"] = L["error;sound"].."#"..L["silent"],
		["voice"] = L["vocalized"],
--[[
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_en-us\\error_Range.mp3"] = L["error;sound"].."#"..L["Range"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_en-us\\error_Move.mp3"] = L["error;sound"].."#"..L["Move"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_en-us\\error_LOS.mp3"] = L["error;sound"].."#"..L["LOS"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_en-us\\error_Target.mp3"] = L["error;sound"].."#"..L["Target"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_en-us\\error_IC.mp3"] = L["error;sound"].."#"..L["IC"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_en-us\\error_Res.mp3"] = L["error;sound"].."#"..L["Res"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_en-us\\error_Busy.mp3"] = L["error;sound"].."#"..L["Busy"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_en-us\\error_Dir.mp3"] = L["error;sound"].."#"..L["Dir"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_en-us\\error_Stun.mp3"] = L["error;sound"].."#"..L["Stun"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\marlene_en-us\\error_Inter.mp3"] = L["error;sound"].."#"..L["Inter"],

		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_en-us\\error_Range.mp3"] = L["error;sound"].."#Hans;"..L["Range"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_en-us\\error_Move.mp3"] = L["error;sound"].."#Hans;"..L["Move"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_en-us\\error_LOS.mp3"] = L["error;sound"].."#Hans;"..L["LOS"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_en-us\\error_Target.mp3"] = L["error;sound"].."#Hans;"..L["Target"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_en-us\\error_IC.mp3"] = L["error;sound"].."#Hans;"..L["IC"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_en-us\\error_Res.mp3"] = L["error;sound"].."#Hans;"..L["Res"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_en-us\\error_Busy.mp3"] = L["error;sound"].."#Hans;"..L["Busy"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_en-us\\error_Dir.mp3"] = L["error;sound"].."#Hans;"..L["Dir"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_en-us\\error_Stun.mp3"] = L["error;sound"].."#Hans;"..L["Stun"],
		["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\hans_en-us\\error_Inter.mp3"] = L["error;sound"].."#Hans;"..L["Inter"],
	]]
	}	
end

SkuCore.RangeCheckSounds = {
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_brang.ogg"] = L["sound"].."#"..L["brang"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_bring.ogg"] = L["sound"].."#"..L["bring"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_dang.ogg"] = L["sound"].."#"..L["dang"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_drmm.ogg"] = L["sound"].."#"..L["drmm"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_shhhup.ogg"] = L["sound"].."#"..L["shhhup"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_spoing.ogg"] = L["sound"].."#"..L["spoing"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_swoosh.ogg"] = L["sound"].."#"..L["swoosh"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_tsching.ogg"] = L["sound"].."#"..L["tsching"],
   ["Interface\\AddOns\\Sku\\SkuCore\\assets\\audio\\error\\error_silent.mp3"] = L["sound"].."#"..L["silent"],
}

SKU_CONSTANTS = {
	["SOUNDCHANNELS"] = {
		["Master"] = L["Gesamt"],
		["SFX"] = L["Soundeffekte"],
		["Music"] = L["Musik"],
		["Ambience"] = L["Umgebung"],
		["Dialog"] = L["Dialog"],
		["Talking Head"] = L["Sku"],
	},
}

SkuCore.BackgroundSoundFiles = {
	["silence.mp3"] = L["Nichts"],
	["benny_hill.mp3"] = L["Benny Hill"],
	["chor1.mp3"] = L["Chormusik 1"],
	["chor2.mp3"] = L["Chormusik 2"],
	["chor3.mp3"] = L["Chormusik 3"],
	["chor4.mp3"] = L["Chormusik 4"],
	["entspannungsmusik.mp3"] = L["Entspannungsmusik"],
	["gewitter.mp3"] = L["Gewitter"],
	["nachts_im_wald.mp3"] = L["Nachts im Wald"],
	["wald.mp3"] = L["Vögel"],
	["walgesang.mp3"] = L["Walgesang"],
	["slowreggaet.mp3"] = L["Slow Reggae"],
	["catpurrwaterdrop.mp3"] = L["purr drop"],
	["creaking-wood.mp3"] = L["creaking"],
	["electric-sparks.mp3"] = L["sparks"],
	["film_running.mp3"] = L["film"],
	["fly-fishing-reel-running.mp3"] = L["fishing reel"],
	["nikonf4.mp3"] = L["shutter"],
	["spinning-reel.mp3"] = L["spinning"],
	["gear-spinning-loop.mp3"] = L["gear"],
	["tools-ratchet.mp3"] = L["ratchet"],
	["typing.mp3"] = L["typing"],
	["windscreen-wipers.mp3"] = L["wipe"],
}
SkuCore.BackgroundSoundFilesLen = {
	["benny_hill.mp3"] = 238,8,
	["chor1.mp3"] = 167,75,
	["chor2.mp3"] = 186,55,
	["chor3.mp3"] = 62.841541666666664,
	["chor4.mp3"] = 317,15,
	["entspannungsmusik.mp3"] = 112,95,
	["gewitter.mp3"] = 125,91,
	["nachts_im_wald.mp3"] = 100,41,
	["wald.mp3"] = 59,13,
	["walgesang.mp3"] = 141,37,
	["slowreggaet.mp3"] = 152,36,
	["catpurrwaterdrop.mp3"] = 133.034,
	["creaking-wood.mp3"] = 15.677,
	["electric-sparks.mp3"] = 11.424,
	["film_running.mp3"] = 16.418,
	["fly-fishing-reel-running.mp3"] = 8.930,
	["nikonf4.mp3"] = 18.775,
	["spinning-reel.mp3"] = 6.013,
	["gear-spinning-loop.mp3"] = 12.266,
	["tools-ratchet.mp3"] = 16.187,
	["typing.mp3"] = 16.861,
	["windscreen-wipers.mp3"] = 32.738,
}

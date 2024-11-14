﻿local MODULE_NAME = "SkuChat"
local _G = _G
local L = Sku.L

SkuChat = LibStub("AceAddon-3.0"):NewAddon("SkuChat", "AceConsole-3.0", "AceEvent-3.0")

Sku_CombatLog_Filter_Defaults = {}


local play = 2	--this is just a local constant for output type (play, true, false)
local zoneChannels = {
	general = 1,
	trade = 2,
	localdefense = 22,
	worlddefense = 23,
	guildrecruitment = 25,
	lookingforgroup = 26,
}

SkuChat.defaultHistoryMax = 100
SkuChat.maxTabs = 20
SkuChat.ChatFrameMessageTypes = {
	PLAYER_MESSAGES = {
		[1] = {
			type = "SAY",
			default = true,
		},
		[2] = {
			type = "EMOTE",
			default = true,
		},
		[3] = {
			type = "YELL",
			default = true,
		},
		[4] = {
			text = GUILD_CHAT,
			type = "GUILD",
			default = play,
		},
		[5] = {
			text = OFFICER_CHAT,
			type = "OFFICER",
			default = play,
		},
		[6] = {
			type = "WHISPER",
			default = play,
		},
		[7] = {
			type = "BN_WHISPER",
			default = play,
		},
		[8] = {
			type = "PARTY",
			default = play,
		},
		[9] = {
			type = "PARTY_LEADER",
			default = play,
		},
		[10] = {
			type = "RAID",
			default = play,
		},
		[11] = {
			type = "RAID_LEADER",
			default = play,
		},
		[12] = {
			type = "RAID_WARNING",
			default = play,
		},
		[13] = {
			type = "INSTANCE_CHAT",
			default = play,
		},
		[14] = {
			type = "INSTANCE_CHAT_LEADER",
			default = play,
		},
	},

	CREATURE_MESSAGES = {
		[1] = {
			text = SAY;
			type = "MONSTER_SAY",
			default = play,
		},
		[2] = {
			text = EMOTE;
			type = "MONSTER_EMOTE",
			default = play,
		},
		[3] = {
			text = YELL;
			type = "MONSTER_YELL",
			default = play,
		},
		[4] = {
			text = WHISPER;
			type = "MONSTER_WHISPER",
			default = play,
		},
		[5] = {
			type = "MONSTER_BOSS_EMOTE",
			default = play,
		},
		[6] = {
			type = "MONSTER_BOSS_WHISPER",
			default = play,
		}
	},

	OTHER = {
		[1] = {
			text = SKILLUPS,
			type = "SKILL",
			default = true,
			},
		[2] = {
			text = ITEM_LOOT,
			type = "LOOT",
			default = true,
			},
		[3] = {
			text = MONEY_LOOT,
			type = "MONEY",
			default = true,
			},
		[4] = {
			type = "TRADESKILLS",
			default = true,
			},
		[5] = {
			type = "OPENING",
			default = true,
			},
		[6] = {
			type = "PET_INFO",
			default = true,
			},
	},

	PVP = {
		[1] = {
			text = BG_SYSTEM_HORDE,
			type = "BG_HORDE",
			default = false,
		},
		[2] = {
			text = BG_SYSTEM_ALLIANCE,
			type = "BG_ALLIANCE",
			default = false,
		},
		[3] = {
			text = BG_SYSTEM_NEUTRAL,
			type = "BG_NEUTRAL",
			default = false,
		},
	},

	SYSTEM = {
		[1] = {
			text = SYSTEM_MESSAGES,
			type = "SYSTEM",
			default = true,
		},
		[2] = {
			type = "ERRORS",
			default = true,
		},
		[3] = {
			type = "IGNORED",
			default = true,
		},
		[4] = {
			type = "CHANNEL",
			default = true,
		},
		[5] = {
			type = "TARGETICONS",
			default = true,
		},
		[6] = {
			type = "BN_INLINE_TOAST_ALERT",
			default = true,
		},
		[7] = {
			text = L["Addons"],
			type = "ADDON",
			default = play,
		},		
	},
	
	COMBAT = {
		[1] = {
			type = "COMBAT_XP_GAIN",
			default = true,
		},
		[2] = {
			type = "COMBAT_HONOR_GAIN",
			default = true,
		},
		[3] = {
			type = "COMBAT_FACTION_CHANGE",
			default = true,
		},
		[5] = {
			type = "COMBAT_MISC_INFO",
			default = true,
		},
	},

	SKU = {
		[1] = {
			type = "COMBATLOG",
			default = false,
		},
		[2] = {
			type = "AUDIOLOG",
			default = false,
		}
	},
}

SkuChat.ChatFrameDefaultTabs = {
	[L["Default"]] = {
		PLAYER_MESSAGES = {
			[1] = {
				type = "SAY",
				default = play,
			},
			[2] = {
				type = "EMOTE",
				default = play,
			},
			[3] = {
				type = "YELL",
				default = play,
			},
			[4] = {
				text = GUILD_CHAT,
				type = "GUILD",
				default = false,
			},
			[5] = {
				text = OFFICER_CHAT,
				type = "OFFICER",
				default = false,
			},
			[6] = {
				type = "WHISPER",
				default = false,
			},
			[7] = {
				type = "BN_WHISPER",
				default = false,
			},
			[8] = {
				type = "PARTY",
				default = false,
			},
			[9] = {
				type = "PARTY_LEADER",
				default = false,
			},
			[10] = {
				type = "RAID",
				default = false,
			},
			[11] = {
				type = "RAID_LEADER",
				default = false,
			},
			[12] = {
				type = "RAID_WARNING",
				default = false,
			},
			[13] = {
				type = "INSTANCE_CHAT",
				default = false,
			},
			[14] = {
				type = "INSTANCE_CHAT_LEADER",
				default = false,
			},
		},
	
		CREATURE_MESSAGES = {
			[1] = {
				text = SAY;
				type = "MONSTER_SAY",
				default = play,
			},
			[2] = {
				text = EMOTE;
				type = "MONSTER_EMOTE",
				default = play,
			},
			[3] = {
				text = YELL;
				type = "MONSTER_YELL",
				default = play,
			},
			[4] = {
				text = WHISPER;
				type = "MONSTER_WHISPER",
				default = false,
			},
			[5] = {
				type = "MONSTER_BOSS_EMOTE",
				default = false,
			},
			[6] = {
				type = "MONSTER_BOSS_WHISPER",
				default = false,
			}
		},
	
		OTHER = {
			[1] = {
				text = SKILLUPS,
				type = "SKILL",
				default = false,
				},
			[2] = {
				text = ITEM_LOOT,
				type = "LOOT",
				default = false,
				},
			[3] = {
				text = MONEY_LOOT,
				type = "MONEY",
				default = false,
				},
			[4] = {
				type = "TRADESKILLS",
				default = false,
				},
			[5] = {
				type = "OPENING",
				default = false,
				},
			[6] = {
				type = "PET_INFO",
				default = false,
				},
		},
	
		PVP = {
			[1] = {
				text = BG_SYSTEM_HORDE,
				type = "BG_HORDE",
				default = false,
			},
			[2] = {
				text = BG_SYSTEM_ALLIANCE,
				type = "BG_ALLIANCE",
				default = false,
			},
			[3] = {
				text = BG_SYSTEM_NEUTRAL,
				type = "BG_NEUTRAL",
				default = false,
			},
		},
	
		SYSTEM = {
			[1] = {
				text = SYSTEM_MESSAGES,
				type = "SYSTEM",
				default = true,
			},
			[2] = {
				type = "ERRORS",
				default = true,
			},
			[3] = {
				type = "IGNORED",
				default = true,
			},
			[4] = {
				type = "CHANNEL",
				default = true,
			},
			[5] = {
				type = "TARGETICONS",
				default = true,
			},
			[6] = {
				type = "BN_INLINE_TOAST_ALERT",
				default = true,
			},
			[7] = {
				text = L["Addons"],
				type = "ADDON",
				default = play,
			},		
		},
		
		COMBAT = {
			[1] = {
				type = "COMBAT_XP_GAIN",
				default = true,
			},
			[2] = {
				type = "COMBAT_HONOR_GAIN",
				default = true,
			},
			[3] = {
				type = "COMBAT_FACTION_CHANGE",
				default = true,
			},
			[5] = {
				type = "COMBAT_MISC_INFO",
				default = true,
			},
		},
	},
	[L["Communication"]] = {
		PLAYER_MESSAGES = {
			[1] = {
				type = "SAY",
				default = false,
			},
			[2] = {
				type = "EMOTE",
				default = false,
			},
			[3] = {
				type = "YELL",
				default = false,
			},
			[4] = {
				text = GUILD_CHAT,
				type = "GUILD",
				default = play,
			},
			[5] = {
				text = OFFICER_CHAT,
				type = "OFFICER",
				default = play,
			},
			[6] = {
				type = "WHISPER",
				default = play,
			},
			[7] = {
				type = "BN_WHISPER",
				default = play,
			},
			[8] = {
				type = "PARTY",
				default = play,
			},
			[9] = {
				type = "PARTY_LEADER",
				default = play,
			},
			[10] = {
				type = "RAID",
				default = play,
			},
			[11] = {
				type = "RAID_LEADER",
				default = play,
			},
			[12] = {
				type = "RAID_WARNING",
				default = play,
			},
			[13] = {
				type = "INSTANCE_CHAT",
				default = play,
			},
			[14] = {
				type = "INSTANCE_CHAT_LEADER",
				default = play,
			},
		},
	
		CREATURE_MESSAGES = {
			[1] = {
				text = SAY;
				type = "MONSTER_SAY",
				default = false,
			},
			[2] = {
				text = EMOTE;
				type = "MONSTER_EMOTE",
				default = false,
			},
			[3] = {
				text = YELL;
				type = "MONSTER_YELL",
				default = false,
			},
			[4] = {
				text = WHISPER;
				type = "MONSTER_WHISPER",
				default = play,
			},
			[5] = {
				type = "MONSTER_BOSS_EMOTE",
				default = play,
			},
			[6] = {
				type = "MONSTER_BOSS_WHISPER",
				default = play,
			}
		},
	
		OTHER = {
			[1] = {
				text = SKILLUPS,
				type = "SKILL",
				default = false,
				},
			[2] = {
				text = ITEM_LOOT,
				type = "LOOT",
				default = false,
				},
			[3] = {
				text = MONEY_LOOT,
				type = "MONEY",
				default = false,
				},
			[4] = {
				type = "TRADESKILLS",
				default = false,
				},
			[5] = {
				type = "OPENING",
				default = false,
				},
			[6] = {
				type = "PET_INFO",
				default = false,
				},
		},
	
		PVP = {
			[1] = {
				text = BG_SYSTEM_HORDE,
				type = "BG_HORDE",
				default = false,
			},
			[2] = {
				text = BG_SYSTEM_ALLIANCE,
				type = "BG_ALLIANCE",
				default = false,
			},
			[3] = {
				text = BG_SYSTEM_NEUTRAL,
				type = "BG_NEUTRAL",
				default = false,
			},
		},
	
		SYSTEM = {
			[1] = {
				text = SYSTEM_MESSAGES,
				type = "SYSTEM",
				default = false,
			},
			[2] = {
				type = "ERRORS",
				default = false,
			},
			[3] = {
				type = "IGNORED",
				default = false,
			},
			[4] = {
				type = "CHANNEL",
				default = false,
			},
			[5] = {
				type = "TARGETICONS",
				default = false,
			},
			[6] = {
				type = "BN_INLINE_TOAST_ALERT",
				default = false,
			},
			[7] = {
				text = L["Addons"],
				type = "ADDON",
				default = false,
			},		
		},
		
		COMBAT = {
			[1] = {
				type = "COMBAT_XP_GAIN",
				default = false,
			},
			[2] = {
				type = "COMBAT_HONOR_GAIN",
				default = false,
			},
			[3] = {
				type = "COMBAT_FACTION_CHANGE",
				default = false,
			},
			[5] = {
				type = "COMBAT_MISC_INFO",
				default = false,
			},
		},
	},
	[L["Other"]] = {
		PLAYER_MESSAGES = {
			[1] = {
				type = "SAY",
				default = false,
			},
			[2] = {
				type = "EMOTE",
				default = false,
			},
			[3] = {
				type = "YELL",
				default = false,
			},
			[4] = {
				text = GUILD_CHAT,
				type = "GUILD",
				default = false,
			},
			[5] = {
				text = OFFICER_CHAT,
				type = "OFFICER",
				default = false,
			},
			[6] = {
				type = "WHISPER",
				default = false,
			},
			[7] = {
				type = "BN_WHISPER",
				default = false,
			},
			[8] = {
				type = "PARTY",
				default = false,
			},
			[9] = {
				type = "PARTY_LEADER",
				default = false,
			},
			[10] = {
				type = "RAID",
				default = false,
			},
			[11] = {
				type = "RAID_LEADER",
				default = false,
			},
			[12] = {
				type = "RAID_WARNING",
				default = false,
			},
			[13] = {
				type = "INSTANCE_CHAT",
				default = false,
			},
			[14] = {
				type = "INSTANCE_CHAT_LEADER",
				default = false,
			},
		},
	
		CREATURE_MESSAGES = {
			[1] = {
				text = SAY;
				type = "MONSTER_SAY",
				default = false,
			},
			[2] = {
				text = EMOTE;
				type = "MONSTER_EMOTE",
				default = false,
			},
			[3] = {
				text = YELL;
				type = "MONSTER_YELL",
				default = false,
			},
			[4] = {
				text = WHISPER;
				type = "MONSTER_WHISPER",
				default = false,
			},
			[5] = {
				type = "MONSTER_BOSS_EMOTE",
				default = false,
			},
			[6] = {
				type = "MONSTER_BOSS_WHISPER",
				default = false,
			}
		},
	
		OTHER = {
			[1] = {
				text = SKILLUPS,
				type = "SKILL",
				default = true,
				},
			[2] = {
				text = ITEM_LOOT,
				type = "LOOT",
				default = true,
				},
			[3] = {
				text = MONEY_LOOT,
				type = "MONEY",
				default = true,
				},
			[4] = {
				type = "TRADESKILLS",
				default = true,
				},
			[5] = {
				type = "OPENING",
				default = true,
				},
			[6] = {
				type = "PET_INFO",
				default = true,
				},
		},
	
		PVP = {
			[1] = {
				text = BG_SYSTEM_HORDE,
				type = "BG_HORDE",
				default = false,
			},
			[2] = {
				text = BG_SYSTEM_ALLIANCE,
				type = "BG_ALLIANCE",
				default = false,
			},
			[3] = {
				text = BG_SYSTEM_NEUTRAL,
				type = "BG_NEUTRAL",
				default = false,
			},
		},
	
		SYSTEM = {
			[1] = {
				text = SYSTEM_MESSAGES,
				type = "SYSTEM",
				default = false,
			},
			[2] = {
				type = "ERRORS",
				default = false,
			},
			[3] = {
				type = "IGNORED",
				default = false,
			},
			[4] = {
				type = "CHANNEL",
				default = false,
			},
			[5] = {
				type = "TARGETICONS",
				default = false,
			},
			[6] = {
				type = "BN_INLINE_TOAST_ALERT",
				default = false,
			},
			[7] = {
				text = L["Addons"],
				type = "ADDON",
				default = play,
			},		
		},
		
		COMBAT = {
			[1] = {
				type = "COMBAT_XP_GAIN",
				default = false,
			},
			[2] = {
				type = "COMBAT_HONOR_GAIN",
				default = false,
			},
			[3] = {
				type = "COMBAT_FACTION_CHANGE",
				default = false,
			},
			[5] = {
				type = "COMBAT_MISC_INFO",
				default = false,
			},
		},
	},
}


---------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------
-- start of blizzard chatframe code
-- we are just re-using and customizing that for our virtual chat frames instead of building all that from scratch


---------------------------------------------------------------------------------------------------------------------------------------
-- Table for event indexed chatFilters.
-- Format ["CHAT_MSG_SYSTEM"] = { function1, function2, function3 }
-- filter, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11 = function1 (self, event, ...) if filter then return true end return false, ... end
local chatFilters = {} 

---------------------------------------------------------------------------------------------------------------------------------------
SkuChatChatTypeGroup = {} 
SkuChatChatTypeGroup["SYSTEM"] = {
	"CHAT_MSG_SYSTEM",
	"TIME_PLAYED_MSG",
	"PLAYER_LEVEL_UP",
	"CHARACTER_POINTS_CHANGED",
	"CHAT_MSG_BN_WHISPER_PLAYER_OFFLINE",
} 
SkuChatChatTypeGroup["SAY"] = {
	"CHAT_MSG_SAY",
} 
SkuChatChatTypeGroup["EMOTE"] = {
	"CHAT_MSG_EMOTE",
	"CHAT_MSG_TEXT_EMOTE",
} 
SkuChatChatTypeGroup["YELL"] = {
	"CHAT_MSG_YELL",
} 
SkuChatChatTypeGroup["WHISPER"] = {
	"CHAT_MSG_WHISPER",
	"CHAT_MSG_WHISPER_INFORM",
	"CHAT_MSG_AFK",
	"CHAT_MSG_DND",
} 
SkuChatChatTypeGroup["PARTY"] = {
	"CHAT_MSG_PARTY",
	"CHAT_MSG_MONSTER_PARTY",
} 
SkuChatChatTypeGroup["PARTY_LEADER"] = {
	"CHAT_MSG_PARTY_LEADER",
} 
SkuChatChatTypeGroup["RAID"] = {
	"CHAT_MSG_RAID",
} 
SkuChatChatTypeGroup["RAID_LEADER"] = {
	"CHAT_MSG_RAID_LEADER",
} 
SkuChatChatTypeGroup["RAID_WARNING"] = {
	"CHAT_MSG_RAID_WARNING",
} 
SkuChatChatTypeGroup["INSTANCE_CHAT"] = {
	"CHAT_MSG_INSTANCE_CHAT",
} 
SkuChatChatTypeGroup["INSTANCE_CHAT_LEADER"] = {
	"CHAT_MSG_INSTANCE_CHAT_LEADER",
} 
SkuChatChatTypeGroup["GUILD"] = {
	"CHAT_MSG_GUILD",
	"GUILD_MOTD",
} 
SkuChatChatTypeGroup["OFFICER"] = {
	"CHAT_MSG_OFFICER",
} 
SkuChatChatTypeGroup["MONSTER_SAY"] = {
	"CHAT_MSG_MONSTER_SAY",
} 
SkuChatChatTypeGroup["MONSTER_YELL"] = {
	"CHAT_MSG_MONSTER_YELL",
} 
SkuChatChatTypeGroup["MONSTER_EMOTE"] = {
	"CHAT_MSG_MONSTER_EMOTE",
} 
SkuChatChatTypeGroup["MONSTER_WHISPER"] = {
	"CHAT_MSG_MONSTER_WHISPER",
} 
SkuChatChatTypeGroup["MONSTER_BOSS_EMOTE"] = {
	"CHAT_MSG_RAID_BOSS_EMOTE",
} 
SkuChatChatTypeGroup["MONSTER_BOSS_WHISPER"] = {
	"CHAT_MSG_RAID_BOSS_WHISPER",
} 
SkuChatChatTypeGroup["ERRORS"] = {
	"CHAT_MSG_RESTRICTED",
	"CHAT_MSG_FILTERED",
} 
SkuChatChatTypeGroup["AFK"] = {
	"CHAT_MSG_AFK",
} 
SkuChatChatTypeGroup["DND"] = {
	"CHAT_MSG_DND",
} 
SkuChatChatTypeGroup["IGNORED"] = {
	"CHAT_MSG_IGNORED",
} 
SkuChatChatTypeGroup["BG_HORDE"] = {
	"CHAT_MSG_BG_SYSTEM_HORDE",
} 
SkuChatChatTypeGroup["BG_ALLIANCE"] = {
	"CHAT_MSG_BG_SYSTEM_ALLIANCE",
} 
SkuChatChatTypeGroup["BG_NEUTRAL"] = {
	"CHAT_MSG_BG_SYSTEM_NEUTRAL",
} 
SkuChatChatTypeGroup["COMBAT_XP_GAIN"] = {
	"CHAT_MSG_COMBAT_XP_GAIN" 
}
SkuChatChatTypeGroup["COMBAT_HONOR_GAIN"] = {
	"CHAT_MSG_COMBAT_HONOR_GAIN" 
}
SkuChatChatTypeGroup["COMBAT_FACTION_CHANGE"] = {
	"CHAT_MSG_COMBAT_FACTION_CHANGE" 
} 
SkuChatChatTypeGroup["SKILL"] = {
	"CHAT_MSG_SKILL",
} 
SkuChatChatTypeGroup["LOOT"] = {
	"CHAT_MSG_LOOT",
} 
SkuChatChatTypeGroup["MONEY"] = {
	"CHAT_MSG_MONEY",
} 
SkuChatChatTypeGroup["CURRENCY"] = {
	"CHAT_MSG_CURRENCY",
} 
SkuChatChatTypeGroup["OPENING"] = {
	"CHAT_MSG_OPENING" 
} 
SkuChatChatTypeGroup["TRADESKILLS"] = {
	"CHAT_MSG_TRADESKILLS" 
} 
SkuChatChatTypeGroup["PET_INFO"] = {
	"CHAT_MSG_PET_INFO" 
} 
SkuChatChatTypeGroup["COMBAT_MISC_INFO"] = {
	"CHAT_MSG_COMBAT_MISC_INFO" 
} 
SkuChatChatTypeGroup["ACHIEVEMENT"] = {
	"CHAT_MSG_ACHIEVEMENT" 
} 
SkuChatChatTypeGroup["CHANNEL"] = {
	"CHAT_MSG_CHANNEL_JOIN",
	"CHAT_MSG_CHANNEL_LEAVE",
	"CHAT_MSG_CHANNEL_NOTICE",
	"CHAT_MSG_CHANNEL_NOTICE_USER",
	"CHAT_MSG_CHANNEL_LIST",
} 
--[[
SkuChatChatTypeGroup["COMMUNITIES_CHANNEL"] = {
	"CHAT_MSG_COMMUNITIES_CHANNEL",
}
]]
SkuChatChatTypeGroup["TARGETICONS"] = {
	"CHAT_MSG_TARGETICONS"
} 
SkuChatChatTypeGroup["BN_WHISPER"] = {
	"CHAT_MSG_BN_WHISPER",
	"CHAT_MSG_BN_WHISPER_INFORM",
} 
SkuChatChatTypeGroup["BN_INLINE_TOAST_ALERT"] = {
	"CHAT_MSG_BN_INLINE_TOAST_ALERT",
	"CHAT_MSG_BN_INLINE_TOAST_BROADCAST",
	"CHAT_MSG_BN_INLINE_TOAST_BROADCAST_INFORM",
} 
SkuChatChatTypeGroup["VOICE_TEXT"] = {
	"CHAT_MSG_VOICE_TEXT",
} 

SkuChatChatTypeGroup["COMBATLOG"] = {
	"SKU_COMBATLOG",
} 
SkuChatChatTypeGroup["AUDIOLOG"] = {
	"SKU_AUDIOLOG",
} 

---------------------------------------------------------------------------------------------------------------------------------------
SkuChatChatTypeGroupInverted = {} 
for group, values in pairs(SkuChatChatTypeGroup) do
	for _, value in pairs(values) do
		SkuChatChatTypeGroupInverted[value] = group 
	end
end

SkuChatCHAT_CATEGORY_LIST = {
	PARTY = { "PARTY_LEADER", "PARTY_GUIDE", "MONSTER_PARTY" },
	RAID = { "RAID_LEADER", "RAID_WARNING" },
	GUILD = { "GUILD_ACHIEVEMENT", "GUILD_ITEM_LOOTED" },
	WHISPER = { "WHISPER_INFORM", "AFK", "DND" },
	CHANNEL = { "CHANNEL_JOIN", "CHANNEL_LEAVE", "CHANNEL_NOTICE", "CHANNEL_USER", "CHANNEL_NOTICE_USER" },
	INSTANCE_CHAT = { "INSTANCE_CHAT_LEADER" },
	BN_WHISPER = { "BN_WHISPER_INFORM" },
} 

SkuChatCHAT_INVERTED_CATEGORY_LIST = {} 
for category, sublist in pairs(SkuChatCHAT_CATEGORY_LIST) do
	for _, item in pairs(sublist) do
		SkuChatCHAT_INVERTED_CATEGORY_LIST[item] = category 
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function MaskBattleNetNames(aString)
	if string.find(aString, "|K") then
		aString = string.gsub(aString, "|K", "$skuk1")
		aString = string.gsub(aString, "|k", "$skuk2")
	end
	return aString
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChatChat_GetChatCategory(chatType)
	return SkuChatCHAT_INVERTED_CATEGORY_LIST[chatType] or chatType 
end

local MAX_COMMUNITY_NAME_LENGTH = 12 
local MAX_COMMUNITY_NAME_LENGTH_NO_CHANNEL = 24 
function SkuChat_TruncateToMaxLength(text, maxLength)
	local length = strlenutf8(text) 
	if ( length > maxLength ) then
		return text:sub(1, maxLength - 2).."..." 
	end

	return text 
end

function SkuChat_ResolvePrefixedChannelName(communityChannel)
	communityChannel = SkuChat:ShortenChannelName(communityChannel)

	local prefix, communityChannel = communityChannel:match("(%d+. )(.*)") 
	return prefix..SkuChat_ResolveChannelName(communityChannel) 
end

function SkuChat_GetCommunityAndStreamFromChannel(communityChannel)
	local clubId, streamId = communityChannel:match("(%d+)%:(%d+)") 
	return tonumber(clubId), tonumber(streamId) 
end

function SkuChat_ResolveChannelName(communityChannel)
	local clubId, streamId = SkuChat_GetCommunityAndStreamFromChannel(communityChannel) 
	if not clubId or not streamId then
		return communityChannel 
	end

	return SkuChat_GetCommunityAndStreamName(clubId, streamId) 
end

function SkuChat_GetCommunityAndStreamName(clubId, streamId)
	local streamInfo = C_Club.GetStreamInfo(clubId, streamId) 
	local streamName = streamInfo and SkuChat_TruncateToMaxLength(streamInfo.name, MAX_COMMUNITY_NAME_LENGTH) or "" 
	local clubInfo = C_Club.GetClubInfo(clubId) 
	if streamInfo and streamInfo.streamType == Enum.ClubStreamType.General then
		local communityName = clubInfo and SkuChat_TruncateToMaxLength(clubInfo.shortName or clubInfo.name, MAX_COMMUNITY_NAME_LENGTH_NO_CHANNEL) or "" 
		return communityName 
	else
		local communityName = clubInfo and SkuChat_TruncateToMaxLength(clubInfo.shortName or clubInfo.name, MAX_COMMUNITY_NAME_LENGTH) or "" 
		return communityName.." - "..streamName 
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat_OnLoad(self)
	self:RegisterEvent("PLAYER_ENTERING_WORLD") 
	self:RegisterEvent("UPDATE_CHAT_COLOR") 
	self:RegisterEvent("UPDATE_CHAT_WINDOWS") 
	self:RegisterEvent("CHAT_MSG_CHANNEL") 
	--self:RegisterEvent("CHAT_MSG_COMMUNITIES_CHANNEL") 
	self:RegisterEvent("UPDATE_INSTANCE_INFO") 
	self:RegisterEvent("UPDATE_CHAT_COLOR_NAME_BY_CLASS") 
	self:RegisterEvent("VARIABLES_LOADED") 
	self:RegisterEvent("CHAT_SERVER_DISCONNECTED") 
	self:RegisterEvent("CHAT_SERVER_RECONNECTED") 
	self:RegisterEvent("BN_CONNECTED") 
	self:RegisterEvent("BN_DISCONNECTED") 
	self:RegisterEvent("PLAYER_REPORT_SUBMITTED") 
	self:RegisterEvent("ALTERNATIVE_DEFAULT_LANGUAGE_CHANGED") 
	self:RegisterEvent("NOTIFY_CHAT_SUPPRESSED") 
	self:RegisterEvent("CHANNEL_UI_UPDATE") 

	self.defaultLanguage = GetDefaultLanguage()  --If PLAYER_ENTERING_WORLD hasn't been called yet, this is nil, but it'll be fixed whent he event is fired.
	self.alternativeDefaultLanguage = GetAlternativeDefaultLanguage() 
end

function SkuChat_RegisterForMessages(self, aTable)
	local messageGroup 
	local index = 1 
	for i = 1, #aTable do
		messageGroup = SkuChatChatTypeGroup[aTable[i]] 
		if ( messageGroup ) then
			self.messageTypeList[index] = aTable[i] 
			for index, value in pairs(messageGroup) do
				self:RegisterEvent(value) 
				if ( value == "CHAT_MSG_VOICE_TEXT" ) then
					self:RegisterEvent("VOICE_CHAT_CHANNEL_TRANSCRIBING_CHANGED") 
				end
			end
			index = index + 1 
		end
	end
end

function SkuChat_RegisterForChannels(self, ...)
	local index = 1 
	for i=1, select("#", ...), 2 do
		self.channelList[index], self.zoneChannelList[index] = select(i, ...) 
		index = index + 1 
	end
end

function SkuChat_AddMessageGroup(chatFrame, group)
	local info = SkuChatChatTypeGroup[group] 
	if ( info ) then
		tinsert(chatFrame.messageTypeList, group) 
		for index, value in pairs(info) do
			if group == "COMBATLOG" or group == "AUDIOLOG" then
				SkuDispatcher:RegisterEventCallback(value, SkuChat_SkuMessageEventHandler)
			else
				chatFrame:RegisterEvent(value) 
			end
		end
	end
end

function SkuChat_ContainsMessageGroup(chatFrame, group)
	for i, messageType in pairs(chatFrame.messageTypeList) do
		if group == messageType then
			return true 
		end
	end
	
	return false 
end

function SkuChat_AddSingleMessageType(chatFrame, messageType)
	local group = SkuChatChatTypeGroupInverted[messageType] 
	local info = SkuChatChatTypeGroup[group] 
	if ( info ) then
		if (not tContains(chatFrame.messageTypeList, group)) then
			tinsert(chatFrame.messageTypeList, group) 
		end
		for index, value in pairs(info) do
			if (value == messageType) then
				chatFrame:RegisterEvent(value) 
			end
		end
	end
end

function SkuChat_RemoveMessageGroup(chatFrame, group)
	local info = SkuChatChatTypeGroup[group] 
	if ( info ) then
		for index, value in pairs(chatFrame.messageTypeList) do
			if ( strupper(value) == strupper(group) ) then
				chatFrame.messageTypeList[index] = nil 
			end
		end
		for index, value in pairs(info) do
			chatFrame:UnregisterEvent(value) 
		end
	end
end

function SkuChat_RemoveAllMessageGroups(chatFrame)
	for index, value in pairs(chatFrame.messageTypeList) do
		for eventIndex, eventValue in pairs(SkuChatChatTypeGroup[value]) do
			chatFrame:UnregisterEvent(eventValue) 
		end
	end

	chatFrame.messageTypeList = {} 
end

function SkuChat_ContainsChannel(chatFrame, channel)
	for i, channelName in pairs(chatFrame.channelList) do
		if channel == channelName then
			return true 
		end
	end

	return false 
end

function SkuChat_CanAddChannel()
	return C_ChatInfo.GetNumActiveChannels() < MAX_WOW_CHAT_CHANNELS 
end

function SkuChat_AddChannel(chatFrame, channel)
	local channelIndex = nil 
	local zoneChannel =  zoneChannels[string.lower(channel)]  --AddChatWindowChannel(chatFrame:GetID(), channel) 

	local i = 1 
	while ( chatFrame.channelList[i] ) do
		i = i + 1 
	end
	chatFrame.channelList[i] = channel 
	chatFrame.zoneChannelList[i] = zoneChannel 

	local localId = GetChannelName(channel) 
	channelIndex = localId 

	return channelIndex 
end

function SkuChat_RemoveChannel(chatFrame, channel)
	for index, value in pairs(chatFrame.channelList) do
		if ( strupper(channel) == strupper(value) ) then
			chatFrame.channelList[index] = nil 
			chatFrame.zoneChannelList[index] = nil 
		end
	end

	local localId = GetChannelName(channel) 
	return localId 
end

function SkuChat_RemoveAllChannels(chatFrame)
	chatFrame.channelList = {} 
	chatFrame.zoneChannelList = {} 
end

function SkuChat_AddPrivateMessageTarget(chatFrame, chatTarget)
	SkuChat_RemoveExcludePrivateMessageTarget(chatFrame, chatTarget) 
	if ( chatFrame.privateMessageList ) then
		chatFrame.privateMessageList[strlower(chatTarget)] = true 
	else
		chatFrame.privateMessageList = { [strlower(chatTarget)] = true } 
	end
end

function SkuChat_RemoveAllPrivateMessageTargets(chatFrame)
	if ( chatFrame.privateMessageList ) then
		chatFrame.privateMessageList = {} 
	end
end

function SkuChat_RemovePrivateMessageTarget(chatFrame, chatTarget)
	if ( chatFrame.privateMessageList ) then
		chatFrame.privateMessageList[strlower(chatTarget)] = nil 
	end
end

function SkuChat_ExcludePrivateMessageTarget(chatFrame, chatTarget)
	SkuChat_RemovePrivateMessageTarget(chatFrame, chatTarget) 
	if ( chatFrame.excludePrivateMessageList ) then
		chatFrame.excludePrivateMessageList[strlower(chatTarget)] = true 
	else
		chatFrame.excludePrivateMessageList = { [strlower(chatTarget)] = true } 
	end
end

function SkuChat_RemoveExcludePrivateMessageTarget(chatFrame, chatTarget)
	if ( chatFrame.excludePrivateMessageList ) then
		chatFrame.excludePrivateMessageList[strlower(chatTarget)] = nil 
	end
end

function SkuChat_ReceiveAllPrivateMessages(chatFrame)
	chatFrame.privateMessageList = nil 
	chatFrame.excludePrivateMessageList = nil 
end

function SkuChat_OnEvent(self, event, ...)
	if ( self.customEventHandler and self.customEventHandler(self, event, ...) ) then
		return 
	end

	if ( SkuChat_ConfigEventHandler(self, event, ...) ) then
		return 
	end

	if ( SkuChat_SystemEventHandler(self, event, ...) ) then
		return
	end

	if ( SkuChat_MessageEventHandler(self, event, ...) ) then
		return
	end
end

function SkuChat_ConfigEventHandler(self, event, ...)
	--find messagetype group
	local tMessagetype = event
	for i, v in pairs(SkuChatChatTypeGroup) do
		for _, value in pairs(v) do
			if event == value then
				tMessagetype = i
			end
		end
	end

	if ( event == "PLAYER_ENTERING_WORLD" ) then
		self.defaultLanguage = GetDefaultLanguage() 
		self.alternativeDefaultLanguage = GetAlternativeDefaultLanguage() 
		return true 

	elseif ( event == "NEUTRAL_FACTION_SELECT_RESULT" ) then
		self.defaultLanguage = GetDefaultLanguage() 
		self.alternativeDefaultLanguage = GetAlternativeDefaultLanguage() 
		return true 

	elseif ( event == "ALTERNATIVE_DEFAULT_LANGUAGE_CHANGED" ) then
		self.alternativeDefaultLanguage = GetAlternativeDefaultLanguage() 
		return true 
		
	elseif ( event == "CHANNEL_UI_UPDATE" ) then
		-- Do more stuff!!!
		--SkuChat_RemoveAllMessageGroups(self)
		--SkuChat_RemoveAllChannels(self)
		--SkuChat_RegisterForMessages(self, self.messageTypeList) 
		--SkuChat_RegisterForChannels(self, GetChatWindowChannels(DEFAULT_CHAT_FRAME:GetID())) 
		return true

	elseif ( event == "UPDATE_CHAT_WINDOWS" ) then
		-- Do more stuff!!!
		--SkuChat_RemoveAllChannels(self)
		--SkuChat_RegisterForMessages(self, self.messageTypeList) 
		--SkuChat_RegisterForChannels(self, GetChatWindowChannels(DEFAULT_CHAT_FRAME:GetID())) 
		
		-- GMOTD may have arrived before this frame registered for the event
		if ( not self.checkedGMOTD and self:IsEventRegistered("GUILD_MOTD") ) then
			self.checkedGMOTD = true 
			SkuChat_DisplayGMOTD(self, GetGuildRosterMOTD()) 
		end
		return true 
	end

	local arg1, arg2, arg3, arg4 = ... 
	if ( event == "UPDATE_CHAT_COLOR" ) then
		--[[
		local info = {r = nil, g = nil, b = nil, id = nil}
		if ( info ) then
			info.r = arg2 
			info.g = arg3 
			info.b = arg4 
			SkuChat_UpdateColorByID(self, info.id, info.r, info.g, info.b) 

			if ( strupper(arg1) == "WHISPER" ) then
				info = {r = nil, g = nil, b = nil, id = nil}
				if ( info ) then
					info.r = arg2 
					info.g = arg3 
					info.b = arg4 
					SkuChat_UpdateColorByID(self, info.id, info.r, info.g, info.b) 
				end
			end
		end
		]]
		return true 

	elseif ( event == "UPDATE_CHAT_COLOR_NAME_BY_CLASS" ) then
		--[[
		local info = {r = nil, g = nil, b = nil, id = nil}
		if ( info ) then
			info.colorNameByClass = arg2 
			if ( strupper(arg1) == "WHISPER" ) then
				info = {r = nil, g = nil, b = nil, id = nil}
				if ( info ) then
					info.colorNameByClass = arg2 
				end
			end
		end
		]]
		return true 
	end
end

function SkuChat_SystemEventHandler(self, event, ...)
	--find messagetype group
	local tMessagetype = event
	for i, v in pairs(SkuChatChatTypeGroup) do
		for _, value in pairs(v) do
			if event == value then
				tMessagetype = i
			end
		end
	end

	if ( event == "TIME_PLAYED_MSG" ) then
		local arg1, arg2 = ... 
		SkuChat_DisplayTimePlayed(self, arg1, arg2) 
		return true 

	elseif ( event == "PLAYER_LEVEL_UP" ) then
		SkuChat_DisplayLevelUp(self, ...)
		return true 

	elseif ( event == "CHARACTER_POINTS_CHANGED" ) then
		local arg1 = ... 
		local info = {r = nil, g = nil, b = nil, id = nil}
		return true 

	elseif ( event == "GUILD_MOTD" ) then
		SkuChat_DisplayGMOTD(self, ...) 
		return true 

	elseif ( event == "UPDATE_INSTANCE_INFO" ) then
		--[[
		if ( RaidFrame.hasRaidInfo ) then
			local info = {r = nil, g = nil, b = nil, id = nil}
			if ( RaidFrame.slashCommand and GetNumSavedInstances() == 0 and self == DEFAULT_CHAT_FRAME) then
				self:AddMessage(tMessagetype, NO_RAID_INSTANCES_SAVED, info.r, info.g, info.b, info.id) 
				RaidFrame.slashCommand = nil 
			end
		end
		]]
		return true 

	elseif ( event == "CHAT_SERVER_DISCONNECTED" ) then
		local info = {r = nil, g = nil, b = nil, id = nil}
		local isInitialMessage = ... 
		self:AddMessage(tMessagetype, CHAT_SERVER_DISCONNECTED_MESSAGE, info.r, info.g, info.b, info.id) 
		return true 

	elseif ( event == "CHAT_SERVER_RECONNECTED" ) then
		local info = {r = nil, g = nil, b = nil, id = nil}
		self:AddMessage(tMessagetype, CHAT_SERVER_RECONNECTED_MESSAGE, info.r, info.g, info.b, info.id) 
		return true 

	elseif ( event == "BN_CONNECTED" ) then
		local info = {r = nil, g = nil, b = nil, id = nil}
		self:AddMessage(tMessagetype, BN_CHAT_CONNECTED, info.r, info.g, info.b, info.id) 

	elseif ( event == "BN_DISCONNECTED" ) then
		local info = {r = nil, g = nil, b = nil, id = nil}
		self:AddMessage(tMessagetype, BN_CHAT_DISCONNECTED, info.r, info.g, info.b, info.id) 

	elseif ( event == "NOTIFY_CHAT_SUPPRESSED" ) then
		local hyperlink = string.format("|Haadcopenconfig|h[%s]", RESTRICT_CHAT_CONFIG_HYPERLINK) 
		local message = string.format(RESTRICT_CHAT_SkuChat_FORMAT, RESTRICT_CHAT_MESSAGE_SUPPRESSED, LIGHTBLUE_FONT_COLOR:WrapTextInColorCode(hyperlink)) 
		local info = {r = nil, g = nil, b = nil, id = nil}
		self:AddMessage(tMessagetype, message, info.r, info.g, info.b, info.id) 
		return true 

	elseif ( event == "PLAYER_REPORT_SUBMITTED" ) then
		--[[
		local guid = ... 
		FCF_RemoveAllMessagesFromChanSender(self, guid) 
		]]
		return true 
	end
end

function GetColoredName(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
	local chatType = strsub(event, 10) 
	if ( strsub(chatType, 1, 7) == "WHISPER" ) then
		chatType = "WHISPER" 
	end

	if ( strsub(chatType, 1, 7) == "CHANNEL" ) then
		chatType = "CHANNEL"..arg8 
	end
	--local info = {r = nil, g = nil, b = nil, id = nil}

	--ambiguate guild chat names
	if (chatType == "GUILD") then
		arg2 = Ambiguate(arg2, "guild")
	else
		arg2 = Ambiguate(arg2, "none")
	end

	--[[
	if ( arg12 and info and Chat_ShouldColorChatByClass(info) ) then
		local localizedClass, englishClass, localizedRace, englishRace, sex = GetPlayerInfoByGUID(arg12)

		if ( englishClass ) then
			local classColorTable = RAID_CLASS_COLORS[englishClass] 
			if ( not classColorTable ) then
				return arg2 
			end
			return string.format("\124cff%.2x%.2x%.2x", classColorTable.r*255, classColorTable.g*255, classColorTable.b*255)..arg2.."\124r"
		end
	end
	]]

	return arg2 
end

function RemoveExtraSpaces(str)
	return string.gsub(str, "     +", "    ") 	--Replace all instances of 5+ spaces with only 4 spaces.
end

function RemoveNewlines(str)
	return string.gsub(str, "\n", "") 
end

function SkuChat_DisplayGMOTD(frame, gmotd)
	if ( gmotd and (gmotd ~= "") ) then
		--local info = {r = nil, g = nil, b = nil, id = nil}
		local string = format(GUILD_MOTD_TEMPLATE, gmotd) 
		frame:AddMessage(string, 1, 1, 1, 1) 
	end
end

function SkuChat_GetMobileEmbeddedTexture(r, g, b)
	r, g, b = floor(r * 255), floor(g * 255), floor(b * 255) 
	return " "--format("|TInterface\\ChatFrame\\UI-ChatIcon-ArmoryChat:14:14:0:0:16:16:0:16:0:16:%d:%d:%d|t", r, g, b) 
end

function SkuChat_CanChatGroupPerformExpressionExpansion(chatGroup)
	if chatGroup == "RAID" then
		return true 
	end

	if chatGroup == "INSTANCE_CHAT" then
		return IsInRaid(LE_PARTY_CATEGORY_INSTANCE) 
	end

	return false 
end

do
	function SkuChat_ReplaceIconAndGroupExpressions(message, noIconReplacement, noGroupReplacement)
		if message then
			message = string.gsub(message, "{", " ")
			message = string.gsub(message, "}", " ")
		end

		return message 
	end
end

function SkuChat_SkuMessageEventHandler(self, event, tMessagetype, message)
	for x = 1, #SkuOptions.db.profile["SkuChat"].tabs do
		if tMessagetype == "COMBATLOG" and SkuOptions.db.profile["SkuChat"].tabs[x].messageTypes["SKU"] and SkuOptions.db.profile["SkuChat"].tabs[x].messageTypes["SKU"][1] == true then
			_G[SkuOptions.db.profile["SkuChat"].tabs[x].frameName]:AddMessage(tMessagetype, message) 
		end
		if tMessagetype == "AUDIOLOG" and  SkuOptions.db.profile["SkuChat"].tabs[x].messageTypes["SKU"] and SkuOptions.db.profile["SkuChat"].tabs[x].messageTypes["SKU"][2] == true then
			_G[SkuOptions.db.profile["SkuChat"].tabs[x].frameName]:AddMessage(tMessagetype, message) 
		end
	end
	
end

function SkuChat_MessageEventHandler(self, event, ...)
	--find messagetype group
	local tMessagetype = event
	for i, v in pairs(SkuChatChatTypeGroup) do
		for _, value in pairs(v) do
			if event == value then
				tMessagetype = i
			end
		end
	end


	if ( strsub(event, 1, 8) == "CHAT_MSG" ) then
		local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17 = ... 

		SkuNav:NavigationModeWoCoordinatesCheckTaskTrigger(arg1)

		if (arg16) then
			-- hiding sender in letterbox: do NOT even show in chat window (only shows in cinematic frame)
			return true 
		end

		local type = strsub(event, 10) 
		local info = {r = nil, g = nil, b = nil, id = nil}

		if SkuOptions.db.profile["SkuChat"].chatSettings.filter and SkuOptions.db.profile["SkuChat"].chatSettings.filter.terms then
			if arg2 == "Rhonin" then
				SkuOptions:StopSounds(15, true)
				return true
			end
			if SkuOptions.db.profile["SkuChat"].chatSettings.filter.terms[string.lower(arg1)] then
				return true
			end
		end

		local filter = false 
		if ( chatFilters[event] ) then
			local newarg1, newarg2, newarg3, newarg4, newarg5, newarg6, newarg7, newarg8, newarg9, newarg10, newarg11, newarg12, newarg13, newarg14 
			for _, filterFunc in next, chatFilters[event] do
				filter, newarg1, newarg2, newarg3, newarg4, newarg5, newarg6, newarg7, newarg8, newarg9, newarg10, newarg11, newarg12, newarg13, newarg14 = filterFunc(self, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14) 
				if ( filter ) then
					return true 
				elseif ( newarg1 ) then
					arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14 = newarg1, newarg2, newarg3, newarg4, newarg5, newarg6, newarg7, newarg8, newarg9, newarg10, newarg11, newarg12, newarg13, newarg14 
				end
			end
		end

		local coloredName = GetColoredName(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14) 
		local channelLength = strlen(arg4) 
		local infoType = type 

		if type == "VOICE_TEXT" and not GetCVarBool("speechToText") then
			return 

		elseif ( (type == "COMMUNITIES_CHANNEL") or ((strsub(type, 1, 7) == "CHANNEL") and (type ~= "CHANNEL_LIST") and ((arg1 ~= "INVITE") or (type ~= "CHANNEL_NOTICE_USER"))) ) then
			--print(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17)			
			if ( arg1 == "WRONG_PASSWORD" ) then
				local staticPopup = _G[StaticPopup_Visible("CHAT_CHANNEL_PASSWORD") or ""] 
				if ( staticPopup and strupper(staticPopup.data) == strupper(arg9) ) then
					-- Don't display invalid password messages if we're going to prompt for a password (bug 102312)
					return 
				end
			end

			local found = 0 
			for index, value in pairs(self.channelList) do
				if ( channelLength > strlen(value) ) then
					-- arg9 is the channel name without the number in front...
					if ( ((arg7 > 0) and (self.zoneChannelList[index] == arg7)) or (strupper(value) == strupper(arg9)) ) then
						found = 1 
						infoType = "CHANNEL"..arg8 
						info = {r = nil, g = nil, b = nil, id = nil}
						if ( (type == "CHANNEL_NOTICE") and (arg1 == "YOU_LEFT") ) then
							self.channelList[index] = nil 
							self.zoneChannelList[index] = nil 
						end
						break 
					end
				end
			end
			if ( (found == 0) or not info ) then
				return true 
			end
		end

		local chatGroup = SkuChatChat_GetChatCategory(type) 
		local chatTarget 
		if ( chatGroup == "CHANNEL" ) then
			chatTarget = tostring(arg8) 
		elseif ( chatGroup == "WHISPER" or chatGroup == "BN_WHISPER" ) then
			if(not(strsub(arg2, 1, 2) == "|K")) then
				chatTarget = strupper(arg2) 
			else
				chatTarget = arg2 
			end
		end

		--[[
		if ( FCFManager_ShouldSuppressMessage(self, chatGroup, chatTarget) ) then
			return true 
		end
		]]

		if ( chatGroup == "WHISPER" or chatGroup == "BN_WHISPER" ) then
			if ( self.privateMessageList and not self.privateMessageList[strlower(arg2)] ) then
				return true 
			elseif ( self.excludePrivateMessageList and self.excludePrivateMessageList[strlower(arg2)]
				and ( 
					(chatGroup == "WHISPER" and GetCVar("whisperMode") ~= "popout_and_inline") or 
					(chatGroup == "BN_WHISPER" and GetCVar("whisperMode") ~= "popout_and_inline") 
				) ) then
				return true 
			end
		end

		if (self.privateMessageList) then
			-- Dedicated BN whisper windows need online/offline messages for only that player
			if ( (chatGroup == "BN_INLINE_TOAST_ALERT" or chatGroup == "BN_WHISPER_PLAYER_OFFLINE") and not self.privateMessageList[strlower(arg2)] ) then
				return true 
			end

			-- HACK to put certain system messages into dedicated whisper windows
			if ( chatGroup == "SYSTEM") then
				local matchFound = false 
				local message = strlower(arg1) 
				for playerName, _ in pairs(self.privateMessageList) do
					local playerNotFoundMsg = strlower(format(ERR_CHAT_PLAYER_NOT_FOUND_S, playerName)) 
					local charOnlineMsg = strlower(format(ERR_FRIEND_ONLINE_SS, playerName, playerName)) 
					local charOfflineMsg = strlower(format(ERR_FRIEND_OFFLINE_S, playerName)) 
					if ( message == playerNotFoundMsg or message == charOnlineMsg or message == charOfflineMsg) then
						matchFound = true 
						break 
					end
				end

				if (not matchFound) then
					return true 
				end
			end
		end

		if ( type == "SYSTEM" or type == "SKILL" or type == "CURRENCY" or type == "MONEY" or
		     type == "OPENING" or type == "TRADESKILLS" or type == "PET_INFO" or type == "TARGETICONS" or type == "BN_WHISPER_PLAYER_OFFLINE") then
			self:AddMessage(tMessagetype, arg1, info.r, info.g, info.b, info.id) 

		elseif (type == "LOOT") then
			-- Append [Share] hyperlink if this is a valid social item and you are the looter.
			-- arg5 contains the name of the player who looted
			if C_Social and (C_Social.IsSocialEnabled() and UnitName("player") == arg5) then
				local itemID, strippedItemLink = GetItemInfoFromHyperlink(arg1) 
				if (itemID and C_Social.GetLastItem() == itemID) then
					arg1 = arg1 .. " " .. Social_GetShareItemLink(strippedItemLink, true) 
				end
			end
			self:AddMessage(tMessagetype, arg1, info.r, info.g, info.b, info.id) 

		elseif ( strsub(type,1,7) == "COMBAT_" ) then
			self:AddMessage(tMessagetype, arg1, info.r, info.g, info.b, info.id) 

		elseif ( strsub(type,1,6) == "SPELL_" ) then
			self:AddMessage(tMessagetype, arg1, info.r, info.g, info.b, info.id) 

		elseif ( strsub(type,1,10) == "BG_SYSTEM_" ) then
			self:AddMessage(tMessagetype, arg1, info.r, info.g, info.b, info.id) 

		elseif ( strsub(type,1,11) == "ACHIEVEMENT" ) then
			-- Append [Share] hyperlink
			if C_Social and (arg12 == UnitGUID("player") and C_Social.IsSocialEnabled()) then
				local achieveID = GetAchievementInfoFromHyperlink(arg1) 
				if (achieveID) then
					arg1 = arg1 .. " " .. Social_GetShareAchievementLink(achieveID, true) 
				end
			end
			self:AddMessage(tMessagetype, arg1:format(SkuChat:GetPlayerLink(arg2, ("[%s]"):format(coloredName))), info.r, info.g, info.b, info.id) 

		elseif ( strsub(type,1,18) == "GUILD_ACHIEVEMENT" ) then
			local message = arg1:format(SkuChat:GetPlayerLink(arg2, ("[%s]"):format(coloredName))) 
			if C_Social and (C_Social.IsSocialEnabled()) then
				local achieveID = GetAchievementInfoFromHyperlink(arg1) 
				if (achieveID) then
					local isGuildAchievement = select(12, GetAchievementInfo(achieveID)) 
					if (isGuildAchievement) then
						message = message .. " " .. Social_GetShareAchievementLink(achieveID, true) 
					end
				end
			end
			self:AddMessage(tMessagetype, message, info.r, info.g, info.b, info.id) 

		elseif ( type == "IGNORED" ) then
			self:AddMessage(tMessagetype, format(CHAT_IGNORED, arg2), info.r, info.g, info.b, info.id) 

		elseif ( type == "FILTERED" ) then
			self:AddMessage(tMessagetype, format(CHAT_FILTERED, arg2), info.r, info.g, info.b, info.id) 

		elseif ( type == "RESTRICTED" ) then
			self:AddMessage(tMessagetype, CHAT_RESTRICTED_TRIAL, info.r, info.g, info.b, info.id) 

		elseif ( type == "CHANNEL_LIST") then
			if(channelLength > 0) then
				self:AddMessage(tMessagetype, format(_G["CHAT_"..type.."_GET"]..arg1, tonumber(arg8), arg4), info.r, info.g, info.b, info.id) 
			else
				self:AddMessage(tMessagetype, arg1, info.r, info.g, info.b, info.id) 
			end

		elseif (type == "CHANNEL_NOTICE_USER") then
			local globalstring = _G["CHAT_"..arg1.."_NOTICE_BN"] 
			if ( not globalstring ) then
				globalstring = _G["CHAT_"..arg1.."_NOTICE"] 
			end
			if not globalstring then
				GMError(("Missing global string for %q"):format("CHAT_"..arg1.."_NOTICE_BN")) 
				return 
			end
			if(arg5 ~= "") then
				-- TWO users in this notice (E.G. x kicked y)
				self:AddMessage(tMessagetype, format(globalstring, arg8, arg4, arg2, arg5), info.r, info.g, info.b, info.id) 
			elseif ( arg1 == "INVITE" ) then
				local playerLink = SkuChat:GetPlayerLink(arg2, ("[%s]"):format(arg2), arg11) 
				local accessID = ChatHistory_GetAccessID(chatGroup, chatTarget) 
				local typeID = ChatHistory_GetAccessID(infoType, chatTarget, arg12) 
				self:AddMessage(tMessagetype, format(globalstring, arg4, playerLink), info.r, info.g, info.b, info.id, accessID, typeID) 
			else
				self:AddMessage(tMessagetype, format(globalstring, arg8, arg4, arg2), info.r, info.g, info.b, info.id) 
			end
			if ( arg1 == "INVITE" and GetCVarBool("blockChannelInvites") ) then
				self:AddMessage(tMessagetype, CHAT_MSG_BLOCK_CHAT_CHANNEL_INVITE, info.r, info.g, info.b, info.id) 
			end

		elseif (type == "CHANNEL_NOTICE") then
			local globalstring 
			if ( arg1 == "TRIAL_RESTRICTED" ) then
				globalstring = CHAT_TRIAL_RESTRICTED_NOTICE_TRIAL 
			else
				globalstring = _G["CHAT_"..arg1.."_NOTICE_BN"] 
				if ( not globalstring ) then
					globalstring = _G["CHAT_"..arg1.."_NOTICE"] 
					if not globalstring then
						GMError(("Missing global string for %q"):format("CHAT_"..arg1.."_NOTICE")) 
						return 
					end
				end
			end
			local accessID = ChatHistory_GetAccessID(SkuChatChat_GetChatCategory(type), arg8) 
			local typeID = ChatHistory_GetAccessID(infoType, arg8, arg12) 
			self:AddMessage(tMessagetype, format(globalstring, arg8, SkuChat_ResolvePrefixedChannelName(arg4)), info.r, info.g, info.b, info.id, accessID, typeID) 

		elseif ( type == "BN_INLINE_TOAST_ALERT" ) then
			local globalstring = _G["BN_INLINE_TOAST_"..arg1] 
			if not globalstring then
				GMError(("Missing global string for %q"):format("BN_INLINE_TOAST_"..arg1)) 
				return 
			end

			local message 
			if ( arg1 == "FRIEND_REQUEST" ) then
				message = globalstring 

			elseif ( arg1 == "FRIEND_PENDING" ) then
				message = format(BN_INLINE_TOAST_FRIEND_PENDING, BNGetNumFriendInvites()) 

			elseif ( arg1 == "FRIEND_REMOVED" or arg1 == "BATTLETAG_FRIEND_REMOVED" ) then
				message = format(globalstring, arg2) 

			elseif ( arg1 == "FRIEND_ONLINE" or arg1 == "FRIEND_OFFLINE") then
				local _, accountName, battleTag, _, characterName, _, client = BNGetFriendInfoByID(arg13) 
				if (client and client ~= "") then
					local _, _, battleTag = BNGetFriendInfoByID(arg13) 
					characterName = BNet_GetValidatedCharacterName(characterName, battleTag, client) or "" 
					--local characterNameText = BNet_GetClientEmbeddedTexture(client, 14)..characterName 
					local characterNameText = characterName 
					local linkDisplayText = ("[%s] (%s)"):format(arg2, characterNameText) 
					local playerLink = SkuChat:GetBNPlayerLink(arg2, linkDisplayText, arg13, arg11, SkuChatChat_GetChatCategory(type), 0) 
					message = format(globalstring, playerLink) 
				else
					local linkDisplayText = ("[%s]"):format(arg2) 
					local playerLink = SkuChat:GetBNPlayerLink(arg2, linkDisplayText, arg13, arg11, SkuChatChat_GetChatCategory(type), 0) 
					message = format(globalstring, playerLink) 
				end

			else
				local linkDisplayText = ("[%s]"):format(arg2) 
				local playerLink = SkuChat:GetBNPlayerLink(arg2, linkDisplayText, arg13, arg11, SkuChatChat_GetChatCategory(type), 0) 
				message = format(globalstring, playerLink) 
			end
			self:AddMessage(tMessagetype, message, info.r, info.g, info.b, info.id) 

		elseif ( type == "BN_INLINE_TOAST_BROADCAST" ) then
			if ( arg1 ~= "" ) then
				arg1 = RemoveNewlines(RemoveExtraSpaces(arg1)) 
				local linkDisplayText = ("[%s]"):format(arg2) 
				local playerLink = SkuChat:GetBNPlayerLink(arg2, linkDisplayText, arg13, arg11, SkuChatChat_GetChatCategory(type), 0) 
				self:AddMessage(tMessagetype, format(BN_INLINE_TOAST_BROADCAST, playerLink, arg1), info.r, info.g, info.b, info.id) 
			end

		elseif ( type == "BN_INLINE_TOAST_BROADCAST_INFORM" ) then
			if ( arg1 ~= "" ) then
				arg1 = RemoveExtraSpaces(arg1) 
				self:AddMessage(tMessagetype, BN_INLINE_TOAST_BROADCAST_INFORM, info.r, info.g, info.b, info.id) 
			end

		else
			local body 

			-- Add AFK/DND flags
			local pflag 
			if(arg6 ~= "") then
				if ( arg6 == "GM" ) then
					--If it was a whisper, dispatch it to the GMChat addon.
					if ( type == "WHISPER" ) then
						return 
					end
					--Add Blizzard Icon, this was sent by a GM
					pflag = "Blizzard Gamemaster (approved by Sku): " 
				elseif ( arg6 == "DEV" ) then
					--Add Blizzard Icon, this was sent by a Dev
					pflag = "Blizzard Gamemaster (approved by Sku): " 
				else
					pflag = _G["CHAT_FLAG_"..arg6] 
				end
			else
				pflag = "" 
			end

			if ( type == "WHISPER_INFORM" and GMSkuChat_IsGM and GMSkuChat_IsGM(arg2) ) then
				return 
			end

			local showLink = 1 
			if ( strsub(type, 1, 7) == "MONSTER" or strsub(type, 1, 9) == "RAID_BOSS") then
				showLink = nil 
			else
				arg1 = gsub(arg1, "%%", "%%%%") 
			end

			-- Search for icon links and replace them with texture links.
			arg1 = SkuChat_ReplaceIconAndGroupExpressions(arg1, arg17, not SkuChat_CanChatGroupPerformExpressionExpansion(chatGroup))  -- If arg17 is true, don't convert to raid icons

			--Remove groups of many spaces
			arg1 = RemoveExtraSpaces(arg1) 

			local playerLink 
			local playerLinkDisplayText = coloredName 
			local relevantDefaultLanguage = self.defaultLanguage 

			if ( (type == "SAY") or (type == "YELL") ) then
				relevantDefaultLanguage = self.alternativeDefaultLanguage 
			end

			local usingDifferentLanguage = (arg3 ~= "") and (arg3 ~= relevantDefaultLanguage) 
			local usingEmote = (type == "EMOTE") or (type == "TEXT_EMOTE") 
			if ( usingDifferentLanguage or not usingEmote ) then
				playerLinkDisplayText = ("[%s]"):format(coloredName) 
			end

			local isCommunityType = type == "COMMUNITIES_CHANNEL" 
			local playerName, lineID, bnetIDAccount = arg2, arg11, arg13 
			if ( isCommunityType ) then
				local isBattleNetCommunity = bnetIDAccount ~= nil and bnetIDAccount ~= 0 
				local messageInfo, clubId, streamId, clubType = C_Club.GetInfoFromLastCommunityChatLine() 
				if (messageInfo ~= nil) then
					if ( isBattleNetCommunity ) then
						playerLink = SkuChat:GetBNPlayerCommunityLink(playerName, playerLinkDisplayText, bnetIDAccount, clubId, streamId, messageInfo.messageId.epoch, messageInfo.messageId.position) 
					else
						playerLink = SkuChat:GetPlayerCommunityLink(playerName, playerLinkDisplayText, clubId, streamId, messageInfo.messageId.epoch, messageInfo.messageId.position) 
					end
				else
					playerLink = playerLinkDisplayText 
				end
			else
				if ( type == "BN_WHISPER" or type == "BN_WHISPER_INFORM" ) then
					playerLink = SkuChat:GetBNPlayerLink(playerName, playerLinkDisplayText, bnetIDAccount, lineID, chatGroup, chatTarget) 
				else
					playerLink = SkuChat:GetPlayerLink(playerName, playerLinkDisplayText, lineID, chatGroup, chatTarget) 
				end
			end

			local message = arg1 
			if ( arg14 ) then	--isMobile
				message = SkuChat_GetMobileEmbeddedTexture(info.r, info.g, info.b)..message 
			end

			if ( usingDifferentLanguage ) then
				local languageHeader = "["..arg3.."] " 
				if ( showLink and (arg2 ~= "") ) then
					body = format(_G["CHAT_"..type.."_GET"]..languageHeader..message, pflag..playerLink) 
				else
					body = format(_G["CHAT_"..type.."_GET"]..languageHeader..message, pflag..arg2) 
				end
			else
				if ( not showLink or arg2 == "" ) then
					if ( type == "TEXT_EMOTE" ) then
						body = message 
					else
						body = format(_G["CHAT_"..type.."_GET"]..message, pflag..arg2, arg2) 
					end
				else
					if ( type == "EMOTE" ) then
						body = format(_G["CHAT_"..type.."_GET"]..message, pflag..playerLink) 
					elseif ( type == "TEXT_EMOTE") then
						body = string.gsub(message, arg2, pflag..playerLink, 1) 
					elseif (type == "GUILD_ITEM_LOOTED") then
						body = string.gsub(message, "$s", SkuChat:GetPlayerLink(arg2, playerLinkDisplayText)) 
					else
						body = format(_G["CHAT_"..type.."_GET"]..message, pflag..playerLink) 
					end
				end
			end

			-- Add Channel
			if (channelLength > 0) then
				body = "["..SkuChat_ResolvePrefixedChannelName(arg4).."] "..body 
				local tChannelList = {GetChannelList()}
				for q = 1, C_ChatInfo.GetNumActiveChannels() * 3, 3 do 
					if arg8 == tChannelList[q] then
						tMessagetype = tChannelList[q + 1]
					end
				end
			end

			--Add Timestamps
			if ( CHAT_TIMESTAMP_FORMAT ) then
				body = BetterDate(CHAT_TIMESTAMP_FORMAT, time())..body 
			end

			local accessID = ChatHistory_GetAccessID(chatGroup, chatTarget) 
			local typeID = ChatHistory_GetAccessID(infoType, chatTarget, arg12 or arg13) 
			self:AddMessage(tMessagetype, body, info.r, info.g, info.b, info.id, accessID, typeID, arg2) 
		end

		if ( type == "WHISPER" or type == "BN_WHISPER" ) then
			--BN_WHISPER FIXME
			--[[
			ChatEdit_SetLastTellTarget(arg2, type) 

			if ( self.tellTimer and (GetTime() > self.tellTimer) ) then
				PlaySound(SOUNDKIT.TELL_MESSAGE) 
			end
			self.tellTimer = GetTime() + CHAT_TELL_ALERT_TIME 
			--FCF_FlashTab(self) 
			FlashClientIcon() 
			]]
		end

		--[[
		if ( not self:IsShown() ) then
			if ( (self == DEFAULT_CHAT_FRAME and info.flashTabOnGeneral) or (self ~= DEFAULT_CHAT_FRAME and info.flashTab) ) then
				if ( not CHAT_OPTIONS.HIDE_FRAME_ALERTS or type == "WHISPER" or type == "BN_WHISPER" ) then	--BN_WHISPER FIXME
					if (not FCFManager_ShouldSuppressMessageFlash(self, chatGroup, chatTarget) ) then
						--FCF_StartAlertFlash(self) 
					end
				end
			end
		end
		]]
		return true 

	elseif ( event == "VOICE_CHAT_CHANNEL_TRANSCRIBING_CHANGED" ) then
		--[[
		local _, isNowTranscribing = ...
		if ( not self.isTranscribing and isNowTranscribing ) then
			SkuChat_DisplaySystemMessage(self, SPEECH_TO_TEXT_STARTED) 
		end
		self.isTranscribing = isNowTranscribing 
		]]
	end

end

--some blizzard helpers
function SkuChat_TimeBreakDown(time)
	local days = floor(time / (60 * 60 * 24)) 
	local hours = floor((time - (days * (60 * 60 * 24))) / (60 * 60)) 
	local minutes = floor((time - (days * (60 * 60 * 24)) - (hours * (60 * 60))) / 60) 
	local seconds = mod(time, 60) 
	return days, hours, minutes, seconds 
end

function SkuChat_DisplayTimePlayed(self, totalTime, levelTime)
	local info = {r = nil, g = nil, b = nil, id = nil}
	local d 
	local h 
	local m 
	local s 
	d, h, m, s = SkuChat_TimeBreakDown(totalTime) 
	local string = format(TIME_PLAYED_TOTAL, format(TIME_DAYHOURMINUTESECOND, d, h, m, s)) 
	self:AddMessage(tMessagetype, string, info.r, info.g, info.b, info.id) 

	d, h, m, s = SkuChat_TimeBreakDown(levelTime) 
	local string = format(TIME_PLAYED_LEVEL, format(TIME_DAYHOURMINUTESECOND, d, h, m, s)) 
	self:AddMessage(tMessagetype, string, info.r, info.g, info.b, info.id) 
end

function SkuChat_DisplayLevelUp(self, level, ...)
	-- Level up
	local info = {r = nil, g = nil, b = nil, id = nil}
	-- Blank arg is numNewPvpTalentSlots (always 0 in Classic).
	local arg2, arg3, arg4, _, arg5, arg6, arg7, arg8, arg9 = ... 
	local string = LEVEL_UP:format(level) 
	self:AddMessage(tMessagetype, string, info.r, info.g, info.b, info.id) 

	if ( arg3 > 0 ) then
		string = LEVEL_UP_HEALTH_MANA:format(arg2, arg3) 
	else
		string = LEVEL_UP_HEALTH:format(arg2) 
	end
	self:AddMessage(tMessagetype, string, info.r, info.g, info.b, info.id) 

	if ( arg4 > 0 ) then
		string = format(GetText("LEVEL_UP_CHAR_POINTS", nil, arg4), arg4) 
		self:AddMessage(tMessagetype, string, info.r, info.g, info.b, info.id) 
	end

	if ( arg5 > 0 ) then
		string = format(LEVEL_UP_STAT, SPELL_STAT1_NAME, arg5) 
		self:AddMessage(tMessagetype, string, info.r, info.g, info.b, info.id) 
	end

	if ( arg6 > 0 ) then
		string = format(LEVEL_UP_STAT, SPELL_STAT2_NAME, arg6) 
		self:AddMessage(tMessagetype, string, info.r, info.g, info.b, info.id) 
	end

	if ( arg7 > 0 ) then
		string = format(LEVEL_UP_STAT, SPELL_STAT3_NAME, arg7) 
		self:AddMessage(tMessagetype, string, info.r, info.g, info.b, info.id) 
	end

	if ( arg8 > 0 ) then
		string = format(LEVEL_UP_STAT, SPELL_STAT4_NAME, arg8) 
		self:AddMessage(tMessagetype, string, info.r, info.g, info.b, info.id) 
	end

	if ( arg9 > 0 ) then
		string = format(LEVEL_UP_STAT, SPELL_STAT5_NAME, arg9) 
		self:AddMessage(tMessagetype, string, info.r, info.g, info.b, info.id) 
	end
end

-- end of blizzards chatframe code
---------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------
-- start of sku code
--------------------------------------------------------------------------------------------------------------------------------------
local escapes = {
	["|c%x%x%x%x%x%x%x%x"] = "", -- color start
	["|r"] = "", -- color end
	["|H.-|h(.-)|h"] = "%1", -- links
	["|T.-|t"] = "", -- textures
	["|A.-|a"] = "", -- textures
	["{.-}"] = "", -- raid target icons
}
local escapesChat = {
	["|c%x%x%x%x%x%x%x%x"] = "", -- color start
	["|r"] = "", -- color end
	["|H.-|h(.-)|h"] = "%1", -- links
	["|T.-|t"] = "", -- textures
	--["{.-}"] = "", -- raid target icons
}
function SkuChat:Unescape(str, aChatSpecific)
	if not str then return nil end

	local tEscapeStrings = escapes
	if aChatSpecific then
		tEscapeStrings = escapesChat
	end
	
	for k, v in pairs(tEscapeStrings) do
		str = string.gsub(str, k, v)
	end
	return str
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:ShortenChannelName(aChannelName)
	if SkuOptions.db.profile[MODULE_NAME].chatSettings.shortenChannelNames ~= true then
		return aChannelName
	end

	local tDefaultNames = {
		["WorldDefense".."\]"] = "WD".."]",
		["GuildRecruitment".."\]"] = "GR".."]",
		["LookingForGroup".."\]"] = "LFG".."]",
		["Guild".."\]"] = "G".."]",
		["Party".."\]"] = "P".."]",
		["Raid".."\]"] = "R".."]",
		["\. ".."General".." \- .*"] = ". ".."GEN",
		["\. ".."Trade".." \- .*"] = ". ".."TRADE",
		["\. ".."LocalDefense".." \- .*"] = ". ".."LD",
	}	
	
	for i, v in pairs(tDefaultNames) do
		aChannelName = aChannelName:gsub(i, v)
	end

	return aChannelName
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:GetBNPlayerCommunityLink(aPlayerName)
	return aPlayerName
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:GetPlayerCommunityLink(aPlayerName)
	return aPlayerName
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:GetBNPlayerLink(aPlayerName)
	return aPlayerName
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:GetPlayerLink(aPlayerName)
	local tPlayer, tServer = SkuChat:GetOnlyPlayerName(aPlayerName)
	if tServer and tServer == GetNormalizedRealmName() then
		return tPlayer
	end

	return aPlayerName
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:GetFullPlayerName(aName)
	if not string.find(aName, "-") then
		return aName.."-"..GetNormalizedRealmName() 
	else
		return aName
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:GetOnlyPlayerName(aName)
	if not string.find(aName, "-") then
		return aName
	else
		return aName:match("(.+)-(.*)") 
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:OnDisable()
	
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:SetEditboxToSkuChat(aMsg)
	SkuChatEditboxHookFlag = true
	local channelNum, channelName = GetChannelName("SkuChat")
	ChatFrame1EditBox:SetAttribute("channelTarget", channelNum)
	ChatFrame1EditBox:SetAttribute("chatType", "CHANNEL")
	ChatFrame1EditBox:SetText(aMsg)
	ChatEdit_UpdateHeader(ChatFrame1EditBox)
	SkuChatEditboxHookFlag = false
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:GetChannelAccessIdFromChannelName(aName)
	local tChannelList = {GetChannelList()}
	for q = 1, C_ChatInfo.GetNumActiveChannels() * 3, 3 do 
		if tChannelList[q + 1] == aName then
			return tChannelList[q]
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:COMBAT_LOG_EVENT()
	local text, r, g, b, a = CombatLog_OnEvent(Blizzard_CombatLog_CurrentSettings, CombatLogGetCurrentEventInfo() );
	if ( text ) then
		SkuDispatcher:TriggerSkuEvent("SKU_COMBATLOG", "COMBATLOG", text)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:OnInitialize()
	SkuChat:RegisterEvent("PLAYER_ENTERING_WORLD")
	SkuChat:RegisterEvent("PLAYER_LOGIN")
	SkuChat:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE")
	SkuChat:RegisterEvent("CHAT_MSG_WHISPER")
	SkuChat:RegisterEvent("CHAT_MSG_WHISPER_INFORM")
	SkuChat:RegisterEvent("COMBAT_LOG_EVENT")

	local function CloseChatMenuHelper()
		_G["OnSkuChatToggle"].menuOpen = false
		SkuOptions.Menu = {}
	end

	-- OnSkuChatToggle to actually handle the chat key binds
	tSkuCurrentLineDatalinktTextFirstLine = ""
	tSkuCurrentLineDatalinktTextFull = ""
	tSkuCurrentLineDatalinktItemId = ""
	local a = _G["OnSkuChatToggle"] or CreateFrame("Button", "OnSkuChatToggle", UIParent, "SecureActionButtonTemplate")
	a.timeCounter = 0
	local ttime = 0
	a:SetScript("OnUpdate", function(self, atime)
		self.timeCounter = self.timeCounter + atime
		if self.timeCounter > 5 then
			if SkuOptions.db.profile["SkuChat"].tabs and SkuOptions.db.profile[MODULE_NAME].chatSettings.deleteWhisperTabsAfter > 1 then
				for x = 1, #SkuOptions.db.profile["SkuChat"].tabs do
					if SkuOptions.db.profile["SkuChat"].tabs[x] then
						if SkuOptions.db.profile["SkuChat"].tabs[x].privateMessages and #SkuOptions.db.profile["SkuChat"].tabs[x].privateMessages > 0 then
							if (SkuOptions.db.profile["SkuChat"].tabs[x].lastActivityAt or 0) + ((SkuChat.DeleteTabTimes[SkuOptions.db.profile[MODULE_NAME].chatSettings.deleteWhisperTabsAfter] * 60)) < time() then
								SkuChat:DeleteTab(x)
							end
						end
					end
				end
			end
			self.timeCounter = 0
		end

		ttime = ttime + atime
		if ttime > 0.1 then
			if SkuOptions.TTS:IsVisible() == true then
				if IsShiftKeyDown() == false and SkuOptions.TTS:IsAutoRead() ~= true then
					if SkuOptions.currentMenuPosition then
						if SkuOptions.currentMenuPosition.textFullInitial then
							SkuOptions.currentMenuPosition.textFull = SkuOptions.currentMenuPosition.textFullInitial
						end
						SkuOptions.currentMenuPosition.textFullInitial = nil
						SkuOptions.currentMenuPosition.links = {}
						SkuOptions.currentMenuPosition.linksSelected = 0
						SkuOptions.currentMenuPosition.currentLinkName = nil
						SkuOptions.currentMenuPosition.linksHistory = nil
					end
		
					SkuOptions.TTS:Output("", -1)
					SkuOptions.TTS:Hide()
				end
			end

			ttime = 0
		end
	end)

	a.menuOpen = false

	a.CloseChat = function(self)
		SkuChat.ChatOpen = false

		--close the line menu if open
		CloseChatMenuHelper()

		SkuOptions.Voice:StopOutputEmptyQueue(true, nil)
		SkuOptions.Voice:OutputString("sound-off2", true, true, 0.2)

		--unbind chat keys
		if SkuCore.inCombat ~= true then
			if _G["OnSkuChatToggleSecureHandler"] then
				SecureHandlerExecute(_G["OnSkuChatToggleSecureHandler"], [=[
					if self:GetAttribute("ChatOpen") == true then
						self:ClearBinding(self:GetAttribute("SKU_KEY_CHAT_LINEPREV"))
						self:ClearBinding(self:GetAttribute("SKU_KEY_CHAT_LINENEXT"))
						self:ClearBinding(self:GetAttribute("SKU_KEY_CHAT_TABPREV"))
						self:ClearBinding(self:GetAttribute("SKU_KEY_CHAT_TABNEXT"))
						self:ClearBinding(self:GetAttribute("SKU_KEY_CHAT_LINEMENU"))
						self:ClearBinding(self:GetAttribute("SHIFT-DOWN"))
						self:ClearBinding(self:GetAttribute("SHIFT-UP"))
						self:ClearBinding(self:GetAttribute("CTRL-SHIFT-DOWN"))
						self:ClearBinding(self:GetAttribute("CTRL-SHIFT-UP"))
						self:ClearBinding(self:GetAttribute("ESCAPE"))
						self:SetAttribute("ChatOpen", false)
					end
				]=])
			end
		end
	end

	a.OpenChat = function(self)
		SkuOptions:CloseMenu()
		SkuChat.ChatOpen = true
		SkuOptions.Voice:StopOutputEmptyQueue()
		SkuOptions.Voice:OutputString("sound-on3_1", true, true, 0.2, true)
		if not SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab] then
			SkuChat.currentTab = 1
		end
		SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].historyCurrentLine = 1
		SkuChat:ReadLine(SkuChat.currentTab, SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].historyCurrentLine, true)
	end

	a:SetScript("OnClick", function(self, aKey)
		--handle chat navigation
		local tTextFirstLine, tTextFull = nil, "", ""

		if aKey ~= "SHIFT-UP" and aKey ~= "SHIFT-DOWN" and aKey ~= "CTRL-SHIFT-UP" and aKey ~= "CTRL-SHIFT-DOWN" then
			if SkuOptions.TTS:IsAutoRead() == true then
				SkuOptions.TTS:ToggleAutoRead()
				SkuOptions.Voice:StopOutputEmptyQueue(true, nil)
			end
			if SkuOptions.TTS:IsVisible() then
				SkuOptions.TTS:Hide()
			end
		end

		local tLineData = SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].history[SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].historyCurrentLine]
		
		if tLineData.itemLinks and #tLineData.itemLinks > 0 and self.menuOpen == false then
			if self.menuOpen == false then
				for w = 1, #tLineData.itemLinks do
					local ltSkuCurrentLineDatalinktTextFirstLine, ltSkuCurrentLineDatalinktTextFull = "", ""
					_G["SkuScanningTooltip"]:SetHyperlink(tLineData.itemLinks[w])

					if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "asd" then
						if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "" then
							local tText = SkuChat:Unescape(TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()))
							ltSkuCurrentLineDatalinktTextFirstLine, ltSkuCurrentLineDatalinktTextFull = SkuCore:ItemName_helper(tText)
						end
					end
					_G["SkuScanningTooltip"]:ClearLines()

					if ltSkuCurrentLineDatalinktTextFirstLine ~= "" then
						if w == 1 then
							tSkuCurrentLineDatalinktItemId = SkuGetItemIdFromItemLink(tLineData.itemLinks[w]) 
							tSkuCurrentLineDatalinktTextFirstLine, tSkuCurrentLineDatalinktTextFull = ltSkuCurrentLineDatalinktTextFirstLine, ltSkuCurrentLineDatalinktTextFull
							tSkuCurrentLineDatalinktTextFull = tSkuCurrentLineDatalinktTextFirstLine.."\r\n"..tSkuCurrentLineDatalinktTextFull

							local ttf = SkuCore:AuctionHouseGetAuctionPriceHistoryData(tSkuCurrentLineDatalinktItemId)
							if not ttf then
								ttf = {}
							end
							local tFull = tSkuCurrentLineDatalinktTextFull
							if type(ttf) ~= "table" then
								ttf = { (ttf or tSkuCurrentLineDatalinktTextFirstLine or ""), }
							end
							table.insert(ttf, 1, tFull)
							SkuCore:InsertComparisnSections(tSkuCurrentLineDatalinktItemId, ttf)
							tSkuCurrentLineDatalinktTextFull = ttf
						end
					end
				end
			end
		end		

		if self.menuOpen == false or (aKey == "SHIFT-UP" or aKey == "SHIFT-DOWN" or  aKey == "CTRL-SHIFT-UP" or aKey == "CTRL-SHIFT-DOWN") then
			if aKey == "CTRL-ENTER" then
				--build/open the line menu
				self.menuOpen = true
				SkuOptions.Menu = {}

				local tLineData = SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].history[SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].historyCurrentLine]

				--send
				local tAccessID
				if tLineData.messageTypeGroup == "CHANNEL" then
					_, tAccessID = ChatHistory_GetChatType(tLineData.accessID)
				end
				if not tAccessID then
					tAccessID = SkuChat:GetChannelAccessIdFromChannelName(tLineData.messageTypeGroup)
				end

				--[[
				--start route
				local _, _, _, tWpName = string.find(tLineData.body, "(.+)".."#"..L["Waypoint"]..":".."(.+)")
				if tWpName then
					local tWpObj = SkuNav:GetWaypointData2(tWpName)
					if tWpObj then
						local tNewMenuEntry = InjectMenuItemsNew(SkuOptions.Menu, {L["Start route to waypoint"]}, SkuGenericMenuItem)
						tNewMenuEntry.isSelect = true
						tNewMenuEntry.OnAction = function(self)
							--print("tWpName", tWpName)
							

							C_Timer.After(0.01, function() CloseChatMenuHelper() end)
						end
					end
				end
				]]

				--
				local tLineDataitemLinks = tLineData.itemLinks
				if tLineDataitemLinks and #tLineDataitemLinks > 0 then
					for w = 1, #tLineDataitemLinks do
						local ltSkuCurrentLineDatalinktTextFirstLine, ltSkuCurrentLineDatalinktTextFull = "", ""
						local ltSkuCurrentLineDatalinktItemId = ""
						_G["SkuScanningTooltip"]:SetHyperlink(tLineDataitemLinks[w])
		
						if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "asd" then
							if TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()) ~= "" then
								local tText = SkuChat:Unescape(TooltipLines_helper(_G["SkuScanningTooltip"]:GetRegions()))
								ltSkuCurrentLineDatalinktTextFirstLine, ltSkuCurrentLineDatalinktTextFull = SkuCore:ItemName_helper(tText)
							end
						end
						_G["SkuScanningTooltip"]:ClearLines()
						if ltSkuCurrentLineDatalinktTextFirstLine ~= "" then
							local tNewMenuEntry = InjectMenuItemsNew(SkuOptions.Menu, {L["link"].." "..w.." "..ltSkuCurrentLineDatalinktTextFirstLine}, SkuGenericMenuItem)
							tNewMenuEntry.tSkuCurrentLineDatalinktTextFirstLine = ltSkuCurrentLineDatalinktTextFirstLine
							tNewMenuEntry.tSkuCurrentLineDatalinktItemId = SkuGetItemIdFromItemLink(tLineDataitemLinks[w]) 
							local ttf = SkuCore:AuctionHouseGetAuctionPriceHistoryData(tNewMenuEntry.tSkuCurrentLineDatalinktItemId)
							if not ttf then
								ttf = {}
							end
							local tFull = ltSkuCurrentLineDatalinktTextFull
							if type(ttf) ~= "table" then
								ttf = { (ttf or tSkuCurrentLineDatalinktTextFirstLine or ""), }
							end
							table.insert(ttf, 1, tFull)
							SkuCore:InsertComparisnSections(tNewMenuEntry.tSkuCurrentLineDatalinktItemId, ttf)
							tNewMenuEntry.tSkuCurrentLineDatalinktTextFull = ttf
							tNewMenuEntry.OnEnter = function(self, aValue, aName)
								tSkuCurrentLineDatalinktTextFirstLine, tSkuCurrentLineDatalinktTextFull = self.tSkuCurrentLineDatalinktTextFirstLine, self.tSkuCurrentLineDatalinktTextFull
								tSkuCurrentLineDatalinktItemId = self.tSkuCurrentLineDatalinktItemId
							end
					
							if w == 1 then
								tSkuCurrentLineDatalinktTextFirstLine, tSkuCurrentLineDatalinktTextFull = ltSkuCurrentLineDatalinktTextFirstLine, ttf
								tSkuCurrentLineDatalinktItemId = SkuGetItemIdFromItemLink(tLineDataitemLinks[w]) 
							end
						end
					end
				end


				--
				local tNewMenuEntry = InjectMenuItemsNew(SkuOptions.Menu, {L["send to channel"]}, SkuGenericMenuItem)
				tNewMenuEntry.OnEnter = function(self, aValue, aName)
					tSkuCurrentLineDatalinktTextFirstLine, tSkuCurrentLineDatalinktTextFull, tSkuCurrentLineDatalinktItemId = "", "", ""
				end
				tNewMenuEntry.isSelect = true
				tNewMenuEntry.OnAction = function(self)
					if tAccessID then
						SkuChat:SetEditboxToCustom("CHANNEL", tAccessID, "")
						C_Timer.After(0.01, function() CloseChatMenuHelper() end)
					elseif tLineData.messageTypeGroup then
						SkuChat:SetEditboxToCustom(tLineData.messageTypeGroup)
						C_Timer.After(0.01, function() CloseChatMenuHelper() end)
					end
				end

				local tNewMenuEntry = InjectMenuItemsNew(SkuOptions.Menu, {L["send item link to channel"]}, SkuGenericMenuItem)
				tNewMenuEntry.OnEnter = function(self, aValue, aName)
					tSkuCurrentLineDatalinktTextFirstLine, tSkuCurrentLineDatalinktTextFull, tSkuCurrentLineDatalinktItemId = "", "", ""
				end
				tNewMenuEntry.dynamic = true
				tNewMenuEntry.BuildChildren = function(self)
					local tBagSlotListSorted = {
						[1] = 0,
						[2] = 1,
						[3] = 2,
						[4] = 3,
						[5] = 4,
						[6] = -1,
						[7] = 5,
						[8] = 6,
						[9] = 7,
						[10] = 8,
						[11] = 9,
						[12] = 10,
						[13] = 11,
						[14] = -2,
						[15] = -3,
					}
					local allBagResults = {}
					for q = 1, #tBagSlotListSorted do
						local bagId = tBagSlotListSorted[q]
						local tNumSlots = GetContainerNumSlots(bagId)
						for slotId = 1, tNumSlots do
							local icon, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID, isBound = GetContainerItemInfo(bagId, slotId)
							if itemLink then
								local tNewMenuEntryItem = InjectMenuItemsNew(self, {SkuChat:Unescape(itemLink).." ("..L["Bag"]..")"}, SkuGenericMenuItem)
								tNewMenuEntryItem.OnAction = function(self, a, b)
									if tAccessID then
										SkuChat:SetEditboxToCustom("CHANNEL", tAccessID, itemLink)
										C_Timer.After(0.01, function() CloseChatMenuHelper() end)
									elseif tLineData.messageTypeGroup then
										SkuChat:SetEditboxToCustom(tLineData.messageTypeGroup, nil, itemLink)
										C_Timer.After(0.01, function() CloseChatMenuHelper() end)
									end
								end					
		
							end
						end  
					end
					for slotId = 1, 40 do
						local itemLink = GetInventoryItemLink("player", slotId)
						if itemLink then
							local tNewMenuEntryItem = InjectMenuItemsNew(self, {SkuChat:Unescape(itemLink).." ("..L["Equipped"]..")"}, SkuGenericMenuItem)
							tNewMenuEntryItem.OnAction = function(self, a, b)
								if tAccessID then
									SkuChat:SetEditboxToCustom("CHANNEL", tAccessID, itemLink)
									C_Timer.After(0.01, function() CloseChatMenuHelper() end)
								elseif tLineData.messageTypeGroup then
									SkuChat:SetEditboxToCustom(tLineData.messageTypeGroup, nil, itemLink)
									C_Timer.After(0.01, function() CloseChatMenuHelper() end)
								end
							end					
						end
					end  
				end

				--whisper
				if tLineData.arg2 then
					local tNewMenuEntry = InjectMenuItemsNew(SkuOptions.Menu, {L["whisper sender"]}, SkuGenericMenuItem)
					tNewMenuEntry.OnEnter = function(self, aValue, aName)
						tSkuCurrentLineDatalinktTextFirstLine, tSkuCurrentLineDatalinktTextFull, tSkuCurrentLineDatalinktItemId = "", "", ""
					end
						tNewMenuEntry.isSelect = true
					tNewMenuEntry.OnAction = function(self)
						if tLineData.messageTypeGroup ~= "BN_WHISPER" then
							SkuChat:SetEditboxToCustom("WHISPER", MaskBattleNetNames(tLineData.arg2), "")
						else
							SkuChat:SetEditboxToCustom(tLineData.messageTypeGroup, MaskBattleNetNames(tLineData.arg2), "")
						end
						C_Timer.After(0.01, function() CloseChatMenuHelper() end)
					end
				end
	
				--invite
				if tLineData.arg2 then
					local tNewMenuEntry = InjectMenuItemsNew(SkuOptions.Menu, {L["invite sender"]}, SkuGenericMenuItem)
					tNewMenuEntry.OnEnter = function(self, aValue, aName)
						tSkuCurrentLineDatalinktTextFirstLine, tSkuCurrentLineDatalinktTextFull, tSkuCurrentLineDatalinktItemId = "", "", ""
					end
						tNewMenuEntry.isSelect = true
					tNewMenuEntry.OnAction = function(self)
						InviteUnit(MaskBattleNetNames(tLineData.arg2))
						C_Timer.After(0.01, function() CloseChatMenuHelper() end)
					end
				end

				--spellout name/message






				--copy sender name
				if tLineData.arg2 then
					local tNewMenuEntry = InjectMenuItemsNew(SkuOptions.Menu, {L["copy sender name"]}, SkuGenericMenuItem)
					tNewMenuEntry.OnEnter = function(self, aValue, aName)
						tSkuCurrentLineDatalinktTextFirstLine, tSkuCurrentLineDatalinktTextFull, tSkuCurrentLineDatalinktItemId = "", "", ""
					end
						tNewMenuEntry.isSelect = true
					tNewMenuEntry.OnAction = function(self)
						PlaySound(88)
						SkuOptions.Voice:OutputStringBTtts(L["Copy text with control plus C and press escape"], true, true, 0.2, nil, nil, nil, 2)
						SkuOptions:EditBoxShow(SkuChat:GetOnlyPlayerName(MaskBattleNetNames(tLineData.arg2)), function(self)
							PlaySound(89)
						end)					
						C_Timer.After(0.01, function() CloseChatMenuHelper() end)
					end
				end

				--copy line
				local tNewMenuEntry = InjectMenuItemsNew(SkuOptions.Menu, {L["copy chat line"]}, SkuGenericMenuItem)
				tNewMenuEntry.OnEnter = function(self, aValue, aName)
					tSkuCurrentLineDatalinktTextFirstLine, tSkuCurrentLineDatalinktTextFull, tSkuCurrentLineDatalinktItemId = "", "", ""
				end
				tNewMenuEntry.isSelect = true
				tNewMenuEntry.OnAction = function(self)
					PlaySound(88)
					SkuOptions.Voice:OutputStringBTtts(L["Copy text with control plus C and press escape"], true, true, 0.2, nil, nil, nil, 2)
					SkuOptions:EditBoxShow(MaskBattleNetNames(tLineData.body), function(self)
						PlaySound(89)
					end)					
					C_Timer.After(0.01, function() CloseChatMenuHelper() end)
				end

				--copy all lines
				local tNewMenuEntry = InjectMenuItemsNew(SkuOptions.Menu, {L["copy all chat lines"]}, SkuGenericMenuItem)
				tNewMenuEntry.OnEnter = function(self, aValue, aName)
					tSkuCurrentLineDatalinktTextFirstLine, tSkuCurrentLineDatalinktTextFull, tSkuCurrentLineDatalinktItemId = "", "", ""
				end
				tNewMenuEntry.isSelect = true
				tNewMenuEntry.OnAction = function(self)
					PlaySound(88)
					SkuOptions.Voice:OutputStringBTtts(L["Copy text with control plus C and press escape"], true, true, 0.2, nil, nil, nil, 2)
					local tText = ""
					for line = 1, #SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].history do
						tText = tText..SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].history[line].body.."\r\n"
					end
					SkuOptions:EditBoxShow(tText, function(self)
						PlaySound(89)
					end)					
					C_Timer.After(0.01, function() CloseChatMenuHelper() end)
				end

				--target








				--add friend
				if tLineData.arg2 then
					local tNewMenuEntry = InjectMenuItemsNew(SkuOptions.Menu, {L["add sender to friend list"]}, SkuGenericMenuItem)
					tNewMenuEntry.OnEnter = function(self, aValue, aName)
						tSkuCurrentLineDatalinktTextFirstLine, tSkuCurrentLineDatalinktTextFull, tSkuCurrentLineDatalinktItemId = "", "", ""
					end
						tNewMenuEntry.isSelect = true
					tNewMenuEntry.OnAction = function(self)
						PlaySound(88)
						SkuOptions.Voice:OutputStringBTtts(L["Notiz eingeben und Enter drücken"], true, true, 0.2, nil, nil, nil, 2)
						SkuOptions:EditBoxShow("", function(self)
							if tLineData.arg2 and self:GetText() then
								C_FriendList.AddFriend(tLineData.arg2, self:GetText())
							end
							PlaySound(89)
						end)					
						C_Timer.After(0.01, function() CloseChatMenuHelper() end)
					end
				end			

				--ignore
				if tLineData.arg2 then
					local tNewMenuEntry = InjectMenuItemsNew(SkuOptions.Menu, {L["ignore sender"]}, SkuGenericMenuItem)
					tNewMenuEntry.OnEnter = function(self, aValue, aName)
						tSkuCurrentLineDatalinktTextFirstLine, tSkuCurrentLineDatalinktTextFull, tSkuCurrentLineDatalinktItemId = "", "", ""
					end
						tNewMenuEntry.isSelect = true
					tNewMenuEntry.OnAction = function(self)
						PlaySound(88)
						if tLineData.arg2 then
							C_FriendList.AddIgnore(tLineData.arg2)
						end
						C_Timer.After(0.01, function() CloseChatMenuHelper() end)
					end
				end	

				local tNewMenuEntry = InjectMenuItemsNew(SkuOptions.Menu, {L["Clear history"]}, SkuGenericMenuItem)
				tNewMenuEntry.OnEnter = function(self, aValue, aName)
					tSkuCurrentLineDatalinktTextFirstLine, tSkuCurrentLineDatalinktTextFull, tSkuCurrentLineDatalinktItemId = "", "", ""
				end
				tNewMenuEntry.isSelect = true
				tNewMenuEntry.OnAction = function(self)
					PlaySound(88)
					SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].history = {}
					table.insert(SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].history, 1, {
						body = L["Empty"], 
						messageTypeGroup = "SAY", 
						audio = false, 
						accessID = nil, 
						typeID = nil, 
						arg2 = nil, 
						time = time(),
					})					
				C_Timer.After(0.01, function() CloseChatMenuHelper() end)
				end

				local tNewMenuEntry = InjectMenuItemsNew(SkuOptions.Menu, {L["Delete tab"]}, SkuGenericMenuItem)
				tNewMenuEntry.OnEnter = function(self, aValue, aName)
					tSkuCurrentLineDatalinktTextFirstLine, tSkuCurrentLineDatalinktTextFull, tSkuCurrentLineDatalinktItemId = "", "", ""
				end
				tNewMenuEntry.isSelect = true
				tNewMenuEntry.OnAction = function(self)
					PlaySound(88)
					SkuChat:DeleteTab(SkuChat.currentTab)
					C_Timer.After(0.01, function() CloseChatMenuHelper() end)
				end

				SkuOptions.currentMenuPosition = SkuOptions.Menu[1]
				SkuOptions.Voice:OutputStringBTtts(SkuOptions.Menu[1].name, true, true, 0.3, nil, nil, nil, 2)

			--more chat/tab navigation







			elseif aKey ==  "SHIFT-UP" then
				SkuOptions.currentMenuPosition = SkuOptions.currentMenuPosition or {}
				SkuOptions.currentMenuPosition.textFull = tSkuCurrentLineDatalinktTextFull
				if SkuOptions.currentMenuPosition.textFull ~= "" then
					local tTextFull = SkuOptions:AddExtraTooltipData(SkuOptions.currentMenuPosition.textFull, tSkuCurrentLineDatalinktItemId)
					if not SkuOptions.TTS:IsVisible() then
						SkuOptions.TTS:Output(tTextFull, 1000)
					end
					SkuOptions.currentMenuPosition.links = {}
					SkuOptions.currentMenuPosition.linksSelected = 0
					if SkuOptions.TTS:IsAutoRead() == true then
						SkuOptions.TTS:ToggleAutoRead()
						SkuOptions.TTS.AutoReadEventFlag = nil
					end					
					SkuOptions.TTS:PreviousLine(SkuOptions.currentMenuPosition.ttsEngine)
				end
			
			elseif aKey ==  "SHIFT-DOWN" then
				SkuOptions.currentMenuPosition = SkuOptions.currentMenuPosition or {}
				SkuOptions.currentMenuPosition.textFull = tSkuCurrentLineDatalinktTextFull
				if SkuOptions.currentMenuPosition.textFull ~= "" then
					local tTextFull = SkuOptions:AddExtraTooltipData(SkuOptions.currentMenuPosition.textFull, tSkuCurrentLineDatalinktItemId)
					if SkuOptions.TTS:IsVisible() == false then
						SkuOptions.TTS:Output(tTextFull, 1000)
					end
					SkuOptions.currentMenuPosition.links = {}
					SkuOptions.currentMenuPosition.linksSelected = 0
					if SkuOptions.TTS:IsAutoRead() == true then
						SkuOptions.TTS:ToggleAutoRead()
						SkuOptions.TTS.AutoReadEventFlag = nil
					end					
					SkuOptions.TTS:NextLine(SkuOptions.currentMenuPosition.ttsEngine)
				end
			
			elseif aKey ==  "CTRL-SHIFT-UP" then
				SkuOptions.currentMenuPosition = SkuOptions.currentMenuPosition or {}
				SkuOptions.currentMenuPosition.textFull = tSkuCurrentLineDatalinktTextFull
				if SkuOptions.currentMenuPosition.textFull ~= "" then
					local tTextFull = SkuOptions:AddExtraTooltipData(SkuOptions.currentMenuPosition.textFull, tSkuCurrentLineDatalinktItemId)
					if not SkuOptions.TTS:IsVisible() then
						SkuOptions.TTS:Output(tTextFull, 1000)
					end
					SkuOptions.currentMenuPosition.links = {}
					SkuOptions.currentMenuPosition.linksSelected = 0
					if SkuOptions.TTS:IsAutoRead() == true then
						SkuOptions.TTS:ToggleAutoRead()
						SkuOptions.TTS.AutoReadEventFlag = nil
					end					
					SkuOptions.TTS:PreviousSection(SkuOptions.currentMenuPosition.ttsEngine)
				end
			
			elseif aKey ==  "CTRL-SHIFT-DOWN" then
				SkuOptions.currentMenuPosition = SkuOptions.currentMenuPosition or {}
				SkuOptions.currentMenuPosition.textFull = tSkuCurrentLineDatalinktTextFull
				if SkuOptions.currentMenuPosition.textFull ~= "" then
					local tTextFull = SkuOptions:AddExtraTooltipData(SkuOptions.currentMenuPosition.textFull, tSkuCurrentLineDatalinktItemId)
					if not SkuOptions.TTS:IsVisible() then
						SkuOptions.TTS:Output(tTextFull, 1000)
					end
					SkuOptions.currentMenuPosition.links = {}
					SkuOptions.currentMenuPosition.linksSelected = 0
					if SkuOptions.TTS:IsAutoRead() == true then
						SkuOptions.TTS:ToggleAutoRead()
						SkuOptions.TTS.AutoReadEventFlag = nil
					end					
					SkuOptions.TTS:NextSection(SkuOptions.currentMenuPosition.ttsEngine)
				end
			
			elseif aKey == "UP" then
			--elseif aKey == SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_CHAT_LINEPREV"].key then
			local tHistoryCurrentLine = SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].historyCurrentLine
				if tHistoryCurrentLine > 1 then
					SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].historyCurrentLine = tHistoryCurrentLine - 1
				end
				SkuChat:ReadLine(SkuChat.currentTab, SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].historyCurrentLine)
				local tLineData = SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].history[SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].historyCurrentLine]
				if (not tLineData.itemLinks or #tLineData.itemLinks == 0) and self.menuOpen == false then
					tSkuCurrentLineDatalinktTextFirstLine, tSkuCurrentLineDatalinktTextFull, tSkuCurrentLineDatalinktItemId = "", "", ""
				end

			elseif aKey == "DOWN" then
				local tHistoryCurrentLine = SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].historyCurrentLine
				if tHistoryCurrentLine < #SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].history then
					SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].historyCurrentLine = tHistoryCurrentLine + 1
				end
				SkuChat:ReadLine(SkuChat.currentTab, SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].historyCurrentLine)
				local tLineData = SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].history[SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].historyCurrentLine]
				if (not tLineData.itemLinks or #tLineData.itemLinks == 0) and self.menuOpen == false then
					tSkuCurrentLineDatalinktTextFirstLine, tSkuCurrentLineDatalinktTextFull, tSkuCurrentLineDatalinktItemId = "", "", ""
				end

			elseif aKey == "LEFT" then
				if SkuChat.currentTab > 1 then
					SkuChat.currentTab = SkuChat.currentTab - 1
				else
					SkuChat.currentTab = #SkuOptions.db.profile["SkuChat"].tabs
				end
				if SkuOptions.db.profile[MODULE_NAME].chatSettings.firstLineOnTabSwitch == true then
					SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].historyCurrentLine = 1
				end
				SkuChat:ReadLine(SkuChat.currentTab, SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].historyCurrentLine, true)
				local tLineData = SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].history[SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].historyCurrentLine]
				if (not tLineData.itemLinks or #tLineData.itemLinks == 0) and self.menuOpen == false then
					tSkuCurrentLineDatalinktTextFirstLine, tSkuCurrentLineDatalinktTextFull, tSkuCurrentLineDatalinktItemId = "", "", ""
				end

			elseif aKey == "RIGHT" then
				if SkuChat.currentTab < #SkuOptions.db.profile["SkuChat"].tabs then
					SkuChat.currentTab = SkuChat.currentTab + 1
				else
					SkuChat.currentTab = 1
				end
				if SkuOptions.db.profile[MODULE_NAME].chatSettings.firstLineOnTabSwitch == true then
					SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].historyCurrentLine = 1
				end
				SkuChat:ReadLine(SkuChat.currentTab, SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].historyCurrentLine, true)
				local tLineData = SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].history[SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].historyCurrentLine]
				if (not tLineData.itemLinks or #tLineData.itemLinks == 0) and self.menuOpen == false then
					tSkuCurrentLineDatalinktTextFirstLine, tSkuCurrentLineDatalinktTextFull, tSkuCurrentLineDatalinktItemId = "", "", ""
				end

			end

		--handle menu navigation			
		else
			--if user is leaving the line menu with SKU_KEY_CHAT_TABPREV
			if aKey == "LEFT" and self.menuOpen == true then
				CloseChatMenuHelper()
				SkuChat:ReadLine(SkuChat.currentTab, SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].historyCurrentLine)
			end

			--more menu navigation
			if self.menuOpen == true then
				if aKey == "RIGHT" then
					SkuOptions.currentMenuPosition:OnSelect()
					SkuOptions:VocalizeCurrentMenuName(true)
				end
				if aKey == "UP" then
					SkuOptions.currentMenuPosition:OnPrev()
					SkuOptions:VocalizeCurrentMenuName(true)
				end
				if aKey == "DOWN" then
					SkuOptions.currentMenuPosition:OnNext()
					SkuOptions:VocalizeCurrentMenuName(true)
				end
				--menu entry selected
				if aKey == "CTRL-ENTER" then
					SkuOptions.currentMenuPosition:OnAction()
				end

			end
		end

	end)
end

---------------------------------------------------------------------------------------------------------------------------------------
--this is just a wrapper for external use
function SkuChat:CloseChat()
	if not _G["OnSkuChatToggle"] then
		return
	end
	_G["OnSkuChatToggle"]:CloseChat(_G["OnSkuChatToggle"])
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:OnEnable()
	--we need a secure handler to use setbindingclick/ClearBinding IC
	local b = _G["OnSkuChatToggleSecureHandler"] or CreateFrame("Button", "OnSkuChatToggleSecureHandler", UIParent, "SecureHandlerClickTemplate")
	b:SetFrameRef("OnSkuChatToggle", OnSkuChatToggle)
	b:SetAttribute("_onclick", [=[
		if self:GetAttribute("ChatOpen") ~= true then
			self:GetFrameRef("OnSkuChatToggle"):CallMethod("OpenChat")
			self:SetBindingClick(true, self:GetAttribute("SKU_KEY_CHAT_LINEPREV"), "OnSkuChatToggle", self:GetAttribute("SKU_KEY_CHAT_LINEPREV"))
			self:SetBindingClick(true, self:GetAttribute("SKU_KEY_CHAT_LINENEXT"), "OnSkuChatToggle", self:GetAttribute("SKU_KEY_CHAT_LINENEXT"))
			self:SetBindingClick(true, self:GetAttribute("SKU_KEY_CHAT_TABPREV"), "OnSkuChatToggle", self:GetAttribute("SKU_KEY_CHAT_TABPREV"))
			self:SetBindingClick(true, self:GetAttribute("SKU_KEY_CHAT_TABNEXT"), "OnSkuChatToggle", self:GetAttribute("SKU_KEY_CHAT_TABNEXT"))
			self:SetBindingClick(true, self:GetAttribute("SKU_KEY_CHAT_LINEMENU"), "OnSkuChatToggle", self:GetAttribute("SKU_KEY_CHAT_LINEMENU"))
			self:SetBindingClick(true, self:GetAttribute("SHIFT-DOWN"), "OnSkuChatToggle", self:GetAttribute("SHIFT-DOWN"))
			self:SetBindingClick(true, self:GetAttribute("SHIFT-UP"), "OnSkuChatToggle", self:GetAttribute("SHIFT-UP"))
			self:SetBindingClick(true, self:GetAttribute("CTRL-SHIFT-DOWN"), "OnSkuChatToggle", self:GetAttribute("CTRL-SHIFT-DOWN"))
			self:SetBindingClick(true, self:GetAttribute("CTRL-SHIFT-UP"), "OnSkuChatToggle", self:GetAttribute("CTRL-SHIFT-UP"))
			self:SetBindingClick(true, self:GetAttribute("ESCAPE"), "OnSkuChatToggleSecureHandler", self:GetAttribute("ESCAPE"))
			self:SetAttribute("ChatOpen", true)
		else
			self:GetFrameRef("OnSkuChatToggle"):CallMethod("CloseChat")
			if self:GetAttribute("ChatOpen") == true then
				self:ClearBinding(self:GetAttribute("SKU_KEY_CHAT_LINEPREV"))
				self:ClearBinding(self:GetAttribute("SKU_KEY_CHAT_LINENEXT"))
				self:ClearBinding(self:GetAttribute("SKU_KEY_CHAT_TABPREV"))
				self:ClearBinding(self:GetAttribute("SKU_KEY_CHAT_TABNEXT"))
				self:ClearBinding(self:GetAttribute("SKU_KEY_CHAT_LINEMENU"))
				self:ClearBinding(self:GetAttribute("SHIFT-DOWN"))
				self:ClearBinding(self:GetAttribute("SHIFT-UP"))
				self:ClearBinding(self:GetAttribute("CTRL-SHIFT-DOWN"))
				self:ClearBinding(self:GetAttribute("CTRL-SHIFT-UP"))
				self:ClearBinding(self:GetAttribute("ESCAPE"))
				self:SetAttribute("ChatOpen", false)
			end
		end
	]=])
	b:SetSize(1, 1)
	b:SetPoint("CENTER", -10, 10)
	b:Hide()

	-- attributes with button names for SetBindingClick. can only be updated ooc
	b:SetAttribute("SKU_KEY_CHAT_LINEPREV", "UP")
	b:SetAttribute("SKU_KEY_CHAT_LINENEXT", "DOWN")
	b:SetAttribute("SKU_KEY_CHAT_TABPREV", "LEFT")
	b:SetAttribute("SKU_KEY_CHAT_TABNEXT", "RIGHT")
	b:SetAttribute("SKU_KEY_CHAT_LINEMENU", "CTRL-ENTER")
	b:SetAttribute("SHIFT-DOWN", "SHIFT-DOWN")
	b:SetAttribute("SHIFT-UP", "SHIFT-UP")
	b:SetAttribute("CTRL-SHIFT-DOWN", "CTRL-SHIFT-DOWN")
	b:SetAttribute("CTRL-SHIFT-UP", "CTRL-SHIFT-UP")
	b:SetAttribute("ESCAPE", "ESCAPE")
	b:SetAttribute("ChatOpen", false)

	SetOverrideBindingClick(b, true, SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_CHATOPEN"].key, b:GetName(), SkuOptions.db.profile["SkuOptions"].SkuKeyBinds["SKU_KEY_CHATOPEN"].key)	
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:ReadLine(aTab, aLine, aReadTabName)
	if not SkuOptions.db.profile["SkuChat"].tabs[aTab] then
		return
	end
	if not SkuOptions.db.profile["SkuChat"].tabs[aTab].history[aLine] then
		return
	end
	
	local tLineText = SkuOptions.db.profile["SkuChat"].tabs[aTab].history[aLine].body

	if SkuOptions.db.profile[MODULE_NAME].chatSettings.addLineNumbers == true then
		tLineText =  aLine.." "..tLineText
	end

	if SkuOptions.db.profile[MODULE_NAME].chatSettings.timeStamp > 1 then
		if SkuOptions.db.profile[MODULE_NAME].chatSettings.timeStampAtLineEnd == true then
			tLineText =  tLineText..", "..BetterDate(SkuChat.timeStampFormats[SkuOptions.db.profile[MODULE_NAME].chatSettings.timeStamp], SkuOptions.db.profile["SkuChat"].tabs[aTab].history[aLine].time or time())
		else
			tLineText =  BetterDate(SkuChat.timeStampFormats[SkuOptions.db.profile[MODULE_NAME].chatSettings.timeStamp], SkuOptions.db.profile["SkuChat"].tabs[aTab].history[aLine].time or time())..", "..tLineText
		end
	end

	if aReadTabName then
		tLineText = SkuOptions.db.profile["SkuChat"].tabs[aTab].name..", "..(tLineText or "")
	end

	if tLineText then
		SkuOptions.Voice:OutputStringBTtts(tLineText, true, true, 0.3, nil, nil, nil, 2)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:NewWhisperTab(aType, ...)
	if SkuOptions.db.profile[MODULE_NAME].chatSettings.openWhispersInNewTab == true then
		local event, text, playerName, languageName, channelName, playerName2, specialFlags, zoneChannelID, channelIndex, channelBaseName, languageID, lineID, guid, bnSenderID, isMobile, isSubtitle, hideSenderInLetterbox, supressRaidIcons = ...

		--print("NewWhisperTab", aType, event, text, playerName, languageName, channelName, playerName2, specialFlags, zoneChannelID, channelIndex, channelBaseName, languageID, lineID, guid, bnSenderID, isMobile, isSubtitle, hideSenderInLetterbox, supressRaidIcons)

		playerName = SkuChat:GetFullPlayerName(playerName)
		playerName2 = SkuChat:GetFullPlayerName(playerName2)

		local tSender = playerName
		if aType == "INFORM" then
			tSender = playerName2
		end

		local tTabNumber 
		for z = 1, #SkuOptions.db.profile["SkuChat"].tabs do
			if SkuOptions.db.profile["SkuChat"].tabs[z].privateMessages then
				for x = 1, #SkuOptions.db.profile["SkuChat"].tabs[z].privateMessages do
					if SkuOptions.db.profile["SkuChat"].tabs[z].privateMessages[x] == tSender then 
						tTabNumber = z
						local tTab = SkuOptions.db.profile["SkuChat"].tabs[z]
						tTab.messageTypes["PLAYER_MESSAGES"][6] = play
						tTab.messageTypes["PLAYER_MESSAGES"][7] = play
						tTab.messageTypes["CREATURE_MESSAGES"][4] = play
						tTab.messageTypes["CREATURE_MESSAGES"][6] = play
					end
				end
			else
				local tTab = SkuOptions.db.profile["SkuChat"].tabs[z]
				tTab.messageTypes["PLAYER_MESSAGES"][6] = false
				tTab.messageTypes["PLAYER_MESSAGES"][7] = false
				tTab.messageTypes["CREATURE_MESSAGES"][4] = false
				tTab.messageTypes["CREATURE_MESSAGES"][6] = false			
			end
		end

		if not tTabNumber then
			local tNewTabName
			if aType == "WHISPER" then
				tNewTabName = playerName
			elseif aType == "INFORM" then
				tNewTabName = playerName2
			end

			tTabNumber = SkuChat:NewTab(tSender)
			SkuOptions.db.profile["SkuChat"].tabs[tTabNumber].privateMessages = {}
			table.insert(SkuOptions.db.profile["SkuChat"].tabs[tTabNumber].privateMessages, tSender)

			local tTab = SkuOptions.db.profile["SkuChat"].tabs[tTabNumber]
			for tCatName, tData in pairs(SkuChat.ChatFrameMessageTypes) do
				for x = 1, #tData do
					tTab.messageTypes[tCatName][x] = false
				end
			end
			tTab.messageTypes["PLAYER_MESSAGES"][6] = play
			tTab.messageTypes["PLAYER_MESSAGES"][7] = play
			tTab.messageTypes["CREATURE_MESSAGES"][4] = play
			tTab.messageTypes["CREATURE_MESSAGES"][6] = play

			SkuOptions.db.profile["SkuChat"].tabs[tTabNumber].channels = {}
			SkuChat:InitTab(tTabNumber)

			C_Timer.After(0.1, function() 
				--print("cu", SkuOptions.db.profile["SkuChat"].tabs[tTabNumber].history[1])
				if SkuOptions.db.profile["SkuChat"].tabs[tTabNumber].history[1] and SkuOptions.db.profile["SkuChat"].tabs[tTabNumber].history[1].body == L["Empty"] then
					--print("C_Timer.After", _G[SkuOptions.db.profile["SkuChat"].tabs[tTabNumber].frameName], event, text, playerName, languageName, channelName, playerName2, specialFlags, zoneChannelID, channelIndex, channelBaseName, languageID, lineID, guid, bnSenderID, isMobile, isSubtitle, hideSenderInLetterbox, supressRaidIcons)
					SkuChat_MessageEventHandler(_G[SkuOptions.db.profile["SkuChat"].tabs[tTabNumber].frameName], event, text, playerName, languageName, channelName, playerName2, specialFlags, zoneChannelID, channelIndex, channelBaseName, languageID, lineID, guid, bnSenderID, isMobile, isSubtitle, hideSenderInLetterbox, supressRaidIcons)
				end
			end)
		end

		return tTabNumber
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:CHAT_MSG_WHISPER(...)
	SkuChat:NewWhisperTab("WHISPER", ...)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:CHAT_MSG_WHISPER_INFORM(...)
	SkuChat:NewWhisperTab("INFORM", ...)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:DEFAULT_CHAT_FRAME_AddMessage(...)
	local a, b, c, d, e, f = ...
	if a == "" or a == " " then
		return
	end
	--SkuCore:Debug((a or "nil").." "..(b or "nil").." "..(c or "nil").." "..(d or "nil").." "..(e or "nil").." "..(f or "nil"))
	for i, v in pairs(SkuOptions.db.profile["SkuChat"].tabs) do

		if v.name ~= L["Combat Log"] and v.name ~= L["Audio Log"] then
			if _G[v.frameName] then
				if _G[v.frameName].AddMessage then
					if b == nil and c == nil and  d == nil and  e == nil and  f == nil then
						_G[v.frameName]:AddMessage("ADDON", a, 1, 1, 1, 0, 0, 0, "AddMessage")
					end
				end
			end
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:VARIABLES_LOADED(...)

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:PLAYER_LOGIN(...)
	SkuCore.outputSoundFiles["sound-newChatLine"] =L["aura;sound"].."#"..L["default new Chat Line sound"]
	SkuCore.outputSoundFiles["sound-silence0.1"] = L["aura;sound"].."#"..L["silent"]
	if SkuOptions.db.profile["SkuChat"].tabs then
		for x = 1, #SkuOptions.db.profile["SkuChat"].tabs do
			if SkuOptions.db.profile["SkuChat"].tabs[x].audioOnNewMessage == true then
				SkuOptions.db.profile["SkuChat"].tabs[x].audioOnNewMessage = "sound-newChatLine"
			elseif SkuOptions.db.profile["SkuChat"].tabs[x].audioOnNewMessage == false then
				SkuOptions.db.profile["SkuChat"].tabs[x].audioOnNewMessage = "sound-silence0.1"
			end
		end
	end

	hooksecurefunc(DEFAULT_CHAT_FRAME, "AddMessage", SkuChat.DEFAULT_CHAT_FRAME_AddMessage)

	ChatFrame1:HookScript("OnShow", function(self)
		C_Timer.After(5, function()
			SkuChat:JoinOrLeaveSkuChatChannel()
		end)
	end)

	ChatFrame1EditBox:HookScript("OnTextChanged", function(self, a, b, c)
		if SkuChatEditboxHookFlag == false then
			local tCurrentText = ChatFrame1EditBox:GetText() or ""
			tCurrentText = string.lower(tCurrentText)
			if tCurrentText == "/skuchat" then
				SkuChat:SetEditboxToSkuChat("")
			end
		end
	end)

	hooksecurefunc(ChatFrame1EditBox, "Show", SkuChat.ChatFrame1EditBoxOnShow)
	hooksecurefunc(ChatFrame1EditBox, "Hide", SkuChat.ChatFrame1EditBoxOnHide)

	C_TTSSettings.SetSetting(Enum.TtsBoolSetting.PlaySoundSeparatingChatLineBreaks, SkuOptions.db.profile[MODULE_NAME].chatSettings.audioOnMessageEnd)
end

---------------------------------------------------------------------------------------------------------------------------------------
--hooks to play the chateditbox sounds
local ChatFrame1EditBoxIsShown = false
function SkuChat:ChatFrame1EditBoxOnShow()
	if ChatFrame1EditBoxIsShown == false  then
		ChatFrame1EditBoxIsShown = true
		PlaySoundFile("Interface\\AddOns\\Sku\\SkuChat\\assets\\audio\\chateditbox_open.mp3", "Talking Head")
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:ChatFrame1EditBoxOnHide()
	if ChatFrame1EditBoxIsShown == true  then
		ChatFrame1EditBoxIsShown = false
		PlaySoundFile("Interface\\AddOns\\Sku\\SkuChat\\assets\\audio\\chateditbox_close.mp3", "Talking Head")
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:JoinOrLeaveSkuChatChannel()
	local id, name, instanceID, isCommunitiesChannel = GetChannelName("SkuChat")

	if SkuOptions.db.profile["SkuChat"].joinSkuChannel == true then
		if id == 0 then
			JoinPermanentChannel("SkuChat", nil, FCF_GetCurrentChatFrame():GetID())
			ChatFrame_AddChannel(ChatFrame1, "SkuChat")
		end
	else
		if id ~= 0 then
			LeaveChannelByName("SkuChat")
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:CombatLogTabIndex()
	for x = 1, #SkuOptions.db.profile["SkuChat"].tabs do
		if SkuOptions.db.profile["SkuChat"].tabs[x].name == L["Combat Log"] then
			return x
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:InitCombatLogTab()
	if SkuOptions.db.profile["SkuChat"].CombatLog.enabled == true then
		if not SkuChat:CombatLogTabIndex() then

			local tabIndex = SkuChat:NewTab(L["Combat Log"])
			for i, v in pairs(SkuOptions.db.profile["SkuChat"].tabs[tabIndex].messageTypes) do
				for u = 1, #v do
					v[u] = false
				end
			end
			for i, v in pairs(SkuOptions.db.profile["SkuChat"].tabs[tabIndex].channels) do
				v.status = false
			end

			SkuOptions.db.profile["SkuChat"].tabs[tabIndex].audioOnNewMessage = "sound-silence0.1"
			SkuOptions.db.profile["SkuChat"].tabs[tabIndex].messageTypes["SKU"][1] = true

			SkuChat:InitTab(tabIndex)
		end
	else
		if SkuChat:CombatLogTabIndex() then
			SkuChat:DeleteTab(SkuChat:CombatLogTabIndex())
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:AudioLogTabIndex()
	for x = 1, #SkuOptions.db.profile["SkuChat"].tabs do
		if SkuOptions.db.profile["SkuChat"].tabs[x].name == L["Audio Log"] then
			return x
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:InitAudioLogTab()
	if SkuOptions.db.profile["SkuChat"].AudioLog.enabled == true then
		if not SkuChat:AudioLogTabIndex() then
			local tabIndex = SkuChat:NewTab(L["Audio Log"])
			for i, v in pairs(SkuOptions.db.profile["SkuChat"].tabs[tabIndex].messageTypes) do
				for u = 1, #v do
					v[u] = false
				end
			end
			for i, v in pairs(SkuOptions.db.profile["SkuChat"].tabs[tabIndex].channels) do
				v.status = false
			end

			SkuOptions.db.profile["SkuChat"].tabs[tabIndex].audioOnNewMessage = "sound-silence0.1"
			SkuOptions.db.profile["SkuChat"].tabs[tabIndex].messageTypes["SKU"][2] = true

			SkuChat:InitTab(tabIndex)
		end
	else
		if SkuChat:AudioLogTabIndex() then
			SkuChat:DeleteTab(SkuChat:AudioLogTabIndex())
		end
	end			
end

---------------------------------------------------------------------------------------------------------------------------------------
local function CreateSkuDefaultFilters()
	SkuOptions.db.global["SkuChat"] = SkuOptions.db.global["SkuChat"] or {}
	SkuOptions.db.global["SkuChat"].CombatLogFilters = SkuOptions.db.global["SkuChat"].CombatLogFilters or {
		[1] = {
			custom = false,
			name = "Everything",
			hasQuickButton = true,
			quickButtonName = "Everything",
			quickButtonDisplay = {
				solo = true,
				party = true,
				raid = true,
			},
			tooltip = "Everything",
			settings = CopyTable(COMBATLOG_DEFAULT_SETTINGS),
			colors = CopyTable(COMBATLOG_DEFAULT_COLORS),
			filters = {
				[1] = {
					eventList = Blizzard_CombatLog_GenerateFullEventList(),
					sourceFlags = {
						--[COMBATLOG_FILTER_ME] = true,
						[COMBATLOG_FILTER_MINE] = true,
						[COMBATLOG_FILTER_MY_PET] = true,
						[COMBATLOG_FILTER_FRIENDLY_UNITS] = true,
						[COMBATLOG_FILTER_HOSTILE_PLAYERS] = true,
						[COMBATLOG_FILTER_HOSTILE_UNITS] = true,
						[COMBATLOG_FILTER_NEUTRAL_UNITS] = true,
						[COMBATLOG_FILTER_UNKNOWN_UNITS] = true,
						--[COMBATLOG_FILTER_EVERYTHING] = false,
					},
				},
				[2] = {
					eventList = Blizzard_CombatLog_GenerateFullEventList(),
					destFlags = {
						--[COMBATLOG_FILTER_ME] = true,
						[COMBATLOG_FILTER_MINE] = true,
						[COMBATLOG_FILTER_MY_PET] = true,
						[COMBATLOG_FILTER_FRIENDLY_UNITS] = true,
						[COMBATLOG_FILTER_HOSTILE_PLAYERS] = true,
						[COMBATLOG_FILTER_HOSTILE_UNITS] = true,
						[COMBATLOG_FILTER_NEUTRAL_UNITS] = true,
						[COMBATLOG_FILTER_UNKNOWN_UNITS] = true,
						--[COMBATLOG_FILTER_EVERYTHING] = false,
					},
				},				
			},
		},
		[2] = {
			custom = false,
			name = "My actions",
			hasQuickButton = true,
			quickButtonName = "My actions",
			quickButtonDisplay = {
				solo = true,
				party = true,
				raid = true,
			},
			tooltip = "My actions",
			settings = CopyTable(COMBATLOG_DEFAULT_SETTINGS),
			colors = CopyTable(COMBATLOG_DEFAULT_COLORS),
			filters = {
				[1] = {
					eventList = {
						["ENVIRONMENTAL_DAMAGE"] = false,
						["SWING_DAMAGE"] = true,
						["SWING_MISSED"] = false,
						["RANGE_DAMAGE"] = true,
						["RANGE_MISSED"] = false,
						--["SPELL_CAST_START"] = true,
						--["SPELL_CAST_SUCCESS"] = true,
						--["SPELL_CAST_FAILED"] = true,
						["SPELL_MISSED"] = false,
						["SPELL_DAMAGE"] = true,
						["SPELL_HEAL"] = true,
						["SPELL_ENERGIZE"] = true,
						["SPELL_DRAIN"] = false,
						["SPELL_LEECH"] = false,
						["SPELL_INSTAKILL"] = false,
						["SPELL_INTERRUPT"] = false,
						["SPELL_EXTRA_ATTACKS"] = false,
						["SPELL_DURABILITY_DAMAGE"] = false,
						["SPELL_DURABILITY_DAMAGE_ALL"] = false,
						["SPELL_AURA_APPLIED"] = false,
						["SPELL_AURA_APPLIED_DOSE"] = false,
						["SPELL_AURA_REMOVED"] = false,
						["SPELL_AURA_REMOVED_DOSE"] = false,
						["SPELL_AURA_BROKEN"] = false,
					  ["SPELL_AURA_BROKEN_SPELL"] = false,
					  ["SPELL_AURA_REFRESH"] = false,
						["SPELL_DISPEL"] = false,
						["SPELL_STOLEN"] = false,
						["ENCHANT_APPLIED"] = false,
						["ENCHANT_REMOVED"] = false,
						["SPELL_PERIODIC_MISSED"] = false,
						["SPELL_PERIODIC_DAMAGE"] = true,
						["SPELL_PERIODIC_HEAL"] = true,
						["SPELL_PERIODIC_ENERGIZE"] = true,
						["SPELL_PERIODIC_DRAIN"] = false,
						["SPELL_PERIODIC_LEECH"] = false,
						["SPELL_DISPEL_FAILED"] = false,
						--["DAMAGE_SHIELD"] = true,
						--["DAMAGE_SHIELD_MISSED"] = true,
						["DAMAGE_SPLIT"] = true,
						["PARTY_KILL"] = true,
						["UNIT_DIED"] = false,
						["UNIT_DESTROYED"] = true,
						["UNIT_DISSIPATES"] = true,
					  ["UNIT_LOYALTY"] = false
					};
					sourceFlags = {
						[COMBATLOG_FILTER_MINE] = true
					};
					destFlags = nil;
				},
				[2] = {
					eventList = {
						--["ENVIRONMENTAL_DAMAGE"] = true,
						["SWING_DAMAGE"] = true,
						["SWING_MISSED"] = true,
						["RANGE_DAMAGE"] = true,
						["RANGE_MISSED"] = true,
						--["SPELL_CAST_START"] = true,
						--["SPELL_CAST_SUCCESS"] = true,
						--["SPELL_CAST_FAILED"] = true,
						["SPELL_MISSED"] = true,
						["SPELL_DAMAGE"] = true,
						["SPELL_HEAL"] = true,
						["SPELL_ENERGIZE"] = true,
						["SPELL_DRAIN"] = true,
						["SPELL_LEECH"] = true,
						["SPELL_INSTAKILL"] = true,
						["SPELL_INTERRUPT"] = true,
						["SPELL_EXTRA_ATTACKS"] = true,
						["SPELL_DURABILITY_DAMAGE"] = true,
						["SPELL_DURABILITY_DAMAGE_ALL"] = true,
						--["SPELL_AURA_APPLIED"] = true,
						--["SPELL_AURA_APPLIED_DOSE"] = true,
						--["SPELL_AURA_REMOVED"] = true,
						--["SPELL_AURA_REMOVED_DOSE"] = true,
						["SPELL_DISPEL"] = true,
						["SPELL_STOLEN"] = true,
						["ENCHANT_APPLIED"] = true,
						["ENCHANT_REMOVED"] = true,
						--["SPELL_PERIODIC_MISSED"] = true,
						--["SPELL_PERIODIC_DAMAGE"] = true,
						--["SPELL_PERIODIC_HEAL"] = true,
						--["SPELL_PERIODIC_ENERGIZE"] = true,
						--["SPELL_PERIODIC_DRAIN"] = true,
						--["SPELL_PERIODIC_LEECH"] = true,
						["SPELL_DISPEL_FAILED"] = true,
						--["DAMAGE_SHIELD"] = true,
						--["DAMAGE_SHIELD_MISSED"] = true,
						["DAMAGE_SPLIT"] = true,
						["PARTY_KILL"] = true,
						["UNIT_DIED"] = true,
						["UNIT_DESTROYED"] = true,
						["UNIT_DISSIPATES"] = true,
					  ["UNIT_LOYALTY"] = false
					};
					sourceFlags = nil;
					destFlags =  {
						[COMBATLOG_FILTER_MINE] = false,
						[COMBATLOG_FILTER_MY_PET] = false;
					};
				},				
			},
		},
		[3] = {
			custom = false,
			name = "What happend to me",
			hasQuickButton = true,
			quickButtonName = "What happend to me",
			quickButtonDisplay = {
				solo = true,
				party = true,
				raid = true,
			},
			tooltip = "What happend to me",
			settings = CopyTable(COMBATLOG_DEFAULT_SETTINGS),
			colors = CopyTable(COMBATLOG_DEFAULT_COLORS),
			filters = {
				[1] = {
					eventList = {
					      ["ENVIRONMENTAL_DAMAGE"] = true,
					      ["SWING_DAMAGE"] = true,
					      ["RANGE_DAMAGE"] = true,
					      ["SPELL_DAMAGE"] = true,
					      ["SPELL_HEAL"] = true,
					      ["SPELL_PERIODIC_DAMAGE"] = true,
					      ["SPELL_PERIODIC_HEAL"] = true,
					      ["DAMAGE_SPLIT"] = true,
					      ["UNIT_DIED"] = true,
					      ["UNIT_DESTROYED"] = true,
					      ["UNIT_DISSIPATES"] = true
					};
					sourceFlags = Blizzard_CombatLog_GenerateFullFlagList(false);
					destFlags = nil;
				};
				[2] = {
					eventList = Blizzard_CombatLog_GenerateFullEventList();
					sourceFlags = nil;
					destFlags =  {
						[COMBATLOG_FILTER_MINE] = true,
						[COMBATLOG_FILTER_MY_PET] = false;
					};
				};
			},
		},				
	}
end

---------------------------------------------------------------------------------------------------------------------------------------
local SkuChatEditboxHookFlag = false
function SkuChat:PLAYER_ENTERING_WORLD(...)
	local event, isInitialLogin, isReloadingUi = ...

	--init combat log stuff
	SkuOptions.db.profile["SkuChat"].CombatLog = SkuOptions.db.profile["SkuChat"].CombatLog or {
		enabled = false,
		currentFilter = 1,
	}

	-- we need to delay this to entering world because of global constants availablity
	CreateSkuDefaultFilters()

	if not SkuOptions.db.global["SkuChat"].CombatLogFilters[SkuOptions.db.profile["SkuChat"].CombatLog.currentFilter] then
		SkuOptions.db.profile["SkuChat"].CombatLog.currentFilter = 1
	end

	Blizzard_CombatLog_CurrentSettings = SkuOptions.db.global["SkuChat"].CombatLogFilters[SkuOptions.db.profile["SkuChat"].CombatLog.currentFilter]
	Blizzard_CombatLog_ApplyFilters(Blizzard_CombatLog_CurrentSettings)
	

	--init audio log stuff
	SkuOptions.db.profile["SkuChat"].AudioLog = SkuOptions.db.profile["SkuChat"].AudioLog or {
		enabled = false,
	}


	--remove aws polly dev voices on my system
	SkuChat.WowTtsVoices = {}
	for i, v in pairs(C_VoiceChat.GetTtsVoices()) do
		if not string.find(v.name, "Polly") then
			SkuChat.WowTtsVoices[i] = v.name
		end
	end
	SkuChat.options.args.WowTtsVoice.values = SkuChat.WowTtsVoices

	--create default tabs
	if not SkuOptions.db.profile["SkuChat"].tabs or #SkuOptions.db.profile["SkuChat"].tabs == 0 then
		SkuOptions.db.profile["SkuChat"].tabs = {}
		SkuChat:NewTab(L["Default"])
		SkuChat:NewTab(L["Communication"])
		SkuChat:NewTab(L["Other"])
	end

	--init filters
	if not SkuOptions.db.profile["SkuChat"].chatSettings.filter then
		SkuOptions.db.profile["SkuChat"].chatSettings.filter = {}
	end
	if not SkuOptions.db.profile["SkuChat"].chatSettings.filter.terms then
		SkuOptions.db.profile["SkuChat"].chatSettings.filter.terms = {}
	end

	--update types for existing tabs; just to add new types with new releases
	for tCatName, tData in pairs(SkuChat.ChatFrameMessageTypes) do
		for i, tTabData in pairs(SkuOptions.db.profile["SkuChat"].tabs) do
			tTabData.messageTypes[tCatName] = tTabData.messageTypes[tCatName] or {}
			if #tTabData.messageTypes[tCatName] ~= #tData then
				for x = 1, #tData do
					tTabData.messageTypes[tCatName][x] = tData[x].default
				end
			end
		end
	end

	for x = #SkuOptions.db.profile["SkuChat"].tabs, 1, -1  do
		if _G[SkuOptions.db.profile["SkuChat"].tabs[x].frameName] then
			_G[SkuOptions.db.profile["SkuChat"].tabs[x].frameName]:UnregisterAllEvents() 
		end
		if SkuOptions.db.profile["SkuChat"].tabs[x].privateMessages then
			table.remove(SkuOptions.db.profile["SkuChat"].tabs, x)
		end
	end

	for x = 1, #SkuOptions.db.profile["SkuChat"].tabs do
		SkuChat:InitTab(x)
		SkuOptions.db.profile["SkuChat"].tabs[x].historyCurrentLine = 1
	end

	SkuChat.currentTab = 1

	--add new - because we want them at the last position
	SkuChat:InitAudioLogTab()
	SkuChat:InitCombatLogTab()	

	
	--delete history of all tabs if required
	if SkuOptions.db.profile["SkuChat"].chatSettings.deleteHistoryOnLogin == true  and isInitialLogin == true then
		for x = 1, #SkuOptions.db.profile["SkuChat"].tabs do
			SkuOptions.db.profile["SkuChat"].tabs[x].history = {}
			table.insert(SkuOptions.db.profile["SkuChat"].tabs[x].history, 1, {
				body = L["Empty"], 
				messageTypeGroup = "SAY", 
				audio = false, 
				accessID = nil, 
				typeID = nil, 
				arg2 = nil, 
				time = time(),
			})					
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:SetEditboxToCustom(chatType, target, aMsg)
	SkuChatEditboxHookFlag = true
	if chatType == "CHANNEL" then
		local channelNum, channelName = GetChannelName(target)
		ChatFrame1EditBox:SetAttribute("channelTarget", channelNum)
		ChatFrame1EditBox:SetAttribute("chatType", "CHANNEL")
	elseif chatType == "WHISPER" then
		ChatFrame1EditBox:SetAttribute("tellTarget", target)
		ChatFrame1EditBox:SetAttribute("chatType", "WHISPER")
	elseif chatType == "BN_WHISPER" then
		ChatFrame1EditBox:SetAttribute("tellTarget", target)
		ChatFrame1EditBox:SetAttribute("chatType", "BN_WHISPER")
	else
		ChatFrame1EditBox:SetAttribute("chatType", chatType)
		ChatFrame1EditBox:SetAttribute("stickyType", chatType)
	end
	
	ChatEdit_UpdateHeader(ChatFrame1EditBox)
	ChatFrame1EditBox:Show()
	ChatFrame1EditBox:SetFocus() 
	if aMsg then
		ChatFrame1EditBox:SetText(aMsg)
	end

	SkuChatEditboxHookFlag = false
end

---------------------------------------------------------------------------------------------------------------------------------------
--event handler to add/remove channels from/to existing tabs on leave/join channels
function SkuChat:CHAT_MSG_CHANNEL_NOTICE(...)
	local tEvent, tAction, tPlayerName, tLangName, tChannelName, tPlayerName2, tSpecialFlags, tZoneChannelID, tChannelIndex, channelBaseName = ...
	local tInternalChannelName = channelBaseName

	if tZoneChannelID > 0 then
		local tShortNames = {
			[1] = "General",
			[2] = "Trade",
			[22] = "LocalDefense",
			[23] = "WorldDefense",
			[25] = "GuildRecruitment",
			[26] = "LookingForGroup",
		}
		tInternalChannelName = tShortNames[tZoneChannelID]
	end

	if tAction == "YOU_CHANGED" then
		for z = 1, #SkuOptions.db.profile["SkuChat"].tabs do
			local tExists
			for y = 1, #SkuOptions.db.profile["SkuChat"].tabs[1].channels do
				if string.lower(SkuOptions.db.profile["SkuChat"].tabs[1].channels[y].name) == string.lower(tInternalChannelName) then
					tExists = true
					break
				end
			end
			if not tExists then
				if z == 1 then
					local tStatus = true
					if string.lower(channelBaseName) == "skuchat" then
						tStatus = play
					end
					
					SkuOptions.db.profile["SkuChat"].tabs[1].channels[#SkuOptions.db.profile["SkuChat"].tabs[1].channels + 1] = {name = tInternalChannelName, status = tStatus}
				else
					SkuOptions.db.profile["SkuChat"].tabs[1].channels[#SkuOptions.db.profile["SkuChat"].tabs[1].channels + 1] = {name = tInternalChannelName, status = false}
				end
			end
		end
	elseif tAction == "YOU_LEFT" then
		C_Timer.After(0, function() --we need to delay this to the next frame, as we first need the message to be processed with the channel still active for the tab
			for x = 1, #SkuOptions.db.profile["SkuChat"].tabs do
				for y = 1, #SkuOptions.db.profile["SkuChat"].tabs[x].channels do
					if string.lower(SkuOptions.db.profile["SkuChat"].tabs[x].channels[y].name) == string.lower(tInternalChannelName) then
						table.remove(SkuOptions.db.profile["SkuChat"].tabs[x].channels, y)
						break
					end
				end
			end
		end)
	end

	for x = 1, #SkuOptions.db.profile["SkuChat"].tabs do
		if SkuOptions.db.profile["SkuChat"].tabs[x].frameName and _G[SkuOptions.db.profile["SkuChat"].tabs[x].frameName] then
			_G[SkuOptions.db.profile["SkuChat"].tabs[x].frameName]:UnregisterAllEvents() 
		end
		SkuOptions.db.profile["SkuChat"].tabs[x].frameName = "SkuChatChatFrame"..x
		SkuChat:InitTab(x)	
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:ResetTab(aIndex)
	--print("ResetTab", aIndex)
	--set default message groups
	if not SkuOptions.db.profile["SkuChat"].tabs[aIndex] then
		return
	end

	-- set default message types
	local tTab = SkuOptions.db.profile["SkuChat"].tabs[aIndex]
	for tCatName, tData in pairs(SkuChat.ChatFrameMessageTypes) do
		for x = 1, #tData do
			if SkuChat.ChatFrameDefaultTabs[tTab.name] and SkuChat.ChatFrameDefaultTabs[tTab.name][tCatName] then
				tTab.messageTypes[tCatName][x] = SkuChat.ChatFrameDefaultTabs[tTab.name][tCatName][x].default
			else
				tTab.messageTypes[tCatName][x] = tData[x].default
			end
		end
	end

	--set default channels
	if tTab.name == L["Default"] then
		tTab.channels = {
			[1] = {name = "General", status = true},
			[2] = {name = "Trade", status = true},
			[3] = {name = "LocalDefense", status = true},
			[4] = {name = "WorldDefense", status = true},
			[5] = {name = "GuildRecruitment", status = true},
			[6] = {name = "LookingForGroup", status = true},
			[7] = {name = "SkuChat", status = play},
		}
	else
		tTab.channels = {
			[1] = {name = "General", status = false},
			[2] = {name = "Trade", status = false},
			[3] = {name = "LocalDefense", status = false},
			[4] = {name = "WorldDefense", status = false},
			[5] = {name = "GuildRecruitment", status = false},
			[6] = {name = "LookingForGroup", status = false},
			[7] = {name = "SkuChat", status = false},
		}
	end

	--set custom channels
	local tChannelList = {GetChannelList()}
	for x = 1, C_ChatInfo.GetNumActiveChannels() * 3, 3 do 
		local tExists
		for y = 1, #tTab.channels do
			if tTab.channels[y].name == tChannelList[x + 1] then
				tExists = true
			end
		end
		if not tExists then
			if tTab.name == L["Default"] then
				tTab.channels[#tTab.channels + 1] = {name = tChannelList[x + 1], status = true}
			else
				tTab.channels[#tTab.channels + 1] = {name = tChannelList[x + 1], status = false}
			end
		end
	end

	tTab.privateMessages = nil
	tTab.excludePrivateMessages = nil

	
	tTab.history = tTab.history or {}
	table.insert(tTab.history, 1, {
		body = L["Empty"], 
		messageTypeGroup = "SAY", 
		audio = false, 
		accessID = nil, 
		typeID = nil, 
		arg2 = nil, 
		time = time(),
	})		
	

	return true
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:DeleteTab(aIndex)
	if SkuOptions.db.profile["SkuChat"].tabs[aIndex] then
		local tIsCurrent = SkuChat.currentTab == aIndex

		local tFrame = _G[SkuOptions.db.profile["SkuChat"].tabs[aIndex].frameName]
		tFrame:UnregisterAllEvents() 
		table.remove(SkuOptions.db.profile["SkuChat"].tabs, aIndex)

		for x = 1, #SkuOptions.db.profile["SkuChat"].tabs do
			_G[SkuOptions.db.profile["SkuChat"].tabs[x].frameName]:UnregisterAllEvents() 
			SkuOptions.db.profile["SkuChat"].tabs[x].frameName = "SkuChatChatFrame"..x
			SkuChat:InitTab(x)
		end

		if SkuChat.currentTab >= aIndex then
			SkuChat.currentTab = SkuChat.currentTab - 1
		end

		if SkuChat.ChatOpen == true and tIsCurrent == true then
			SkuChat:ReadLine(SkuChat.currentTab, SkuOptions.db.profile["SkuChat"].tabs[SkuChat.currentTab].historyCurrentLine, true)
		end

		return true
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:InitTab(tNewTabIndex)
	--print("InitTab")
	--build virtual chat frame that is registering chat events
	local a = _G[SkuOptions.db.profile["SkuChat"].tabs[tNewTabIndex].frameName] or CreateFrame("Button", SkuOptions.db.profile["SkuChat"].tabs[tNewTabIndex].frameName, UIParent, "SecureActionButtonTemplate")
	a.tab = SkuOptions.db.profile["SkuChat"].tabs[tNewTabIndex]
	a.name = SkuOptions.db.profile["SkuChat"].tabs[tNewTabIndex].name
	a:SetScript("OnEvent", function(self, aEvent, ...)
		SkuChat_OnEvent(self, aEvent, ...)
	end)

	--join private messages
	SkuChat_RemoveAllPrivateMessageTargets(a)
	if SkuOptions.db.profile["SkuChat"].tabs[tNewTabIndex].privateMessages then
		for i, v in pairs(SkuOptions.db.profile["SkuChat"].tabs[tNewTabIndex].privateMessages) do
			--a.privateMessageList = nil--a.privateMessageList or {}
			SkuChat_AddPrivateMessageTarget(a, v)
		end
	end

	--exclude private messages
	--SkuChat_ReceiveAllPrivateMessages(a)
	a.excludePrivateMessageList = nil
	if SkuOptions.db.profile["SkuChat"].tabs[tNewTabIndex].excludePrivateMessages then
		for i, v in pairs(SkuOptions.db.profile["SkuChat"].tabs[tNewTabIndex].excludePrivateMessages) do
			a.excludePrivateMessageList = a.excludePrivateMessageList or {}
			SkuChat_ExcludePrivateMessageTarget(a, v)
		end
	end

	--join channels
	a.channelList = {}
	a.zoneChannelList = {}
	SkuChat_RemoveAllChannels(a)
	for i, v in pairs(SkuOptions.db.profile["SkuChat"].tabs[tNewTabIndex].channels) do
		if v.status ~= false then
			if SkuChat_ContainsChannel(a, v.name) ~= true then
				SkuChat_AddChannel(a, v.name)
			end
		end
	end

	--register message types
	a.messageTypeList = {}
	SkuChat_RemoveAllMessageGroups(a)
	for tCName, tData in pairs(SkuOptions.db.profile["SkuChat"].tabs[tNewTabIndex].messageTypes) do
		for x = 1, #tData do
			if tData[x] ~= false or (tCName == "CREATURE_MESSAGES" and x == 4) then
				if SkuChatChatTypeGroup[SkuChat.ChatFrameMessageTypes[tCName][x].type] then
					SkuChat_AddMessageGroup(a, SkuChat.ChatFrameMessageTypes[tCName][x].type)
				else
					SkuChat_AddSingleMessageType(a, SkuChat.ChatFrameMessageTypes[tCName][x].type)
				end

			end
		end
	end

	--AddMessage handler
	function a:AddMessage(messageTypeGroup, body, r, g, b, id, accessID, typeID, arg2)
		
		if messageTypeGroup ~= "ADDON" then
			--print(messageTypeGroup, body, r, g, b, id, accessID, typeID, arg2)
		end
		
		local tLink = string.match(body, "|Hitem:(.+)|h%[")
		if tLink then
			tLink = "item:"..tLink
		end

		local tItemLinks = {}
		for i in string.gmatch(body, "|Hitem:([^Hitem]+)|h%[") do
			tItemLinks[#tItemLinks + 1] = "item:"..i
			dprint(string.gsub(i, "|", "!"))
		end
		
		if not body then
			return
		end
		
		if body == "" or body == " " then
			return
		end



		--mask bnet names
		local tNewBody
		body = MaskBattleNetNames(body)

		--get output type
		local tAudio
		for i, v in pairs(SkuChat.ChatFrameMessageTypes) do
			for w = 1, #v do
				if v[w].type == messageTypeGroup then
					tAudio = a.tab.messageTypes[i][w]
				end
			end
		end
		if not tAudio then
			for x = 1, #a.tab.channels do
				if a.tab.channels[x].name == messageTypeGroup then
					tAudio = a.tab.channels[x].status
				end
			end
		end

		if string.find(body, "Debug:") then
			tAudio = false
		end

		--process
		if tAudio ~= false then
			--remove old if > max
			if #a.tab.history + 1 > a.tab.historyMax then 
				for x = a.tab.historyMax, #a.tab.history do
					table.remove(a.tab.history, #a.tab.history)
				end
			end

			--remove empty if this is the first line for the history
			if a.tab.history[1] then
				if a.tab.history[1].body == L["Empty"] then
					a.tab.history = {}
				end
			end

			local tFlatBody = string.gsub(SkuChat:Unescape(body), "|", "")
			tFlatBody = SkuChat:ShortenChannelName(tFlatBody)

			--audio output
			if tAudio == play then
				SkuOptions.Voice:OutputStringBTtts(tFlatBody, false, true, 0.2, nil, nil, nil, 2)
			end

			if a.tab.audioOnNewMessage then
				if SkuCore.inCombat == true then
					SkuChatNewLineInCombat = true
				else
					if SkuOptions.db.profile["SkuChat"].tabs[tNewTabIndex].audioOnNewMessage ~= "sound-silence0.1" then
						SkuOptions.Voice:OutputString(SkuOptions.db.profile["SkuChat"].tabs[tNewTabIndex].audioOnNewMessage, false, true, 0.1)
					end
				end
			end

			--add to history
			table.insert(a.tab.history, 1, {
				body = tFlatBody,
				link = tLink,
				itemLinks = tItemLinks,
				messageTypeGroup = messageTypeGroup, 
				audio = tAudio, 
				accessID = accessID, 
				typeID = typeID, 
				arg2 = arg2, 
				time = time(),
			})

			--change the current line if the chat is open
			if SkuChat.ChatOpen == true then
				if a.tab.historyCurrentLine < #a.tab.history then
					if _G["OnSkuChatToggle"].menuOpen ~= true then
						a.tab.historyCurrentLine = a.tab.historyCurrentLine + 1
					end
				end
			end

			--update activity timestamp for auto deleting the tab
			a.tab.lastActivityAt = time()
		end
	end

	SkuChat:RegisterChatFrame(tNewTabIndex)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:NewTab(aName)
	if #SkuOptions.db.profile["SkuChat"].tabs < SkuChat.maxTabs then
		local tNewTabIndex = #SkuOptions.db.profile["SkuChat"].tabs + 1

		SkuOptions.db.profile["SkuChat"].tabs[tNewTabIndex] = {
			name = aName or L["Default Tab"],
			frameName = "SkuChatChatFrame"..tNewTabIndex,
			enabled = true,
			messageTypes = {
				PLAYER_MESSAGES = {},
				CREATURE_MESSAGES = {},
				OTHER = {},
				PVP = {},
				SYSTEM = {},
				COMBAT = {},
				SKU = {},
			},
			channels = {},
			privateMessages = {},
			excludePrivateMessages = {},
			history = {},
			historyCurrentLine = 1,
			historyMax = SkuChat.defaultHistoryMax,
			audioOnNewMessage = "sound-newChatLine",--SkuOptions.db.profile[MODULE_NAME].chatSettings.audioOnNewMessage,
			createdAt = time(),
			lastActivityAt = time(),
		}

		SkuChat:ResetTab(tNewTabIndex)

		--re-initialise all tabs, just in case
		for x = 1, #SkuOptions.db.profile["SkuChat"].tabs do
			if _G[SkuOptions.db.profile["SkuChat"].tabs[x].frameName] then
				_G[SkuOptions.db.profile["SkuChat"].tabs[x].frameName]:UnregisterAllEvents() 
			end
			SkuOptions.db.profile["SkuChat"].tabs[x].frameName = "SkuChatChatFrame"..x
			SkuChat:InitTab(x)
		end

		return tNewTabIndex
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuChat:RegisterChatFrame(aFrameIndex)
	local tFrameList = {}

	for x = 1, #SkuOptions.db.profile["SkuChat"].tabs do
		table.insert(tFrameList, x)
	end
	if aFrameIndex then
		tFrameList = {}
		table.insert(tFrameList, aFrameIndex)
	end

	for _, tFrameIndex in pairs(tFrameList) do
		SkuChat_OnLoad(_G[SkuOptions.db.profile["SkuChat"].tabs[tFrameIndex].frameName])
		SkuChat_ConfigEventHandler(_G[SkuOptions.db.profile["SkuChat"].tabs[tFrameIndex].frameName], "UPDATE_CHAT_WINDOWS")
	end
end
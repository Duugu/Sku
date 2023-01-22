local MODULE_NAME, MODULE_PART = "SkuCore", "itemRating"
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

local tItemStatNameToRatingValue = {
	["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] = "Dps",
	["ITEM_MOD_MANA_SHORT"] = "Mana",
	["ITEM_MOD_HEALTH_SHORT"] = "Health",
	["ITEM_MOD_AGILITY_SHORT"] = "Agility",
	["ITEM_MOD_STRENGTH_SHORT"] = "Strength",
	["ITEM_MOD_INTELLECT_SHORT"] = "Intellect",
	["ITEM_MOD_SPIRIT_SHORT"] = "Spirit",
	["ITEM_MOD_STAMINA_SHORT"] = "Stamina",
	["ITEM_MOD_DEFENSE_SKILL_RATING_SHORT"] = "DefenseRating",
	["ITEM_MOD_DODGE_RATING_SHORT"] = "DodgeRating",
	["ITEM_MOD_PARRY_RATING_SHORT"] = "ParryRating",
	["ITEM_MOD_BLOCK_RATING_SHORT"] = "BlockRating",
		["ITEM_MOD_MELEE_ATTACK_POWER_SHORT"] = "Ap",
	["ITEM_MOD_HIT_MELEE_RATING_SHORT"] = "HitRating",
	["ITEM_MOD_HIT_RANGED_RATING_SHORT"] = "HitRating",
	["ITEM_MOD_HIT_SPELL_RATING_SHORT"] = "SpellHitRating",
	["ITEM_MOD_CRIT_MELEE_RATING_SHORT"] = "CritRating",
	["ITEM_MOD_CRIT_RANGED_RATING_SHORT"] = "CritRating",
	["ITEM_MOD_CRIT_SPELL_RATING_SHORT"] = "SpellCritRating",
	["ITEM_MOD_HASTE_MELEE_RATING_SHORT"] = "HasteRating",
	["ITEM_MOD_HASTE_RANGED_RATING_SHORT"] = "HasteRating",
	["ITEM_MOD_HASTE_SPELL_RATING_SHORT"] = "SpellHasteRating",
	["ITEM_MOD_HIT_RATING_SHORT"] = "HitRating",
	["ITEM_MOD_CRIT_RATING_SHORT"] = "CritRating",
	["ITEM_MOD_RESILIENCE_RATING_SHORT"] = "ResilienceRating",
	["ITEM_MOD_HASTE_RATING_SHORT"] = "HasteRating",
	["ITEM_MOD_EXPERTISE_RATING_SHORT"] = "ExpertiseRating",
	["ITEM_MOD_ATTACK_POWER_SHORT"] = "Ap",
	["ITEM_MOD_RANGED_ATTACK_POWER_SHORT"] = "Rap",
	--["ITEM_MOD_VERSATILITY"] = "",
	["ITEM_MOD_SPELL_HEALING_DONE_SHORT"] = "Healing",
	["ITEM_MOD_SPELL_DAMAGE_DONE_SHORT"] = "SpellDamage",
	["ITEM_MOD_MANA_REGENERATION_SHORT"] = "Mp5",
	["ITEM_MOD_POWER_REGEN0_SHORT"] = "Mp5",
	["ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT"] = "ArmorPenetration",
	["ITEM_MOD_SPELL_POWER_SHORT"] = "SpellPower",
	["ITEM_MOD_HEALTH_REGEN_SHORT"] = "Hp5",
	["ITEM_MOD_SPELL_PENETRATION_SHORT"] = "SpellPenetration",
	["ITEM_MOD_BLOCK_VALUE_SHORT"] = "BlockValue",
	--["ITEM_MOD_MASTERY_RATING_SHORT"] = "",
	["ITEM_MOD_ARMOR_SHORT"] = "Armor",
	["ITEM_MOD_EXTRA_ARMOR_SHORT"] = "Armor",
	["ITEM_MOD_FIRE_RESISTANCE_SHORT"] = "FireResist",
	["ITEM_MOD_FROST_RESISTANCE_SHORT"] = "FrostResist",
	--["ITEM_MOD_HOLY_RESISTANCE_SHORT"] = "",
	["ITEM_MOD_SHADOW_RESISTANCE_SHORT"] = "ShadowResist",
	["ITEM_MOD_NATURE_RESISTANCE_SHORT"] = "NatureResist",
	["ITEM_MOD_ARCANE_RESISTANCE_SHORT"] = "ArcaneResist",
	--[[ 
	["ITEM_MOD_CR_AMPLIFY_SHORT"] = "",
	["ITEM_MOD_CR_MULTISTRIKE_SHORT"] = "",
	["ITEM_MOD_CR_READINESS_SHORT"] = "",
	["ITEM_MOD_CR_SPEED_SHORT"] = "",
	["ITEM_MOD_CR_LIFESTEAL_SHORT"] = "",
	["ITEM_MOD_CR_AVOIDANCE_SHORT"] = "",
	["ITEM_MOD_CR_STURDINESS_SHORT"] = "",
	["ITEM_MOD_CR_UNUSED_7_SHORT"] = "",
	["ITEM_MOD_CR_CLEAVE_SHORT"] = "",
	["ITEM_MOD_CR_UNUSED_9_SHORT"] = "",
	["ITEM_MOD_CR_UNUSED_10_SHORT"] = "",
	["ITEM_MOD_CR_UNUSED_11_SHORT"] = "",
	["ITEM_MOD_CR_UNUSED_12_SHORT"] = "",
	ITEM_MOD_POWER_REGEN0_SHORT = "Mana Per 5 Sec.";
	ITEM_MOD_POWER_REGEN1_SHORT = "Rage Per 5 Sec.";
	ITEM_MOD_POWER_REGEN2_SHORT = "Focus Per 5 Sec.";
	ITEM_MOD_POWER_REGEN3_SHORT = "Energy Per 5 Sec.";
	ITEM_MOD_POWER_REGEN4_SHORT = "Happiness Per 5 Sec.";
	ITEM_MOD_POWER_REGEN5_SHORT = "Runes Per 5 Sec.";
	ITEM_MOD_POWER_REGEN6_SHORT = "Runic Power Per 5 Sec.";	
	]]
}

local tStatRatings = {}

SkuCore.Specs = {
	[11] = {"Druid", locName = L["Druide"], specs = {
			[1] = {"Balance", locName = L["Gleichgewicht"]},
			[2] = {"Feral (Damage)", locName = L["Katze"]},
			[3] = {"Feral (Tank)", locName = L["Bär"]},
			[4] = {"Restoration", locName = L["Wiederherstellung"]},
		},
	},
	[3] = {"Hunter", locName = L["Jäger"], specs = {
			[1] = {"Beast Mastery", locName = L["Tierherrschaft"]},
			[2] = {"Marksmanship", locName = L["Treffsicherheit"]},
			[3] = {"Survival", locName = L["Überleben"]},
		},
	},
	[8] = {"Mage", locName = L["Magie"], specs = {
			[1] = {"Arcane", locName = L["Arkan"]},
			[2] = {"Fire", locName = L["Feuer"]},
			[3] = {"Frost", locName = L["Frost"]},
		},
	},
	[2] = {"Paladin", locName = L["Paladin"], specs = {
			[1] = {"Holy", locName = L["Heilig"]},
			[2] = {"Protection", locName = L["Schutz"]},
			[3] = {"Retribution", locName = L["Vergeltung"]},
		},
	},
	[5] = {"Priest", locName = L["Priester"], specs = {
			[1] = {"Discipline", locName = L["Disziplin"]},
			[2] = {"Holy", locName = L["Heilig"]},
			[3] = {"Shadow", locName = L["Schatten"]},
		},
	},
	[4] = {"Rogue", locName = L["Schuke"], specs = {
			[1] = {"Assassination", locName = L["Meucheln"]},
			[2] = {"Combat", locName = L["Kampf"]},
			[3] = {"Subtlety", locName = L["Täuschung"]},
		},
	},
	[7] = {"Shaman", locName = L["Schamane"], specs = {
			[1] = {"Elemental", locName = L["Elementar"]},
			[2] = {"Enhancement", locName = L["Verstärkung"]},
			[3] = {"Restoration", locName = L["Wiederherstellung"]},
		},
	},
	[9] = {"Warlock", locName = L["Hexer"], specs = {
			[1] = {"Affliction", locName = L["Gebrechen"]},
			[2] = {"Demonology", locName = L["Dämonologie"]},
			[3] = {"Destruction", locName = L["Zerstörung"]},
		},
	},
	[1] = {"Warrior", locName = L["Krieger"], specs = {
			[1] = {"Arms", locName = L["Waffen"]},
			[2] = {"Fury", locName = L["Furor"]},
			[3] = {"Protection", locName = L["Schutz"]},
		},
	},
	[6] = {"Death Knight", locName = L["Death Knight"], specs = {
			[1] = {"Blood", locName = L["Blood"]},
			[2] = {"Frost (tank)", locName = L["Frost (tank)"]},
			[3] = {"Unholy", locName = L["Unholy"]},
		},
	},
}

----------------------------------------------------------------------------------------------------------------------------------------
local function IsRedColor(r, g, b, a)
	return math.ceil(r*255) == 255 and math.ceil(g*255) == 32 and math.ceil(b*255) == 32
end

----------------------------------------------------------------------------------------------------------------------------------------
local function ScanTooltipRegions(regions)
	for _, region in ipairs(regions) do
		if region and region:GetObjectType() == "FontString" and
			region:GetText() and IsRedColor(region:GetTextColor()) then
			return true
		end
	end
	return false
end

----------------------------------------------------------------------------------------------------------------------------------------
local function ScanTooltipForUsable(tooltip, aItemId)
	tooltip:SetItemByID(aItemId)
	return ScanTooltipRegions({tooltip:GetRegions()})
end

---------------------------------------------------------------------------------------------------------------------------------------
local function GetArmorFromTooltip(aItemLink)

	local tTooltipFrame = _G["SkuRatingTooltip"] or CreateFrame("GameTooltip", "SkuRatingTooltip"); -- Tooltip name cannot be nil
	SkuRatingTooltip = tTooltipFrame
	tTooltipFrame:ClearLines()
	tTooltipFrame:SetOwner(WorldFrame, "ANCHOR_NONE")
	tTooltipFrame:SetHyperlink(aItemLink)
	tTooltipFrame:Show()

	for x = 1, tTooltipFrame:NumLines() do 
		local tText = _G[tTooltipFrame:GetName().."TextLeft"..x]:GetText()
		if tText then
			local tPattern = string.gsub(ARMOR_TEMPLATE, "%%s", "(%%d+)") 
			local tArmor = string.match(tText, tPattern)
			if tArmor then
				tTooltipFrame:Hide()
				return tArmor
			end
		end
	end
	
	tTooltipFrame:Hide()
end

----------------------------------------------------------------------------------------------------------------------------------------
local GetItemStatsHook
local function GetItemStatsHelperHook(aItemLink, aStatsTable)
	if aStatsTable then
		aStatsTable["ITEM_MOD_ARMOR_SHORT"] = GetArmorFromTooltip(aItemLink)
	end
	return GetItemStatsHook(aItemLink, aStatsTable)
end

----------------------------------------------------------------------------------------------------------------------------------------
local getItemInventoryTypeToInvSlotId = {
	[1] = 1,
	[2] = 2,
	[3] = 3,
	[4] = 4,
	[5] = 5,
	[6] = 6,
	[7] = 7,
	[8] = 8,
	[9] = 9,
	[10] = 10,
	[11] = 11,
	[12] = 13,
	[13] = 16,
	[14] = 17,
	[15] = 16,
	[16] = 15,
	[17] = 16,
	[19] = 19,
	[20] = 5,
	[21] = 16,
	[22] = 16,
	[23] = 17,
	[25] = 16,
	[26] = 16,
}
function SkuCore:ItemRatingGetRating(aItemIdItemToRate)
	if not aItemIdItemToRate then return "" end

	local f = _G["SkuRatingTooltip"] or CreateFrame("GameTooltip", "SkuRatingTooltip"); -- Tooltip name cannot be nil
	SkuRatingTooltip = f
	f:SetOwner(WorldFrame, "ANCHOR_NONE");
	SkuRatingTooltip:SetItemByID(aItemIdItemToRate) 

	local tInvTypeOfNewItem = C_Item.GetItemInventoryTypeByID(aItemIdItemToRate)
	if not tInvTypeOfNewItem then return "" end

	tInvTypeOfNewItem = getItemInventoryTypeToInvSlotId[tInvTypeOfNewItem]
	if not tInvTypeOfNewItem then return "" end

	local tCurrentEqItemId = GetInventoryItemID("player", tInvTypeOfNewItem)
	if not tCurrentEqItemId then return "" end

	if not IsEquippableItem(aItemIdItemToRate) then return "" end

	if ScanTooltipForUsable(SkuRatingTooltip, aItemIdItemToRate) ~= false then return "" end

	--[[GetItemStatDelta("item:"..tCurrentEqItemId,"item:"..aItemIdItemToRate, stats)]]
	local tResultsString = L["Wertung:"]

	local _, _, ClassID = UnitClass("player")

	if tStatRatings[ClassID] and tStatRatings[ClassID][1] then
		-- new item
		local tNewItemRatings = {}
		local stats = {}
		GetItemStats("item:"..aItemIdItemToRate, stats)
		setmetatable(stats, SkuPrintMT)
		for SpecID = 1, 4 do
			if tStatRatings[ClassID][SpecID] then
				local tResult = 0
				for bName, value in pairs(stats) do
					local pname = tItemStatNameToRatingValue[bName] or tItemStatNameToRatingValue[bName.."_SHORT"]
					if pname then
						tResult = tResult + value * tStatRatings[ClassID][SpecID][pname]
					end
					tNewItemRatings[SpecID] = tResult
				end
			end
		end

		-- old item
		local tCurrentItemRatings = {}
		local stats = {}
		GetItemStats("item:"..tCurrentEqItemId, stats)
		for SpecID = 1, 4 do
			if tStatRatings[ClassID][SpecID] then
				local tResult = 0
				for bName, value in pairs(stats) do
					local pname = tItemStatNameToRatingValue[bName] or tItemStatNameToRatingValue[bName.."_SHORT"]
					if pname then
						tResult = tResult + value * tStatRatings[ClassID][SpecID][pname]
					end
					tCurrentItemRatings[SpecID] = tResult
				end
			end
		end

		--create rating
		for i, v in pairs(tCurrentItemRatings) do
			local tMod = L["Keine Bewertung möglich"]
			if tNewItemRatings[i] then
				local tDiff
				if v == 0 then
					tDiff = math.floor(((tNewItemRatings[i]) * 100) - 100)
				else
					tDiff = math.floor(((tNewItemRatings[i] / v) * 100) - 100)
				end
				tMod = L["plus "]..tDiff.."%"
				if tDiff < 0 then
					tDiff = tDiff * -1
					tMod = L["minus "]..tDiff.."%"
				elseif tDiff == 0 then
					tMod = L["Keine Veränderung"]
				end
			else
				tMod = L["Keine Bewertung für neuen Gegenstand möglich"]
			end
			tResultsString = tResultsString.."\r\n"..SkuCore.Specs[ClassID].specs[i].locName.." "..tMod
		end
	end

	if tResultsString == L["Wertung:"] then
		tResultsString = tResultsString.."\r\n"..L["Keine Bewertung für angelegter Gegenstand möglich"]
	end

	return tResultsString
end

---------------------------------------------------------------------------------------------------------------------------------------
local function AddTemplate(ProviderInternalName, ClassID, SpecID, Stats)
	if SpecID and Stats then
		tStatRatings[ClassID] = tStatRatings[ClassID] or {}
		tStatRatings[ClassID][SpecID] = Stats
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
local HitRatingPer, SpellHitRatingPer, CritRatingPer, SpellCritRatingPer, HasteRatingPer, SpellHasteRatingPer, ExpertiseRatingPer, ArmorPenetrationPer, SpellPenetrationPer, DefenseRatingPer, DodgeRatingPer, ParryRatingPer, BlockRatingPer
HitRatingPer = 1
SpellHitRatingPer = 1
CritRatingPer = 1
SpellCritRatingPer = 1
HasteRatingPer = 1
SpellHasteRatingPer = 1
ExpertiseRatingPer = 1
ArmorPenetrationPer = 1
SpellPenetrationPer = 1
DefenseRatingPer = 1
DodgeRatingPer = 1
ParryRatingPer = 1
BlockRatingPer = 1
local function ItemRatingAddScales()
	--[[
	AddTemplate(
		ScaleProviderName,
		11, -- Druid
		1, -- Balance
		{ Strength=0, Agility=0.05, Dps=0, MeleeDps=0, RangedDps=0, Ap=0, Rap=0, FeralAp=0, HitRating=HitRatingPer*0, ExpertiseRating=ExpertiseRatingPer*0, CritRating=CritRatingPer*0, HasteRating=HasteRatingPer*0, ArmorPenetration=ArmorPenetrationPer*0,
		Intellect=0.38, Mana=0.032, Spirit=0.34, Mp5=0.58, Healing=0, SpellDamage=1, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0.64, ShadowSpellDamage=0, NatureSpellDamage=0.43, HolySpellDamage=0, SpellPower=0, SpellHitRating=SpellHitRatingPer*1.21, SpellCritRating=SpellCritRatingPer*0.62, SpellHasteRating=0.8, SpellPenetration=SpellPenetrationPer*0.21,
		Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005, DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05, ParryRating=ParryRatingPer*0.05, BlockRating=BlockRatingPer*0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04, MetaSocketEffect=36, }
	)

	AddTemplate(
		ScaleProviderName,
		11, -- Druid
		2, -- Feral (Damage)
		{ Strength=1.48, Agility=1, Dps=0, MeleeDps=0, RangedDps=0, Ap=0.59, Rap=0, FeralAp=0.59, HitRating=HitRatingPer*0.61, ExpertiseRating=ExpertiseRatingPer*0.61, CritRating=CritRatingPer*0.59, HasteRating=HasteRatingPer*0.43, ArmorPenetration=ArmorPenetrationPer*0.4,
		Intellect=0.1, Mana=0.009, Spirit=0.05, Mp5=0.3, Healing=0.025, SpellDamage=0, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellHitRating=SpellHitRatingPer*0, SpellCritRating=SpellCritRatingPer*0, SpellHasteRating=0, SpellPenetration=SpellPenetrationPer*0,
		Stamina=0.1, Health=0.01, Hp5=1, Armor=0.02, DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05, ParryRating=ParryRatingPer*0.05, BlockRating=BlockRatingPer*0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04, MetaSocketEffect=36, }
	)
		
	AddTemplate(
		ScaleProviderName,
		11, -- Druid
		3, -- Feral (Tank)
		{ Strength=0.2, Agility=0.48, Dps=0, MeleeDps=0, RangedDps=0, Ap=0.34, Rap=0, FeralAp=0.34, HitRating=HitRatingPer*0.16, ExpertiseRating=ExpertiseRatingPer*0.18, CritRating=CritRatingPer*0.15, HasteRating=HasteRatingPer*0.31, ArmorPenetration=ArmorPenetrationPer*0.2,
		Intellect=0.1, Mana=0.009, Spirit=0.05, Mp5=0.3, Healing=0.025, SpellDamage=0, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0.025, HolySpellDamage=0, SpellPower=0, SpellHitRating=SpellHitRatingPer*0, SpellCritRating=SpellCritRatingPer*0, SpellHasteRating=0, SpellPenetration=SpellPenetrationPer*0,
		Stamina=1, Health=0.08, Hp5=2, Armor=0.1, DefenseRating=DefenseRatingPer*0.26, DodgeRating=DodgeRatingPer*0.38, ParryRating=ParryRatingPer*0, BlockRating=BlockRatingPer*0, BlockValue=0, ResilienceRating=0.2, AllResist=1, FireResist=0.2, FrostResist=0.2, ArcaneResist=0.2, ShadowResist=0.2, NatureResist=0.2, MetaSocketEffect=36, }
	)

	AddTemplate(
		ScaleProviderName,
		11, -- Druid
		4, -- Restoration
		{ Strength=0, Agility=0.05, Dps=0, MeleeDps=0, RangedDps=0, Ap=0, Rap=0, FeralAp=0, HitRating=HitRatingPer*0, ExpertiseRating=ExpertiseRatingPer*0, CritRating=CritRatingPer*0, HasteRating=HasteRatingPer*0, ArmorPenetration=ArmorPenetrationPer*0,
		Intellect=1, Mana=0.09, Spirit=0.87, Mp5=1.7, Healing=1.21, SpellDamage=0, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellHitRating=SpellHitRatingPer*0, SpellCritRating=SpellCritRatingPer*0.35, SpellHasteRating=0.49, SpellPenetration=SpellPenetrationPer*0,
		Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005, DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05, ParryRating=ParryRatingPer*0.05, BlockRating=BlockRatingPer*0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04, MetaSocketEffect=36, }
	)

	AddTemplate(
		ScaleProviderName,
		3, -- Hunter
		1, -- Beast Mastery
		{ Strength=0.05, Agility=1, Dps=0, MeleeDps=0.75, RangedDps=2.4, Ap=0.43, Rap=0.43, FeralAp=0, HitRating=HitRatingPer*1, ExpertiseRating=ExpertiseRatingPer*0.05, CritRating=CritRatingPer*0.8, HasteRating=HasteRatingPer*0.5, ArmorPenetration=ArmorPenetrationPer*0.17,
		Intellect=0.8, Mana=0.075, Spirit=0.05, Mp5=2.4, Healing=0, SpellDamage=0, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellHitRating=SpellHitRatingPer*0, SpellCritRating=SpellCritRatingPer*0, SpellHasteRating=0, SpellPenetration=SpellPenetrationPer*0,
		Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005, DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05, ParryRating=ParryRatingPer*0.05, BlockRating=BlockRatingPer*0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04, MetaSocketEffect=36, }
	)

	AddTemplate(
		ScaleProviderName,
		3, -- Hunter
		2, -- Marksmanship
		{ Strength=0.05, Agility=1, Dps=0, MeleeDps=0.75, RangedDps=2.6, Ap=0.55, Rap=0.55, FeralAp=0, HitRating=HitRatingPer*1, ExpertiseRating=ExpertiseRatingPer*0.05, CritRating=CritRatingPer*0.6, HasteRating=HasteRatingPer*0.4, ArmorPenetration=ArmorPenetrationPer*0.37,
		Intellect=0.9, Mana=0.085, Spirit=0.05, Mp5=2.4, Healing=0, SpellDamage=0, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellHitRating=SpellHitRatingPer*0, SpellCritRating=SpellCritRatingPer*0, SpellHasteRating=0, SpellPenetration=SpellPenetrationPer*0,
		Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005, DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05, ParryRating=ParryRatingPer*0.05, BlockRating=BlockRatingPer*0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04, MetaSocketEffect=36, }
	)

	AddTemplate(
		ScaleProviderName,
		3, -- Hunter
		3, -- Survival
		{ Strength=0.05, Agility=1, Dps=0, MeleeDps=1, RangedDps=2.4, Ap=0.55, Rap=0.55, FeralAp=0, HitRating=HitRatingPer*1, ExpertiseRating=ExpertiseRatingPer*0.05, CritRating=CritRatingPer*0.65, HasteRating=HasteRatingPer*0.4, ArmorPenetration=ArmorPenetrationPer*0.28,
		Intellect=0.8, Mana=0.075, Spirit=0.05, Mp5=2.4, Healing=0, SpellDamage=0, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellHitRating=SpellHitRatingPer*0, SpellCritRating=SpellCritRatingPer*0, SpellHasteRating=0, SpellPenetration=SpellPenetrationPer*0,
		Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005, DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05, ParryRating=ParryRatingPer*0.05, BlockRating=BlockRatingPer*0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04, MetaSocketEffect=36, }
	)

	AddTemplate(
		ScaleProviderName,
		8, -- Mage
		1, -- Arcane
		{ Strength=0, Agility=0.05, Dps=0, MeleeDps=0, RangedDps=0, Ap=0, Rap=0, FeralAp=0, HitRating=HitRatingPer*0, ExpertiseRating=ExpertiseRatingPer*0, CritRating=CritRatingPer*0, HasteRating=HasteRatingPer*0, ArmorPenetration=ArmorPenetrationPer*0,
		Intellect=0.46, Mana=0.038, Spirit=0.59, Mp5=1.13, Healing=0, SpellDamage=1, FireSpellDamage=0.064, FrostSpellDamage=0.52, ArcaneSpellDamage=0.88, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellHitRating=SpellHitRatingPer*0.87, SpellCritRating=SpellCritRatingPer*0.6, SpellHasteRating=0.59, SpellPenetration=SpellPenetrationPer*0.09,
		Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005, DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05, ParryRating=ParryRatingPer*0.05, BlockRating=BlockRatingPer*0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04, MetaSocketEffect=36, }
	)

	AddTemplate(
		ScaleProviderName,
		8, -- Mage
		2, -- Fire
		{ Strength=0, Agility=0.05, Dps=0, MeleeDps=0, RangedDps=0, Ap=0, Rap=0, FeralAp=0, HitRating=HitRatingPer*0, ExpertiseRating=ExpertiseRatingPer*0, CritRating=CritRatingPer*0, HasteRating=HasteRatingPer*0, ArmorPenetration=ArmorPenetrationPer*0, 
		Intellect=0.44, Mana=0.036, Spirit=0.066, Mp5=0.9, Healing=0, SpellDamage=1, FireSpellDamage=0.94, FrostSpellDamage=0.32, ArcaneSpellDamage=0.168, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellHitRating=SpellHitRatingPer*0.93, SpellCritRating=SpellCritRatingPer*0.77, SpellHasteRating=0.82, SpellPenetration=SpellPenetrationPer*0.09,
		Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005, DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05, ParryRating=ParryRatingPer*0.05, BlockRating=BlockRatingPer*0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04, MetaSocketEffect=36, }
	)

	AddTemplate(
		ScaleProviderName,
		8, -- Mage
		3, -- Frost
		{ Strength=0, Agility=0.05, Dps=0, MeleeDps=0, RangedDps=0, Ap=0, Rap=0, FeralAp=0, HitRating=HitRatingPer*0, ExpertiseRating=ExpertiseRatingPer*0, CritRating=CritRatingPer*0, HasteRating=HasteRatingPer*0, ArmorPenetration=ArmorPenetrationPer*0,
		Intellect=0.37, Mana=0.032, Spirit=0.06, Mp5=0.8, Healing=0, SpellDamage=1, FireSpellDamage=0.05, FrostSpellDamage=0.95, ArcaneSpellDamage=0.13, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellHitRating=SpellHitRatingPer*1.22, SpellCritRating=SpellCritRatingPer*0.58, SpellHasteRating=0.63, SpellPenetration=SpellPenetrationPer*0.07,
		Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005, DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05, ParryRating=ParryRatingPer*0.05, BlockRating=BlockRatingPer*0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04, MetaSocketEffect=36, }
	)

	AddTemplate(
		ScaleProviderName,
		2, -- Paladin
		1, -- Holy
		{ Strength=0, Agility=0.05, Dps=0, MeleeDps=0, RangedDps=0, Ap=0, Rap=0, FeralAp=0, HitRating=HitRatingPer*0, ExpertiseRating=ExpertiseRatingPer*0, CritRating=CritRatingPer*0, HasteRating=HasteRatingPer*0, ArmorPenetration=ArmorPenetrationPer*0,
		Intellect=1, Mana=0.009, Spirit=0.28, Mp5=1.24, Healing=0.54, SpellDamage=0, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellHitRating=SpellHitRatingPer*0, SpellCritRating=SpellCritRatingPer*0.46, SpellHasteRating=0.39, SpellPenetration=SpellPenetrationPer*0,
		Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005, DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05, ParryRating=ParryRatingPer*0.05, BlockRating=BlockRatingPer*0.01, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04, MetaSocketEffect=36, }
	)

	AddTemplate(
		ScaleProviderName,
		2, -- Paladin
		2, -- Protection
		{ Strength=0.2, Agility=0.6, Dps=0, MeleeDps=1.77, RangedDps=0, Ap=0.06, Rap=0, FeralAp=0, HitRating=HitRatingPer*0.16, ExpertiseRating=ExpertiseRatingPer*0.27, CritRating=CritRatingPer*0.15, HasteRating=HasteRatingPer*0.5, ArmorPenetration=ArmorPenetrationPer*0.09,
		Intellect=0.5, Mana=0.045, Spirit=0.05, Mp5=1, Healing=0, SpellDamage=0.44, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0.44, SpellPower=0, SpellHitRating=SpellHitRatingPer*0.78, SpellCritRating=SpellCritRatingPer*0.6, SpellHasteRating=0.12, SpellPenetration=SpellPenetrationPer*0.03,
		Stamina=1, Health=0.09, Hp5=2, Armor=0.02, DefenseRating=DefenseRatingPer*0.7, DodgeRating=DodgeRatingPer*0.7, ParryRating=ParryRatingPer*0.6, BlockRating=BlockRatingPer*0.6, BlockValue=0.15, ResilienceRating=0.2, AllResist=1, FireResist=0.2, FrostResist=0.2, ArcaneResist=0.2, ShadowResist=0.2, NatureResist=0.2, MetaSocketEffect=36, }
	)

	AddTemplate(
		ScaleProviderName,
		2, -- Paladin
		3, -- Retribution
		{ Strength=1, Agility=0.64, Dps=0, MeleeDps=5.4, RangedDps=0, Ap=0.41, Rap=0, FeralAp=0, HitRating=HitRatingPer*0.84, ExpertiseRating=ExpertiseRatingPer*0.87, CritRating=CritRatingPer*0.66, HasteRating=HasteRatingPer*0.25, ArmorPenetration=ArmorPenetrationPer*0.09,
		Intellect=0.34, Mana=0.032, Spirit=0.05, Mp5=1, Healing=0, SpellDamage=0.33, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0.33, SpellPower=0, SpellHitRating=SpellHitRatingPer*0.21, SpellCritRating=SpellCritRatingPer*0.12, SpellHasteRating=0.04, SpellPenetration=SpellPenetrationPer*0.015,
		Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005, DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05, ParryRating=ParryRatingPer*0.05, BlockRating=BlockRatingPer*0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04, MetaSocketEffect=36, }
	)

	AddTemplate(
		ScaleProviderName,
		5, -- Priest
		1, -- Discipline
		{ Strength=0, Agility=0.05, Dps=0, MeleeDps=0, RangedDps=0, Ap=0, Rap=0, FeralAp=0, HitRating=HitRatingPer*0, ExpertiseRating=ExpertiseRatingPer*0, CritRating=CritRatingPer*0, HasteRating=HasteRatingPer*0, ArmorPenetration=ArmorPenetrationPer*0,
		Intellect=1, Mana=0.09, Spirit=0.48, Mp5=1.19, Healing=0.72, SpellDamage=0, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellHitRating=SpellHitRatingPer*0, SpellCritRating=SpellCritRatingPer*0.32, SpellHasteRating=0.57, SpellPenetration=SpellPenetrationPer*0,
		Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005, DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05, ParryRating=ParryRatingPer*0.05, BlockRating=BlockRatingPer*0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04, MetaSocketEffect=36, }
	)

	AddTemplate(
		ScaleProviderName,
		5, -- Priest
		2, -- Holy
		{ Strength=0, Agility=0.05, Dps=0, MeleeDps=0, RangedDps=0, Ap=0, Rap=0, FeralAp=0, HitRating=HitRatingPer*0, ExpertiseRating=ExpertiseRatingPer*0, CritRating=CritRatingPer*0, HasteRating=HasteRatingPer*0, ArmorPenetration=ArmorPenetrationPer*0,
		Intellect=1, Mana=0.09, Spirit=0.73, Mp5=1.35, Healing=0.81, SpellDamage=0, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellHitRating=SpellHitRatingPer*0, SpellCritRating=SpellCritRatingPer*0.24, SpellHasteRating=0.60, SpellPenetration=SpellPenetrationPer*0,
		Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005, DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05, ParryRating=ParryRatingPer*0.05, BlockRating=BlockRatingPer*0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04, MetaSocketEffect=36, }
	)

	AddTemplate(
		ScaleProviderName,
		5, -- Priest
		3, -- Shadow
		{ Strength=0, Agility=0.05, Dps=0, MeleeDps=0, RangedDps=0, Ap=0, Rap=0, FeralAp=0, HitRating=HitRatingPer*0, ExpertiseRating=ExpertiseRatingPer*0, CritRating=CritRatingPer*0, HasteRating=HasteRatingPer*0, ArmorPenetration=ArmorPenetrationPer*0,
		Intellect=0.19, Mana=0.017, Spirit=0.21, Mp5=1, Healing=0, SpellDamage=1, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=1, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellHitRating=SpellHitRatingPer*1.12, SpellCritRating=SpellCritRatingPer*0.76, SpellHasteRating=0.65, SpellPenetration=SpellPenetrationPer*0.08,
		Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005, DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05, ParryRating=ParryRatingPer*0.05, BlockRating=BlockRatingPer*0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04, MetaSocketEffect=36, }
	)

	AddTemplate(
		ScaleProviderName,
		4, -- Rogue
		1, -- Assassination
		{ IsOffHand=PawnIgnoreStatValue, IsFrill=PawnIgnoreStatValue, IsShield=PawnIgnoreStatValue,
		Strength=0.5, Agility=1, Dps=0, MeleeDps=3, RangedDps=0, Ap=0.45, Rap=0, FeralAp=0, HitRating=HitRatingPer*1, ExpertiseRating=ExpertiseRatingPer*1.1, CritRating=CritRatingPer*0.81, HasteRating=HasteRatingPer*0.9, ArmorPenetration=ArmorPenetrationPer*0.24, MeleeMinDamage=1.25, MeleeMaxDamage=1.25,
		Intellect=0, Mana=0, Spirit=0.05, Mp5=0, Healing=0, SpellDamage=0, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellHitRating=SpellHitRatingPer*0, SpellCritRating=SpellCritRatingPer*0, SpellHasteRating=0, SpellPenetration=SpellPenetrationPer*0,
		Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005, DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05, ParryRating=ParryRatingPer*0.12, BlockRating=BlockRatingPer*0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04, MetaSocketEffect=36, }
	)

	AddTemplate(
		ScaleProviderName,
		4, -- Rogue
		2, -- Combat
		{ IsOffHand=PawnIgnoreStatValue, IsFrill=PawnIgnoreStatValue, IsShield=PawnIgnoreStatValue,
		Strength=0.5, Agility=1, Dps=0, MeleeDps=3, RangedDps=0, Ap=0.45, Rap=0, FeralAp=0, HitRating=HitRatingPer*1, ExpertiseRating=ExpertiseRatingPer*1.1, CritRating=CritRatingPer*0.81, HasteRating=HasteRatingPer*0.9, ArmorPenetration=ArmorPenetrationPer*0.24, MeleeMinDamage=0.875, MeleeMaxDamage=0.875,
		Intellect=0, Mana=0, Spirit=0.05, Mp5=0, Healing=0, SpellDamage=0, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellHitRating=SpellHitRatingPer*0, SpellCritRating=SpellCritRatingPer*0, SpellHasteRating=0, SpellPenetration=SpellPenetrationPer*0,
		Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005, DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05, ParryRating=ParryRatingPer*0.12, BlockRating=BlockRatingPer*0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04, MetaSocketEffect=36, }
	)

	AddTemplate(
		ScaleProviderName,
		4, -- Rogue
		3, -- Subtlety
		{ IsOffHand=PawnIgnoreStatValue, IsFrill=PawnIgnoreStatValue, IsShield=PawnIgnoreStatValue,
		Strength=0.5, Agility=1, Dps=0, MeleeDps=3, RangedDps=0, Ap=0.45, Rap=0, FeralAp=0, HitRating=HitRatingPer*1, ExpertiseRating=ExpertiseRatingPer*1.1, CritRating=CritRatingPer*0.81, HasteRating=HasteRatingPer*0.9, ArmorPenetration=ArmorPenetrationPer*0.24, MeleeMinDamage=1.25, MeleeMaxDamage=1.25,
		Intellect=0, Mana=0, Spirit=0.05, Mp5=0, Healing=0, SpellDamage=0, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellHitRating=SpellHitRatingPer*0, SpellCritRating=SpellCritRatingPer*0, SpellHasteRating=0, SpellPenetration=SpellPenetrationPer*0,
		Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005, DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05, ParryRating=ParryRatingPer*0.12, BlockRating=BlockRatingPer*0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04, MetaSocketEffect=36, }
	)

	AddTemplate(
		ScaleProviderName,
		7, -- Shaman
		1, -- Elemental
		{ Strength=0, Agility=0.05, Dps=0, MeleeDps=0, RangedDps=0, Ap=0, Rap=0, FeralAp=0, HitRating=HitRatingPer*0, ExpertiseRating=ExpertiseRatingPer*0, CritRating=CritRatingPer*0, HasteRating=HasteRatingPer*0, ArmorPenetration=ArmorPenetrationPer*0,
		Intellect=0.31, Mana=0.024, Spirit=0.09, Mp5=1.14, Healing=0, SpellDamage=1, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=1, HolySpellDamage=0, SpellPower=0, SpellHitRating=SpellHitRatingPer*0.9, SpellCritRating=SpellCritRatingPer*1.05, SpellHasteRating=0.9, SpellPenetration=SpellPenetrationPer*0.38,
		Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005, DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05, ParryRating=ParryRatingPer*0.12, BlockRating=BlockRatingPer*0.01, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04, MetaSocketEffect=36, }
	)

	AddTemplate(
		ScaleProviderName,
		7, -- Shaman
		2, -- Enhancement
		{ Strength=1, Agility=0.87, Dps=0, MeleeDps=3, RangedDps=0, Ap=0.5, Rap=0, FeralAp=0, HitRating=HitRatingPer*0.67, ExpertiseRating=ExpertiseRatingPer*1.5, CritRating=CritRatingPer*0.98, HasteRating=HasteRatingPer*0.64, ArmorPenetration=ArmorPenetrationPer*0.12,
		Intellect=0.34, Mana=0.032, Spirit=0.05, Mp5=1, Healing=0, SpellDamage=0.3, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0.3, HolySpellDamage=0, SpellPower=0, SpellHitRating=SpellHitRatingPer*0.223, SpellCritRating=SpellCritRatingPer*0.326, SpellHasteRating=0.08, SpellPenetration=SpellPenetrationPer*0.11,
		Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005, DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05, ParryRating=ParryRatingPer*0.05, BlockRating=BlockRatingPer*0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04, MetaSocketEffect=36, }
	)

	AddTemplate(
		ScaleProviderName,
		7, -- Shaman
		3, -- Restoration
		{ Strength=0, Agility=0.05, Dps=0, MeleeDps=0, RangedDps=0, Ap=0, Rap=0, FeralAp=0, HitRating=HitRatingPer*0, ExpertiseRating=ExpertiseRatingPer*0, CritRating=CritRatingPer*0, HasteRating=HasteRatingPer*0, ArmorPenetration=ArmorPenetrationPer*0,
		Intellect=1, Mana=0.009, Spirit=0.61, Mp5=1.33, Healing=0.9, SpellDamage=0, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellHitRating=SpellHitRatingPer*0, SpellCritRating=SpellCritRatingPer*0.48, SpellHasteRating=0.74, SpellPenetration=SpellPenetrationPer*0,
		Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005, DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05, ParryRating=ParryRatingPer*0.05, BlockRating=BlockRatingPer*0.01, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04, MetaSocketEffect=36, }
	)

	AddTemplate(
		ScaleProviderName,
		9, -- Warlock
		1, -- Affliction
		{ Strength=0, Agility=0.05, Dps=0, MeleeDps=0, RangedDps=0, Ap=0, Rap=0, FeralAp=0, HitRating=HitRatingPer*0, ExpertiseRating=ExpertiseRatingPer*0, CritRating=CritRatingPer*0, HasteRating=HasteRatingPer*0, ArmorPenetration=ArmorPenetrationPer*0,
		Intellect=0.4, Mana=0.03, Spirit=0.1, Mp5=1, Healing=0, SpellDamage=1, FireSpellDamage=0.35, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0.91, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellHitRating=SpellHitRatingPer*1.2, SpellCritRating=SpellCritRatingPer*0.39, SpellHasteRating=0.78, SpellPenetration=SpellPenetrationPer*0.08,
		Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005, DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05, ParryRating=ParryRatingPer*0.05, BlockRating=BlockRatingPer*0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04, MetaSocketEffect=36, }
	)

	AddTemplate(
		ScaleProviderName,
		9, -- Warlock
		2, -- Demonology
		{ Strength=0, Agility=0.05, Dps=0, MeleeDps=0, RangedDps=0, Ap=0, Rap=0, FeralAp=0, HitRating=HitRatingPer*0, ExpertiseRating=ExpertiseRatingPer*0, CritRating=CritRatingPer*0, HasteRating=HasteRatingPer*0, ArmorPenetration=ArmorPenetrationPer*0,
		Intellect=0.4, Mana=0.03, Spirit=0.5, Mp5=1, Healing=0, SpellDamage=1, FireSpellDamage=0.80, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0.8, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellHitRating=SpellHitRatingPer*1.2, SpellCritRating=SpellCritRatingPer*0.66, SpellHasteRating=0.7, SpellPenetration=SpellPenetrationPer*0.08,
		Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005, DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05, ParryRating=ParryRatingPer*0.05, BlockRating=BlockRatingPer*0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04, MetaSocketEffect=36, }
	)

	AddTemplate(
		ScaleProviderName,
		9, -- Warlock
		3, -- Destruction
		{ Strength=0, Agility=0.05, Dps=0, MeleeDps=0, RangedDps=0, Ap=0, Rap=0, FeralAp=0, HitRating=HitRatingPer*0, ExpertiseRating=ExpertiseRatingPer*0, CritRating=CritRatingPer*0, HasteRating=HasteRatingPer*0, ArmorPenetration=ArmorPenetrationPer*0,
		Intellect=0.34, Mana=0.028, Spirit=0.25, Mp5=0.65, Healing=0, SpellDamage=1, FireSpellDamage=0.23, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0.95, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellHitRating=SpellHitRatingPer*1.6, SpellCritRating=SpellCritRatingPer*0.87, SpellHasteRating=1.15, SpellPenetration=SpellPenetrationPer*0.08,
		Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005, DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05, ParryRating=ParryRatingPer*0.05, BlockRating=BlockRatingPer*0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04, MetaSocketEffect=36, }
	)

	AddTemplate(
		ScaleProviderName,
		1, -- Warrior
		1, -- Arms
		{ Strength=1, Agility=0.69, Dps=0, MeleeDps=5.31, RangedDps=0, Ap=0.45, Rap=0, FeralAp=0, HitRating=HitRatingPer*1, ExpertiseRating=ExpertiseRatingPer*1, CritRating=CritRatingPer*0.85, HasteRating=HasteRatingPer*0.57, ArmorPenetration=ArmorPenetrationPer*1.1,
		Intellect=0, Mana=0, Spirit=0.05, Mp5=0, Healing=0, SpellDamage=0, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellHitRating=SpellHitRatingPer*0, SpellCritRating=SpellCritRatingPer*0, SpellHasteRating=0, SpellPenetration=SpellPenetrationPer*0,
		Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005, DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05, ParryRating=ParryRatingPer*0.05, BlockRating=BlockRatingPer*0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04, MetaSocketEffect=36, }
	)

	AddTemplate(
		ScaleProviderName,
		1, -- Warrior
		2, -- Fury
		{ Strength=1, Agility=0.57, Dps=0, MeleeDps=5.22, RangedDps=0, Ap=0.54, Rap=0, FeralAp=0, HitRating=HitRatingPer*0.57, ExpertiseRating=ExpertiseRatingPer*0.57, CritRating=CritRatingPer*0.7, HasteRating=HasteRatingPer*0.41, ArmorPenetration=ArmorPenetrationPer*0.47,
		Intellect=0, Mana=0, Spirit=0.05, Mp5=0, Healing=0, SpellDamage=0, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellHitRating=SpellHitRatingPer*0, SpellCritRating=SpellCritRatingPer*0, SpellHasteRating=0, SpellPenetration=SpellPenetrationPer*0,
		Stamina=0.1, Health=0.01, Hp5=1, Armor=0.005, DefenseRating=DefenseRatingPer*0.05, DodgeRating=DodgeRatingPer*0.05, ParryRating=ParryRatingPer*0.12, BlockRating=BlockRatingPer*0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04, MetaSocketEffect=36, }
	)

	AddTemplate(
		ScaleProviderName,
		1, -- Warrior
		3, -- Protection
		{ Strength=0.33, Agility=0.59, Dps=0, MeleeDps=3.13, RangedDps=0, Ap=0.06, Rap=0, FeralAp=0, HitRating=HitRatingPer*0.67, ExpertiseRating=ExpertiseRatingPer*0.67, CritRating=CritRatingPer*0.28, HasteRating=HasteRatingPer*0.21, ArmorPenetration=ArmorPenetrationPer*0.19,
		Intellect=0, Mana=0, Spirit=0.05, Mp5=0, Healing=0, SpellDamage=0, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellHitRating=SpellHitRatingPer*0, SpellCritRating=SpellCritRatingPer*0, SpellHasteRating=0, SpellPenetration=SpellPenetrationPer*0,
		Stamina=1, Health=0.09, Hp5=2, Armor=0.02, DefenseRating=DefenseRatingPer*0.81, DodgeRating=DodgeRatingPer*0.7, ParryRating=ParryRatingPer*0.58, BlockRating=BlockRatingPer*0.59, BlockValue=0.35, ResilienceRating=0.2, AllResist=1, FireResist=0.2, FrostResist=0.2, ArcaneResist=0.2, ShadowResist=0.2, NatureResist=0.2, MetaSocketEffect=36, }
	)
	]]





	AddTemplate(
		ScaleProviderName,
		6, -- Death Knight
		1, -- Blood
		{ Strength=1, Agility=0.48, Dps=0, MeleeDps=3.4, RangedDps=0, Ap=0.35, Rap=0, FeralAp=0, HitRating=0.87, ExpertiseRating=0.86, CritRating=0.54, HasteRating=0.52, ArmorPenetration=0.95,
		Intellect=0, Mana=0, Spirit=0.05, Mp5=0, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellPenetration=0,
		Stamina=0.3, Health=0.03, Hp5=1, Armor=0.005, DefenseRating=0.05, DodgeRating=0.05, ParryRating=0.12, BlockRating=0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		6, -- Death Knight
		2, -- Frost (tank)
		{ Strength=1, Agility=0.78, Dps=0, MeleeDps=3.48, RangedDps=0, Ap=0.37, Rap=0, FeralAp=0, HitRating=1.03, ExpertiseRating=0.84, CritRating=0.46, HasteRating=0.29, ArmorPenetration=0.63,
		Intellect=0, Mana=0, Spirit=0.05, Mp5=0, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellPenetration=0,
		Stamina=1, Health=0.09, Hp5=2, Armor=0.02, DefenseRating=0.89, DodgeRating=0.72, ParryRating=0.54, BlockRating=0, BlockValue=0, ResilienceRating=0.2, AllResist=1, FireResist=0.2, FrostResist=0.2, ArcaneResist=0.2, ShadowResist=0.2, NatureResist=0.2,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		6, -- Death Knight
		3, -- Unholy
		{ Strength=1, Agility=0.31, Dps=0, MeleeDps=2.09, RangedDps=0, Ap=0.34, Rap=0, FeralAp=0, HitRating=0.66, ExpertiseRating=0.51, CritRating=0.45, HasteRating=0.48, ArmorPenetration=0.32,
		Intellect=0, Mana=0, Spirit=0.05, Mp5=0, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellPenetration=0,
		Stamina=0.3, Health=0.03, Hp5=1, Armor=0.005, DefenseRating=0.05, DodgeRating=0.05, ParryRating=0.05, BlockRating=0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		11, -- Druid
		1, -- Balance
		{ Strength=0, Agility=0.05, Dps=0, MeleeDps=0, RangedDps=0, Ap=0, Rap=0, FeralAp=0, HitRating=1.21, ExpertiseRating=0, CritRating=0.62, HasteRating=0.8, ArmorPenetration=0,
		Intellect=0.38, Mana=0.032, Spirit=0.34, Mp5=0.58, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0.64, ShadowSpellDamage=0, NatureSpellDamage=0.43, HolySpellDamage=0, SpellPower=1, SpellPenetration=0.21,
		Stamina=0.3, Health=0.03, Hp5=1, Armor=0.005, DefenseRating=0.05, DodgeRating=0.05, ParryRating=0.05, BlockRating=0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		11, -- Druid
		2, -- Feral (Damage)
		{ Strength=1.35, Agility=1, Dps=0, MeleeDps=0, RangedDps=0, Ap=0.61, Rap=0, FeralAp=0.61, HitRating=0.59, ExpertiseRating=0.59, CritRating=0.47, HasteRating=0.41, ArmorPenetration=0.59,
		Intellect=0.1, Mana=0.009, Spirit=0.05, Mp5=0.3, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellPenetration=0,
		Stamina=0.3, Health=0.03, Hp5=1, Armor=0.005, DefenseRating=0.05, DodgeRating=0.05, ParryRating=0.05, BlockRating=0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		11, -- Druid
		3, -- Feral (Tank)
		{ Strength=0.41, Agility=0.47, Dps=0, MeleeDps=0, RangedDps=0, Ap=0.34, Rap=0, FeralAp=0.34, HitRating=0.16, ExpertiseRating=0.18, CritRating=0.15, HasteRating=0.31, ArmorPenetration=0.2,
		Intellect=0.1, Mana=0.009, Spirit=0.05, Mp5=0.3, SpellPower=0.025, NatureSpellDamage=0.025, HolySpellDamage=0, SpellPenetration=0,
		Stamina=1, Health=0.055, Hp5=2, Armor=0.15, DefenseRating=0.26, DodgeRating=0.56, ParryRating=0, BlockRating=0, BlockValue=0, ResilienceRating=0.2, AllResist=1, FireResist=0.2, FrostResist=0.2, ArcaneResist=0.2, ShadowResist=0.2, NatureResist=0.2,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		11, -- Druid
		4, -- Restoration
		{ Strength=0, Agility=0.05, Dps=0, MeleeDps=0, RangedDps=0, Ap=0, Rap=0, FeralAp=0, HitRating=0, ExpertiseRating=0, CritRating=0.35, HasteRating=1, ArmorPenetration=0,
		Intellect=0.66, Mana=0.036, Spirit=0.94, Mp5=1.8, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0.88, SpellPenetration=0,
		Stamina=0.3, Health=0.03, Hp5=1, Armor=0.005, DefenseRating=0.05, DodgeRating=0.05, ParryRating=0.05, BlockRating=0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		3, -- Hunter
		1, -- Beast Mastery
		{ Strength=0.05, Agility=1, Dps=0, MeleeDps=0.75, RangedDps=2.6, Ap=0.46, Rap=0.46, FeralAp=0, HitRating=1.08, ExpertiseRating=0.05, CritRating=0.84, HasteRating=0.16, ArmorPenetration=0.96,
		Intellect=0.55, Mana=0.03, Spirit=0.05, Mp5=2.4, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellPenetration=0,
		Stamina=0.3, Health=0.03, Hp5=1, Armor=0.005, DefenseRating=0.05, DodgeRating=0.05, ParryRating=0.05, BlockRating=0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		3, -- Hunter
		2, -- Marksmanship
		{ Strength=0.05, Agility=1, Dps=0, MeleeDps=0.75, RangedDps=2.6, Ap=0.46, Rap=0.46, FeralAp=0, HitRating=1.08, ExpertiseRating=0.05, CritRating=0.84, HasteRating=0.16, ArmorPenetration=0.96,
			Intellect=0.55, Mana=0.03, Spirit=0.05, Mp5=2.4, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellPenetration=0,
			Stamina=0.3, Health=0.03, Hp5=1, Armor=0.005, DefenseRating=0.05, DodgeRating=0.05, ParryRating=0.05, BlockRating=0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		3, -- Hunter
		3, -- Survival
		{ Strength=0.05, Agility=1, Dps=0, MeleeDps=0.75, RangedDps=2.6, Ap=0.46, Rap=0.46, FeralAp=0, HitRating=1.08, ExpertiseRating=0.05, CritRating=0.84, HasteRating=0.16, ArmorPenetration=0.96,
		Intellect=0.55, Mana=0.03, Spirit=0.05, Mp5=2.4, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellPenetration=0,
		Stamina=0.3, Health=0.03, Hp5=1, Armor=0.005, DefenseRating=0.05, DodgeRating=0.05, ParryRating=0.05, BlockRating=0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		8, -- Mage
		1, -- Arcane
		{ Strength=0, Agility=0.05, Dps=0, MeleeDps=0, RangedDps=0, Ap=0, Rap=0, FeralAp=0, HitRating=0.87, ExpertiseRating=0, CritRating=0.6, HasteRating=0.59, ArmorPenetration=0,
		Intellect=0.46, Mana=0.025, Spirit=0.42, Mp5=1.13, FireSpellDamage=0.064, FrostSpellDamage=0.22, ArcaneSpellDamage=0.95, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=1, SpellPenetration=0.09,
		Stamina=0.3, Health=0.03, Hp5=1, Armor=0.005, DefenseRating=0.05, DodgeRating=0.05, ParryRating=0.05, BlockRating=0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		8, -- Mage
		2, -- Fire
		{ Strength=0, Agility=0.05, Dps=0, MeleeDps=0, RangedDps=0, Ap=0, Rap=0, FeralAp=0, HitRating=0.93, ExpertiseRating=0, CritRating=0.77, HasteRating=0.82, ArmorPenetration=0,
		Intellect=0.44, Mana=0.024, Spirit=0.46, Mp5=0.9, FireSpellDamage=0.95, FrostSpellDamage=0.32, ArcaneSpellDamage=0.168, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=1, SpellPenetration=0.09,
		Stamina=0.3, Health=0.03, Hp5=1, Armor=0.005, DefenseRating=0.05, DodgeRating=0.05, ParryRating=0.05, BlockRating=0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		8, -- Mage
		3, -- Frost
		{ Strength=0, Agility=0.05, Dps=0, MeleeDps=0, RangedDps=0, Ap=0, Rap=0, FeralAp=0, HitRating=1.22, ExpertiseRating=0, CritRating=0.58, HasteRating=0.63, ArmorPenetration=0,
		Intellect=0.37, Mana=0.02, Spirit=0.38, Mp5=0.8, FireSpellDamage=0.05, FrostSpellDamage=0.95, ArcaneSpellDamage=0.13, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=1, SpellPenetration=0.07,
		Stamina=0.3, Health=0.03, Hp5=1, Armor=0.005, DefenseRating=0.05, DodgeRating=0.05, ParryRating=0.05, BlockRating=0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		2, -- Paladin
		1, -- Holy
		{ Strength=0, Agility=0.05, Dps=0, MeleeDps=0, RangedDps=0, Ap=0, Rap=0, FeralAp=0, HitRating=0, ExpertiseRating=0, CritRating=0.46, HasteRating=0.39, ArmorPenetration=0,
		Intellect=1, Mana=0.009, Spirit=0.28, Mp5=1.6, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=1, SpellPenetration=0,
		Stamina=0.3, Health=0.03, Hp5=1, Armor=0.005, DefenseRating=0.05, DodgeRating=0.05, ParryRating=0.05, BlockRating=0.01, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		2, -- Paladin
		2, -- Protection
		{ Strength=0.74, Agility=0.8, Dps=0, MeleeDps=1.77, RangedDps=0, Ap=0.13, Rap=0, FeralAp=0, HitRating=0.78, ExpertiseRating=0.27, CritRating=0.6, HasteRating=0.42, ArmorPenetration=0.14,
		Intellect=0.5, Mana=0.045, Spirit=0.05, Mp5=1, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0.4, SpellPower=0.4, SpellPenetration=0.03,
		Stamina=1, Health=0.09, Hp5=2, Armor=0.02, DefenseRating=0.7, DodgeRating=0.7, ParryRating=0.6, BlockRating=0.6, BlockValue=0.15, ResilienceRating=0.2, AllResist=1, FireResist=0.2, FrostResist=0.2, ArcaneResist=0.2, ShadowResist=0.2, NatureResist=0.2,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		2, -- Paladin
		3, -- Retribution
		{ Strength=1, Agility=0.46, Dps=0, MeleeDps=5.5, RangedDps=0, Ap=0.41, Rap=0, FeralAp=0, HitRating=0.84, ExpertiseRating=0.52, CritRating=0.44, HasteRating=0.35, ArmorPenetration=0.3,
		Intellect=0.24, Mana=0.013, Spirit=0.05, Mp5=1.4, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0.2, SpellPower=0.2, SpellPenetration=0.010,
		Stamina=0.3, Health=0.03, Hp5=1, Armor=0.005, DefenseRating=0.05, DodgeRating=0.05, ParryRating=0.05, BlockRating=0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		5, -- Priest
		1, -- Discipline
		{ Strength=0, Agility=0.05, Dps=0, MeleeDps=0, RangedDps=0, Ap=0, Rap=0, FeralAp=0, HitRating=0, ExpertiseRating=0, CritRating=0.68, HasteRating=0.59, ArmorPenetration=0,
		Intellect=1, Mana=0.055, Spirit=0.42, Mp5=1.8, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0.58, SpellPenetration=0,
		Stamina=0.3, Health=0.03, Hp5=1, Armor=0.005, DefenseRating=0.05, DodgeRating=0.05, ParryRating=0.05, BlockRating=0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		5, -- Priest
		2, -- Holy
		{ Strength=0, Agility=0.05, Dps=0, MeleeDps=0, RangedDps=0, Ap=0, Rap=0, FeralAp=0, HitRating=0, ExpertiseRating=0, CritRating=0.42, HasteRating=0.58, ArmorPenetration=0,
		Intellect=0.83, Mana=0.046, Spirit=1, Mp5=2.44, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0.7, SpellPenetration=0,
		Stamina=0.3, Health=0.03, Hp5=1, Armor=0.005, DefenseRating=0.05, DodgeRating=0.05, ParryRating=0.05, BlockRating=0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		5, -- Priest
		3, -- Shadow
		{ Strength=0, Agility=0.05, Dps=0, MeleeDps=0, RangedDps=0, Ap=0, Rap=0, FeralAp=0, HitRating=1.12, ExpertiseRating=0, CritRating=0.61, HasteRating=0.56, ArmorPenetration=0,
		Intellect=0.19, Mana=0.01, Spirit=0.21, Mp5=1, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=1, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=1, SpellPenetration=0.08,
		Stamina=0.3, Health=0.03, Hp5=1, Armor=0.005, DefenseRating=0.05, DodgeRating=0.05, ParryRating=0.05, BlockRating=0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		4, -- Rogue
		1, -- Assassination
		{ IsOffHand=PawnIgnoreStatValue, IsFrill=PawnIgnoreStatValue, IsShield=PawnIgnoreStatValue,
		Strength=0.5, Agility=1, Dps=0, MeleeDps=3, RangedDps=0, Ap=0.45, Rap=0, FeralAp=0, HitRating=0.92, ExpertiseRating=0.84, CritRating=0.85, HasteRating=0.81, ArmorPenetration=1, MeleeMinDamage=1.25, MeleeMaxDamage=1.25,
		Intellect=0, Mana=0, Spirit=0.05, Mp5=0, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellPenetration=0,
		Stamina=0.3, Health=0.03, Hp5=1, Armor=0.005, DefenseRating=0.05, DodgeRating=0.05, ParryRating=0.12, BlockRating=0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		4, -- Rogue
		2, -- Combat
		{ IsOffHand=PawnIgnoreStatValue, IsFrill=PawnIgnoreStatValue, IsShield=PawnIgnoreStatValue,
		Strength=0.5, Agility=1, Dps=0, MeleeDps=3, RangedDps=0, Ap=0.45, Rap=0, FeralAp=0, HitRating=0.92, ExpertiseRating=0.84, CritRating=0.97, HasteRating=0.7, ArmorPenetration=1, MeleeMinDamage=0.875, MeleeMaxDamage=0.875,
		Intellect=0, Mana=0, Spirit=0.05, Mp5=0, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellPenetration=0,
		Stamina=0.3, Health=0.03, Hp5=1, Armor=0.005, DefenseRating=0.05, DodgeRating=0.05, ParryRating=0.12, BlockRating=0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		4, -- Rogue
		3, -- Subtlety
		{ IsOffHand=PawnIgnoreStatValue, IsFrill=PawnIgnoreStatValue, IsShield=PawnIgnoreStatValue,
		Strength=0.5, Agility=1, Dps=0, MeleeDps=3, RangedDps=0, Ap=0.45, Rap=0, FeralAp=0, HitRating=0.92, ExpertiseRating=0.84, CritRating=0.85, HasteRating=0.81, ArmorPenetration=1, MeleeMinDamage=1.25, MeleeMaxDamage=1.25,
		Intellect=0, Mana=0, Spirit=0.05, Mp5=0, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellPenetration=0,
		Stamina=0.3, Health=0.03, Hp5=1, Armor=0.005, DefenseRating=0.05, DodgeRating=0.05, ParryRating=0.12, BlockRating=0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		4, -- Rogue
		nil,
		{ IsCloth=PawnIgnoreStatValue, IsLeather=PawnIgnoreStatValue, IsMail=PawnIgnoreStatValue, IsPlate=PawnIgnoreStatValue, IsShield=PawnIgnoreStatValue, IsRanged=PawnIgnoreStatValue, MainHandDps=PawnIgnoreStatValue, IsFrill=PawnIgnoreStatValue,
		Strength=0.5, Agility=1, Dps=0, MeleeDps=2, RangedDps=0, Ap=0.45, Rap=0, FeralAp=0, HitRating=0.92, ExpertiseRating=0.84, CritRating=0.85, HasteRating=0.8, ArmorPenetration=1, MeleeSpeed=-80, SpeedBaseline=2.9,
		Intellect=0, Mana=0, Spirit=0.05, Mp5=0, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellPenetration=0,
		Stamina=0.3, Health=0.03, Hp5=1, Armor=0.005, DefenseRating=0.05, DodgeRating=0.05, ParryRating=0.12, BlockRating=0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		7, -- Shaman
		1, -- Elemental
		{ Strength=0, Agility=0.05, Dps=0, MeleeDps=0, RangedDps=0, Ap=0, Rap=0, FeralAp=0, HitRating=1.94, ExpertiseRating=0, CritRating=0.68, HasteRating=1.01, ArmorPenetration=0,
		Intellect=0.19, Mana=0.008, Spirit=0.09, Mp5=1.14, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0.95, HolySpellDamage=0, SpellPower=1, SpellPenetration=0.38,
		Stamina=0.3, Health=0.03, Hp5=1, Armor=0.005, DefenseRating=0.05, DodgeRating=0.05, ParryRating=0.05, BlockRating=0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		7, -- Shaman
		2, -- Enhancement
		{ Strength=0.65, Agility=1, Dps=0, MeleeDps=3.4, RangedDps=0, Ap=0.59, Rap=0, FeralAp=0, HitRating=1.8, ExpertiseRating=1.53, CritRating=0.98, HasteRating=0.76, ArmorPenetration=0.47,
		Intellect=1, Mana=0.03, Spirit=0.05, Mp5=1, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0.3, HolySpellDamage=0, SpellPower=0.53, SpellPenetration=0.11,
		Stamina=0.3, Health=0.03, Hp5=1, Armor=0.005, DefenseRating=0.05, DodgeRating=0.05, ParryRating=0.05, BlockRating=0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		7, -- Shaman
		3, -- Restoration
		{ Strength=0, Agility=0.05, Dps=0, MeleeDps=0, RangedDps=0, Ap=0, Rap=0, FeralAp=0, HitRating=0, ExpertiseRating=0, CritRating=0.95, HasteRating=1.8, ArmorPenetration=0,
		Intellect=0.75, Mana=0.009, Spirit=0.61, Mp5=0.95, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=1, SpellPenetration=0,
		Stamina=0.3, Health=0.03, Hp5=1, Armor=0.005, DefenseRating=0.05, DodgeRating=0.05, ParryRating=0.05, BlockRating=0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		9, -- Warlock
		1, -- Affliction
		{ Strength=0, Agility=0.05, Dps=0, MeleeDps=0, RangedDps=0, Ap=0, Rap=0, FeralAp=0, HitRating=1.13, ExpertiseRating=0, CritRating=0.4, HasteRating=0.64, ArmorPenetration=0,
		Intellect=0.15, Mana=0.008, Spirit=0.51, Mp5=1, FireSpellDamage=0.6, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0.6, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=1, SpellPenetration=0.08,
		Stamina=0.3, Health=0.03, Hp5=1, Armor=0.005, DefenseRating=0.05, DodgeRating=0.05, ParryRating=0.05, BlockRating=0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		9, -- Warlock
		2, -- Demonology
		{ Strength=0, Agility=0.05, Dps=0, MeleeDps=0, RangedDps=0, Ap=0, Rap=0, FeralAp=0, HitRating=1.18, ExpertiseRating=0, CritRating=0.42, HasteRating=0.68, ArmorPenetration=0,
		Intellect=0.15, Mana=0.008, Spirit=0.48, Mp5=1, FireSpellDamage=0.6, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0.6, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=1, SpellPenetration=0.08,
		Stamina=0.3, Health=0.03, Hp5=1, Armor=0.005, DefenseRating=0.05, DodgeRating=0.05, ParryRating=0.05, BlockRating=0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		9, -- Warlock
		3, -- Destruction
		{ Strength=0, Agility=0.05, Dps=0, MeleeDps=0, RangedDps=0, Ap=0, Rap=0, FeralAp=0, HitRating=1.39, ExpertiseRating=0, CritRating=0.61, HasteRating=0.8, ArmorPenetration=0,
		Intellect=0.23, Mana=0.012, Spirit=0.55, Mp5=1, FireSpellDamage=0.6, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0.6, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=1, SpellPenetration=0.08,
		Stamina=0.3, Health=0.03, Hp5=1, Armor=0.005, DefenseRating=0.05, DodgeRating=0.05, ParryRating=0.05, BlockRating=0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		1, -- Warrior
		1, -- Arms
		{ Strength=1, Agility=0.69, Dps=0, MeleeDps=5.31, RangedDps=0, Ap=0.52, Rap=0, FeralAp=0, HitRating=0.88, ExpertiseRating=1.21, CritRating=0.85, HasteRating=0.57, ArmorPenetration=1.1,
		Intellect=0, Mana=0, Spirit=0.05, Mp5=0, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellPenetration=0,
		Stamina=0.3, Health=0.03, Hp5=1, Armor=0.005, DefenseRating=0.05, DodgeRating=0.05, ParryRating=0.05, BlockRating=0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		1, -- Warrior
		2, -- Fury
		{ Strength=1, Agility=0.77, Dps=0, MeleeDps=5.22, RangedDps=0, Ap=0.66, Rap=0, FeralAp=0, HitRating=0.55, ExpertiseRating=1.5, CritRating=0.93, HasteRating=0.79, ArmorPenetration=1.38,
		Intellect=0, Mana=0, Spirit=0.05, Mp5=0, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellPenetration=0,
		Stamina=0.3, Health=0.03, Hp5=1, Armor=0.005, DefenseRating=0.05, DodgeRating=0.05, ParryRating=0.12, BlockRating=0, BlockValue=0, ResilienceRating=0.2, AllResist=0.2, FireResist=0.04, FrostResist=0.04, ArcaneResist=0.04, ShadowResist=0.04, NatureResist=0.04,
		MetaSocket=35, }
	)

	AddTemplate(
		ScaleProviderName,
		1, -- Warrior
		3, -- Protection
		{ IsOffHand=PawnIgnoreStatValue,
		Strength=0.33, Agility=0.59, Dps=0, MeleeDps=3.13, RangedDps=0, Ap=0.34, Rap=0, FeralAp=0, HitRating=0.67, ExpertiseRating=0.94, CritRating=0.28, HasteRating=0.21, ArmorPenetration=0.29,
		Intellect=0, Mana=0, Spirit=0.05, Mp5=0, FireSpellDamage=0, FrostSpellDamage=0, ArcaneSpellDamage=0, ShadowSpellDamage=0, NatureSpellDamage=0, HolySpellDamage=0, SpellPower=0, SpellPenetration=0,
		Stamina=1, Health=0.09, Hp5=2, Armor=0.02, DefenseRating=0.81, DodgeRating=0.7, ParryRating=0.58, BlockRating=0.59, BlockValue=0.35, ResilienceRating=0.2, AllResist=1, FireResist=0.2, FrostResist=0.2, ArcaneResist=0.2, ShadowResist=0.2, NatureResist=0.2,
		MetaSocket=35, }
	)









end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:ItemRatingOnLogin()
	--print("SkuCore:ItemRatingOnLogin")

	if not GetItemStatsHook then
		GetItemStatsHook = GetItemStats
		GetItemStats = GetItemStatsHelperHook
	end

   ItemRatingAddScales()
end
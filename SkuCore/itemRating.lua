local MODULE_NAME, MODULE_PART = "SkuCore", "itemRating"
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

local tStatRatings = {}

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:ItemRatingGetRating(aTooltipName)
	local _, _, ClassID = UnitClass("player")
	--local SpecID = GetSpecialization()
	local Stats, SocketBonusStats, UnknownLines, PrettyLink = PawnGetStatsFromTooltip(aTooltipName, false)


	for SpecID = 1, 4 do
		print(ClassID, SpecID)
		local tResult = 0
		if tStatRatings[ClassID][SpecID] then
			for tStatName, tStatValue in pairs(Stats) do
				--print("  "tStatName, tStatValue)
				tResult = tResult + (tStatRatings[ClassID][SpecID][tStatName] * tStatValue)
			end
			print(SpecID, tResult)
		end
	end
end







---------------------------------------------------------------------------------------------------------------------------------------
local function AddTemplate(ProviderInternalName, ClassID, SpecID, Stats)
	--print(ClassID, SpecID, Stats)
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
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:ItemRatingOnLogin()
   ItemRatingAddScales()
end


---------------------------------------------------------------------------------------------------------------------------------------
-- NOTE: These functions are not super-flexible for general purpose; they don't properly handle all sorts of Lua pattern matching syntax
-- that could be in strings, like "." and so on.  But they've been sufficient so far.

-- Turns a game constant into a regular expression.
function PawnGameConstant(Text)
	return "^" .. PawnGameConstantUnwrapped(Text) .. "$"
end

-- Turns a game constant into a regular expression but without the ^ and $ on the ends.
function PawnGameConstantUnwrapped(Text)
	-- Some of these constants don't exist on Classic versions, so skip them: but not on live, where we would want this to error out.
	if Text == nil and not IsShadowlands then return "^UNUSED$" end

	local Ret1 = gsub(Text, "%%", "%%%%")
	return gsub(Ret1, "%-", "%%-")
end

-- Turns a game constant with one "%s" placeholder into a pattern that can be used to match that string.
function PawnGameConstantIgnoredPlaceholder(Text)
	-- Optimize for the common case where the %s is on the end.  This yields a more efficient pattern.
	if strsub(Text, strlen(Text) - 1) == "%s" then
		return "^" .. PawnGameConstantUnwrapped(strsub(Text, 1, strlen(Text) - 2))
	end
	-- If it's not at the end, replace it.
	return PawnGameConstant(gsub(Text, "%%s", ".+", 1))
end

-- Turns a game constant with "%d" placeholders into a pattern that can be used to match that string.
function PawnGameConstantIgnoredNumberPlaceholder(Text)
	return gsub(PawnGameConstant(Text), "%%%%d", "%%d+")
end

-- Escapes a string so that it can be more easily printed.
function PawnEscapeString(String)
	return gsub(gsub(gsub(String, "\r", "\\r"), "\n", "\\n"), "|", "||")
end

-- Pawn by Vger-Azjol-Nerub
-- www.vgermods.com
-- © 2006-2021 Travis Spomer.  This mod is released under the Creative Commons Attribution-NonCommercial-NoDerivs 3.0 license.
-- See Readme.htm for more information.
-- 
-- Tooltip parsing strings
------------------------------------------------------------

-- For conciseness
local PawnLocal = {
	["AverageItemLevelIgnoringRarityTooltipLine"] = "Durchschnittliche Gegenstandsstufe",
	["BaseValueWord"] = "Basis",
	["DecimalSeparator"] = ",",
	["EnchantedStatsHeader"] = "(Aktueller Wert)",
	["EngineeringName"] = "Ingenieurskunst",
	["FoundStatMessage"] = "%d %s",
	["GemList2"] = "%s oder %s",
	["GenericGemLink"] = "|Hitem:%d|h[Edelstein %d]|h",
	["GenericGemName"] = "(Edelstein %d)",
	["HiddenScalesHeader"] = "Andere Wertungen",
	["ItemIDTooltipLine"] = "Gegenstand-ID",
	["ItemLevelTooltipLine"] = "Gegenstandsstufe",
	["NoScale"] = "(keine)",
	["Or"] = "oder ",
	["ThousandsSeparator"] = ".",
	["TooltipBestAnnotation"] = "%s  |cff8ec3e6(bester)|r",
	["TooltipUpgradeFor1H"] = " für Einhand",
	["TooltipUpgradeFor2H"] = " für Zweihand",
	["TooltipVersusLine"] = "%s|n  vs. |c%s%s|r",
	["TotalValueMessage"] = "   ---- Gesamt: %g",
	["UnenchantedStatsHeader"] = "(Unverzaubert)",
	["Unusable"] = "(unbenutzbar)",
	["ValueCalculationMessage"] = "   %g %s x %g pro = %g",
	["VisibleScalesHeader"] = "%s's Wertungen",	
	["TooltipParsing"] = {
		["Agility"] = "^%+?# Beweglichkeit$",
		["AllStats"] = "^%+?# [Aa]lle [Ww]erte$",
		["Ap"] = "^%+?# Angriffskraft$",
		["Ap2"] = "^Anlegen: %+# Angriffskraft%.$",
		["Ap3"] = "^Anlegen: Erhöht die Angriffskraft um #%.$",
		["ArcaneResist"] = "^%+?# Arkanwiderstand$",
		["ArcaneSpellDamage"] = "^%+# Arkanzauberschaden$",
		["ArcaneSpellDamage2"] = "^Anlegen: Erhöht durch Arkanzauber und Arkaneffekte zugefügten Schaden um bis zu #%.$",
		["ArcaneSpellDamage3"] = "^%+# Arkanschaden$",
		["Armor"] = "^%+?# Rüstung$",
		["Armor2"] = "^UNUSED$",
		["ArmorPenetration"] = "^Anlegen: Eure Angriffe ignorieren # Rüstung Eures Gegners%.$",
		["Avoidance"] = "^%+# Vermeidung$",
		["Axe"] = "^Axt$",
		["BagSlots"] = "^%d+ Platz .+$",
		["Block"] = "^%+?# Blocken$",
		["BlockPercent"] = "^Anlegen: Erhöht Eure Chance, Angriffe mit einem Schild zu blocken, um #%%%.$",
		["BlockRating"] = "^Anlegen: Erhöht Eure Blockwertung um #%.$",
		["BlockRating2"] = "^UNUSED$",
		["BlockValue"] = "^Anlegen: Erhöht den Blockwert Eures Schildes um #%.$",
		["Bow"] = "^Bogen$",
		["ChanceOnHit"] = "Trefferchance:",
		["Charges"] = "^.+ Ladungen?$",
		["Cloth"] = "^Stoff$",
		["CooldownRemaining"] = "^Verbleibende Abklingzeit:",
		["Corruption"] = "^%+?# Verderbnis$",
		["Crit"] = "^%+?# [Kk]ritischer Trefferwert%.?$",
		["Crit2"] = "^UNUSED$",
		["CritPercent"] = "^Anlegen: Erhöht Eure Chance, einen kritischen Treffer zu erzielen, um #%%%.$",
		["CritRating"] = "^Anlegen: Erhöht Eure kritische Trefferwertung um #%.$",
		["CritRating2"] = "^Anlegen: Erhöht die kritische Trefferwertung um #%.$",
		["CritRating3"] = "^UNUSED$",
		["CritRatingShort"] = "^%+?# Kritische Trefferwertung$",
		["Crossbow"] = "^Armbrust$",
		["Dagger"] = "^Dolch$",
		["DefenseRating"] = "^Anlegen: Erhöht Verteidigungswertung um #%.$",
		["DefenseRating2"] = "^Anlegen: Erhöht die Verteidigungswertung um #%.$",
		["DefenseRatingSimple"] = "^%+?# Verteidigungswertung$",
		["DefenseSkill"] = "^Anlegen: Verteidigung %+#%.$",
		["DefenseSkillSimple"] = "^%+?# Verteidigung$",
		["DisenchantingRequires"] = "^Entzaubern benötigt",
		["Dodge"] = "^%+?#%%? Ausweichen$",
		["Dodge2"] = "^UNUSED$",
		["Dodge3"] = "^UNUSED$",
		["DodgePercent"] = "^Anlegen: Erhöht Eure Chance, einem Angriff auszuweichen, um #%%%.$",
		["DodgeRating"] = "^Anlegen: Erhöht Eure Ausweichwertung um #%.$",
		["DodgeRating2"] = "^UNUSED$",
		["DodgeRatingShort"] = "^%+?#%%? Ausweichwertung$",
		["Dps"] = "^%(# Schaden pro Sekunde%)$",
		["DpsAdd"] = "^Erhöht # Schaden pro Sekunde$",
		["Duration"] = "^Dauer:",
		["Elite"] = "^Elite$",
		["EnchantmentArmorKit"] = "^Verstärkt %(%+# Rüstung%)$",
		["EnchantmentCounterweight"] = "^Gegengewicht %(%+# Tempowertung%)",
		["EnchantmentFieryWeapon"] = "^Feurige Waffe$",
		["EnchantmentHealth"] = "^%+# HP$",
		["EnchantmentHealth2"] = "^%+# Gesundheit$",
		["EnchantmentLivingSteelWeaponChain"] = "^Waffenkette aus lebendigem Stahl$",
		["EnchantmentPyriumWeaponChain"] = "^Pyriumwaffenkette$",
		["EnchantmentTitaniumWeaponChain"] = "^Titanwaffenkette$",
		["Equip"] = "Anlegen:",
		["ExpertiseRating"] = "^Anlegen: Erhöht Eure Waffenkundewertung um #%.$",
		["FeralAp"] = "^Anlegen: %+# Angriffskraft in Katzengestalt, Bärengestalt oder Terrorbärengestalt%.$",
		["FeralApMoonkin"] = "^Anlegen: Erhöht die Angriffskraft in Katzengestalt, Bärengestalt, Terrorbärengestalt oder Mondkingestalt um #%.$",
		["FireResist"] = "^%+?# Feuerwiderstand$",
		["FireSpellDamage"] = "^%+# Feuerzauberschaden$",
		["FireSpellDamage2"] = "^Anlegen: Erhöht durch Feuerzauber und Feuereffekte zugefügten Schaden um bis zu #%.$",
		["FireSpellDamage3"] = "^%+# Feuerschaden$",
		["FistWeapon"] = "^Faustwaffe$",
		["Flexible"] = "^Flexibel$",
		["FrostResist"] = "^%+?# Frostwiderstand$",
		["FrostSpellDamage"] = "^%+# Frostzauberschaden$",
		["FrostSpellDamage2"] = "^Anlegen: Erhöht durch Frostzauber und Frosteffekte zugefügten Schaden um bis zu #%.$",
		["FrostSpellDamage3"] = "^%+# Frostschaden$",
		["Gun"] = "^Schusswaffe$",
		["Haste"] = "^%+?# Tempo$",
		["Haste2"] = "^UNUSED$",
		["HasteRating"] = "^Anlegen: Erhöht die Tempowertung um #%.$",
		["HasteRating2"] = "^UNUSED$",
		["HasteRatingShort"] = "^%+?# Tempowertung$",
		["HaventCollectedAppearance"] = "^Ihr habt diese Vorlage noch nicht gesammelt$",
		["Healing"] = "^%+# Heilzauber$",
		["Healing2"] = "^Anlegen: Erhöht durch Zauber und Effekte verursachte Heilung um bis zu #%.$",
		["Healing3"] = "^%+# Heilung$",
		["HeirloomLevelRange"] = "^Benötigt Stufe %d bis #",
		["HeirloomXpBoost"] = "^Anlegen: Erhaltene Erfahrung",
		["HeirloomXpBoost2"] = "^UNUSED$",
		["Heroic"] = "^Heroisch$",
		["HeroicElite"] = "^Heroisch, Elite$",
		["HeroicThunderforged"] = "^Heroisch, Donnergeschmiedet$",
		["HeroicWarforged"] = "^Heroisch, Kriegsgeschmiedet$",
		["Hit"] = "^Anlegen: Verbessert Eure Trefferchance um #%%%.$",
		["Hit2"] = "^UNUSED$",
		["HitRating"] = "^Anlegen: Erhöht die Trefferwertung um #%.$",
		["HitRating2"] = "^Anlegen: Erhöht Eure Trefferwertung um #%.$",
		["HitRating3"] = "^UNUSED$",
		["HitRatingShort"] = "^%+?# Trefferwertung$",
		["HolySpellDamage"] = "^%+# Heiligzauberschaden$",
		["HolySpellDamage2"] = "^Anlegen: Erhöht durch Heiligzauber und Heiligeffekte zugefügten Schaden um bis zu #%.$",
		["HolySpellDamage3"] = "^UNUSED$",
		["Hp5"] = "^Anlegen: Stellt # Gesundheit alle 5 Sek%. wieder her%.?$",
		["Hp52"] = "^Anlegen: Stellt alle 5 Sek%. # Gesundheit wieder her%.?$",
		["Hp53"] = "^%+?# Gesundheit alle 5 [sS]ek%.?$",
		["Hp54"] = "^%+?# Gesundheit pro 5 [sS]ek%.?$",
		["Hp55"] = "^Alle 5 Sek%. # Gesundheit$",
		["Intellect"] = "^%+?# Intelligenz$",
		["Leather"] = "^Leder$",
		["Leech"] = "^%+# Lebensraub$",
		["Mace"] = "^Streitkolben$",
		["Mail"] = "^Kette$",
		["Mastery"] = "^%+?# Meisterschaft$",
		["Mastery2"] = "^UNUSED$",
		["MetaGemRequirements"] = "|cff%x%x%x%x%x%xBenötigt",
		["MovementSpeed"] = "^%+# Bewegungsgeschwindigkeit$",
		["Mp5"] = "^Anlegen: Stellt alle 5 Sek%. # Mana wieder her%.$",
		["Mp52"] = "^%+?# Mana alle 5 Sek%.$",
		["Mp53"] = "^Alle 5 Sek%. # Mana$",
		["Mp54"] = "^Anlegen: Stellt alle 5 Sek%. # Punkt%(e%) Mana wieder her%.$",
		["Mp55"] = "^UNUSED$",
		["MultiStatHeading"] = "^Mehrere Werte$",
		["MultiStatSeparator1"] = "und",
		["Multistrike"] = "^%+# Mehrfachschlag$",
		["NatureResist"] = "^%+?# Naturwiderstand$",
		["NatureSpellDamage"] = "^%+# Naturzauberschaden$",
		["NatureSpellDamage2"] = "^Anlegen: Erhöht durch Naturzauber und Natureffekte zugefügten Schaden um bis zu #%.$",
		["NatureSpellDamage3"] = "^%+# Naturschaden$",
		["NormalizationEnchant"] = "^Verzaubert: (.*)$",
		["Parry"] = "^%+?# Parieren$",
		["Parry2"] = "^UNUSED$",
		["ParryPercent"] = "^Anlegen: Erhöht Eure Chance, einen Angriff zu parieren, um #%%%.$",
		["ParryRating"] = "^Anlegen: Erhöht Eure Parierwertung um #%.$",
		["ParryRatingShort"] = "^%+?# Parierwertung$",
		["Plate"] = "^Platte$",
		["Polearm"] = "^Stangenwaffe$",
		["PvPPower"] = "^%+?# P[vV]P[- ]Macht$",
		["RaidFinder"] = "^Schlachtzugsbrowser$",
		["Rap"] = "^Anlegen: %+# Distanzangriffskraft%.$",
		["Requires2"] = "^Benötigt",
		["Resilience"] = "^%+?# P[vV]P[- ]Abhärtung$",
		["Resilience2"] = "^UNUSED$",
		["ResilienceRating"] = "^Anlegen: Erhöht Eure Abhärtungswertung um #%.$",
		["ResilienceRatingShort"] = "^%+?# Abhärtungswertung$",
		["Scope"] = "^Zielfernrohr %(%+# Schaden%)$",
		["ScopeCrit"] = "^Zielfernrohr %(%+# kritischer Trefferwert%)$",
		["ScopeRangedCrit"] = "^%+?# kritische Ferntrefferwertung$",
		["ShadowResist"] = "^%+?# Schattenwiderstand$",
		["ShadowSpellDamage"] = "^%+# Schattenzauberschaden$",
		["ShadowSpellDamage2"] = "^Anlegen: Erhöht durch Schattenzauber und Schatteneffekte zugefügten Schaden um bis zu #%.$",
		["ShadowSpellDamage3"] = "^UNUSED$",
		["ShadowSpellDamage4"] = "^%+# Schattenschaden$",
		["Shield"] = "^Schild$",
		["SocketBonusPrefix"] = "Sockelbonus:",
		["Speed"] = "^Geschwindigkeit #$",
		["Speed2"] = "^UNUSED$",
		["SpellCrit"] = "^Anlegen: Erhöht Eure Chance, einen kritischen Treffer durch Zauber zu erzielen, um #%%%.$",
		["SpellCritRating"] = "^Anlegen: Erhöht d?i?e?E?u?r?e? kritische Zaubertrefferwertung um #%.$",
		["SpellCritRating2"] = "^UNUSED$",
		["SpellCritRatingShort"] = "^%+?# Kritische Zaubertrefferwertung$",
		["SpellCritRatingShort2"] = "^UNUSED$",
		["SpellDamage"] = "^%+# Schadenszauber und Heilzauber$",
		["SpellDamage2"] = "^Anlegen: Erhöht durch Zauber und magische Effekte zugefügten Schaden und Heilung um bis zu #%.$",
		["SpellDamage3"] = "^Anlegen: Erhöht durch Zauber und magische Effekte verursachten Schaden und Heilung um bis zu #%.$",
		["SpellDamage4"] = "^UNUSED$",
		["SpellDamage5"] = "^%+?# Zauberschaden und Heilung$",
		["SpellDamageAndHealing"] = "^Anlegen: Erhöht durch sämtliche Zauber und magische Effekte verursachte Heilung um bis zu # und den verursachten Schaden um bis zu #%.$",
		["SpellDamageAndHealing2"] = "^UNUSED$",
		["SpellDamageAndHealingEnchant"] = "^%+# Heilung %+# Zauberschaden$",
		["SpellDamageAndHealingShort"] = "^%+# Heilzauber und %+# Schadenszauber$",
		["SpellDamageAndHealingShort2"] = "^UNUSED$",
		["SpellHasteRating"] = "^Anlegen: Erhöht d?i?e?E?u?r?e? Zaubertempowertung um #%.$",
		["SpellHasteRatingShort"] = "^%+?# Zaubertempowertung$",
		["SpellHit"] = "^Anlegen: Erhöht Eure Chance mit Zaubern zu treffen um #%%%.$",
		["SpellHitRating"] = "^Anlegen: Erhöht Eure Zaubertrefferwertung um #%.$",
		["SpellHitRating2"] = "^Anlegen: Erhöht die Zaubertrefferwertung um #%.$",
		["SpellHitRatingShort"] = "^%+?# Zaubertrefferwertung$",
		["SpellPenetration"] = "^Anlegen: Erhöht d?i?e?E?u?r?e? Zauberdurchschlagskraft um #%.$",
		["SpellPenetrationClassic"] = "^Anlegen: Reduziert die Magiewiderstände der Ziele Eurer Zauber um #%.$",
		["SpellPenetrationShort"] = "^%+?# Zauberdurchschlagskraft$",
		["SpellPower"] = "^%+?# Zaubermacht$",
		["Spirit"] = "^%+?# Willenskraft$",
		["Staff"] = "^Stab$",
		["Stamina"] = "^%+?# Ausdauer$",
		["Strength"] = "^%+?# Stärke$",
		["Sword"] = "^Schwert$",
		["TemporaryBuffMinutes"] = "^.+%(%d+ Min%)$",
		["TemporaryBuffSeconds"] = "^.+%(%d+ Sek%)$",
		["Thrown"] = "^Geworfen$",
		["Thunderforged"] = "^Donnergeschmiedet$",
		["Timeless"] = "^Zeitlos$",
		["Titanforged"] = "^Titanengeschmiedet$",
		["UpgradeLevel"] = "^Verbesserungsstufe:",
		["Use"] = "Benutzen:",
		["Versatility"] = "^%+# Vielseitigkeit$",
		["Wand"] = "^Zauberstab$",
		["Warforged"] = "^Kriegsgeschmiedet$",
		["Warglaives"] = "^Kriegsgleven$",
		["WeaponDamage"] = "^# %- # Schaden$",
		["WeaponDamageArcane"] = "^# %- # Arkanschaden$",
		["WeaponDamageArcaneExact"] = "^# Arkanschaden$",
		["WeaponDamageEnchantment"] = "^%+?# Waffenschaden$",
		["WeaponDamageEquip"] = "^Anlegen: %+?# Waffenschaden%.$",
		["WeaponDamageExact"] = "^# Schaden$",
		["WeaponDamageFire"] = "^# %- # Feuerschaden$",
		["WeaponDamageFireExact"] = "^# Feuerschaden$",
		["WeaponDamageFrost"] = "^# %- # Frostschaden$",
		["WeaponDamageFrostExact"] = "^# Frostschaden$",
		["WeaponDamageHoly"] = "^# %- # Heiligschaden$",
		["WeaponDamageHolyExact"] = "^# Heiligschaden$",
		["WeaponDamageNature"] = "^# %- # Naturschaden$",
		["WeaponDamageNatureExact"] = "^# Naturschaden$",
		["WeaponDamageShadow"] = "^# %- # Schattenschaden$",
		["WeaponDamageShadowExact"] = "^# Schattenschaden$",
	},
}

--PawnLocal.ThousandsSeparator = "."

local L = PawnLocal.TooltipParsing

if PawnLocal.ThousandsSeparator == "NBSP" then PawnLocal.ThousandsSeparator = "\194\160" end
local Key, Value
for Key, Value in pairs(L) do
	L[Key] = gsub(Value, "#", "(-?[%%d%%., ]+)")
end

------------------------------------------------------------
-- Tooltip parsing expressions
------------------------------------------------------------

-- These strings indicate that a given line might contain multiple stats, such as complex enchantments
-- (ZG, AQ) and gems.  These are sorted in priority order.  If a string earlier in the table is present, any
-- string later in the table can be ignored.
PawnSeparators =
{
	", ",
	"/",
	" & ",
	" " .. L.MultiStatSeparator1 .. " ", -- and
}

-- Lines that match any of the following patterns will cause all further tooltip parsing to stop.
PawnKillLines =
{
	"^ \n$", -- The blank line before set items before WoW 2.3
	" %(%d+/%d+%)$", -- The (1/8) on set items for all versions of WoW
}
-- MobInfo-2 compatibility
if MI_LightBlue and MI_TXT_DROPPED_BY then
	tinsert(PawnKillLines, "^" .. MI_LightBlue .. MI_TXT_DROPPED_BY)
end

-- Lines that begin with any of the following strings will not be searched for separator strings.
PawnSeparatorIgnorePrefixes =
{
	'"', -- double quote
	L.Equip,
	L.Use,
	L.ChanceOnHit,
}

-- This is a list of regular expression substitutions that Pawn performs to normalize stat names before running
-- them through the normal gauntlet of expressions.
PawnNormalizationRegexes =
{
	{"^\|c........(.+)$", "%1"}, -- "|cFF 0FF 0Heroic" --> "Heroic"
	{"^([%w%s%.]+) %+(%d+)%%?$", "+%2 %1"}, -- "Stamina +5" --> "+5 Stamina"
	{L.NormalizationEnchant, "%1"}, -- "Enchanted: +50 Strength" --> "+50 Strength" (ENCHANTED_TOOLTIP_LINE)
}

-- These regular expressions are used to parse item tooltips.
-- The first string is the regular expression to match.  Stat values should be denoted with "(%d+)".
-- Subsequent strings follow this pattern: Stat, Number, Source
-- Stat is the name of a statistic.
-- Number is either the amount of that stat to include, or the 1-based index into the matches array produced by the regex.
-- If it's an index, it can also be negative to mean that the stat should be subtracted instead of added.  If nil, defaults to 1.
-- Source is either PawnMultipleStatsFixed if Number is the amount of the stat, or PawnSingleStatMultiplier if Number is an
-- amount of the stat to multiply by the extracted number, or PawnMultipleStatsExtract or nil if Number is the matches array index.
-- Note that certain strings don't need to be translated: for example, the game defines
-- ITEM_BIND_ON_PICKUP to be "Binds when picked up" in English, and the correct string
-- in other languages automatically.
PawnRegexes =
{
	-- ========================================
	-- Common strings that are ignored (rare ones are at the bottom of the file)
	-- ========================================
	{L.HaventCollectedAppearance}, -- You haven't collected this appearance.
	{PawnGameConstant(ITEM_QUALITY0_DESC)}, -- Poor
	{PawnGameConstant(ITEM_QUALITY1_DESC)}, -- Common
	{PawnGameConstant(ITEM_QUALITY2_DESC)}, -- Uncommon
	{PawnGameConstant(ITEM_QUALITY3_DESC)}, -- Rare
	{PawnGameConstant(ITEM_QUALITY4_DESC)}, -- Epic
	{PawnGameConstant(ITEM_QUALITY5_DESC)}, -- Legendary
	{PawnGameConstant(ITEM_QUALITY7_DESC)}, -- Heirloom
	{L.RaidFinder}, -- Raid Finder
	{L.Flexible}, -- Flexible raids
	{L.Heroic}, -- Items from heroic dungeons
	{L.Elite}, -- one version of Regail's Band of the Endless (http://www.wowhead.com/item=90517)
	{L.HeroicElite}, -- one version of Regail's Band of the Endless (http://www.wowhead.com/item=90503)
	{L.Thunderforged}, -- one version of Shoulders of the Crackling Protector (http://ptr.wowhead.com/item=96329)
	{L.HeroicThunderforged}, -- one version of Shoulders of the Crackling Protector (http://ptr.wowhead.com/item=97073)
	{L.Timeless}, -- level 535 version of Ordon Legend-Keeper Spaulders (http://ptr.wowhead.com/item=101925)
	{L.Titanforged}, -- Legion items upgraded 15 item levels or more
	{L.Warforged}, -- level 559 Black Blood of Y'Shaarj (http://www.wowhead.com/item=105399)
	{L.HeroicWarforged}, -- level 572 Black Blood of Y'Shaarj (http://www.wowhead.com/item=105648)
	{"^" .. ITEM_LEVEL}, -- Item Level 200
	{L.UpgradeLevel}, -- Upgrade Level 0/2 (ITEM_UPGRADE_TOOLTIP_FORMAT)
	{PawnGameConstantIgnoredPlaceholder(EQUIPMENT_SETS)}, -- String is from the Blizzard UI, but only used by Outfitter
	{PawnGameConstant(ITEM_UNSELLABLE)}, -- No sell price
	{PawnGameConstant(ITEM_SOULBOUND)}, -- Soulbound
	{PawnGameConstant(ITEM_BIND_ON_EQUIP)}, -- Binds when equipped
	{PawnGameConstant(ITEM_BIND_ON_PICKUP)}, -- Binds when picked up
	{PawnGameConstant(ITEM_BIND_ON_USE)}, -- Binds when used
	{PawnGameConstant(ITEM_BIND_TO_ACCOUNT)}, -- Binds to account
	{PawnGameConstant(ITEM_ACCOUNTBOUND)}, -- Account Bound
	{PawnGameConstant(ITEM_BIND_TO_BNETACCOUNT)}, -- Binds to Battle.net account (Polished Spaulders of Valor)
	{PawnGameConstant(ITEM_BNETACCOUNTBOUND)}, -- Battle.net Account Bound (Polished Spaulders of Valor)
	{"^" .. PawnGameConstantUnwrapped(ITEM_UNIQUE)}, -- Unique; leave off the $ for Unique (20)
	{"^" .. PawnGameConstantUnwrapped(ITEM_UNIQUE_EQUIPPABLE)}, -- Unique-Equipped; leave off the $ for Unique-Equipped: Curios of the Shado-Pan Assault (1)
	{"^" .. PawnGameConstantUnwrapped(ITEM_BIND_QUEST)}, -- Leave off the $ for MonkeyQuest mod compatibility
	{PawnGameConstant(ITEM_STARTS_QUEST)}, -- This Item Begins a Quest
	{L.MultiStatHeading}, -- Multiple stats (Zen Wild Jade)
	{PawnGameConstant(PROFESSIONS_USED_IN_COOKING)}, -- Crafting Reagent
	{PawnGameConstant(ITEM_CONJURED)}, -- Conjured Item
	{PawnGameConstant(ITEM_PROSPECTABLE)}, -- Prospectable
	{PawnGameConstant(ITEM_MILLABLE)}, -- Millable
	{PawnGameConstant(ITEM_DISENCHANT_ANY_SKILL)}, -- Enchantable
	{PawnGameConstant(ITEM_DISENCHANT_NOT_DISENCHANTABLE)}, -- Cannot be disenchanted
	{PawnGameConstantIgnoredPlaceholder(ITEM_PROPOSED_ENCHANT)}, -- Appears in the trade window when an item is about to be enchanted ("Will receive +8 Stamina")
	{L.DisenchantingRequires}, -- Appears on item tooltips when the Disenchant ability is specified ("Disenchanting requires Enchanting (25)")
	{PawnGameConstant(ITEM_ENCHANT_DISCLAIMER)}, -- Item will not be traded!
	{L.Charges}, -- Brilliant Mana Oil
	{PawnGameConstant(LOCKED)}, -- Locked
	{PawnGameConstant(ENCRYPTED)}, -- Encrypted (does not seem to exist in the game yet)
	{PawnGameConstant(ITEM_SPELL_KNOWN)}, -- Already Known
	{PawnGameConstant(INVTYPE_HEAD)}, -- Head
	{PawnGameConstant(INVTYPE_NECK)}, -- Neck
	{PawnGameConstant(INVTYPE_SHOULDER)}, -- Shoulder
	{PawnGameConstant(INVTYPE_CLOAK)}, -- Back
	{PawnGameConstant(INVTYPE_ROBE)}, -- Chest
	{PawnGameConstant(INVTYPE_BODY)}, -- Shirt
	{PawnGameConstant(INVTYPE_TABARD)}, -- Tabard
	{PawnGameConstant(INVTYPE_WRIST)}, -- Wrist
	{PawnGameConstant(INVTYPE_HAND)}, -- Hands
	{PawnGameConstant(INVTYPE_WAIST)}, -- Waist
	{PawnGameConstant(INVTYPE_FEET)}, -- Feet
	{PawnGameConstant(INVTYPE_LEGS)}, -- Legs
	{PawnGameConstant(INVTYPE_FINGER)}, -- Finger
	{PawnGameConstant(INVTYPE_TRINKET)}, -- Trinket
	{PawnGameConstant(MOUNT)}, -- Cenarion War Hippogryph
	{PawnGameConstantIgnoredPlaceholder(ITEM_CLASSES_ALLOWED)}, -- Classes:
	{PawnGameConstantIgnoredPlaceholder(ITEM_RACES_ALLOWED)}, -- Races:
	{PawnGameConstantIgnoredNumberPlaceholder(DURABILITY_TEMPLATE)}, -- Durability X / Y
	{L.Duration},
	{L.CooldownRemaining},
	{"<.+>"}, -- Made by, Right-click to read, etc. (No ^$; can be prefixed by a color)
	{PawnGameConstantIgnoredPlaceholder(ITEM_WRITTEN_BY)}, -- Written by
	{L.BagSlots}, -- Bags of all kinds
	{L.TemporaryBuffSeconds}, -- Temporary item buff
	{L.TemporaryBuffMinutes}, -- Temporary item buff
	{PawnGameConstantIgnoredPlaceholder(ENCHANT_ITEM_REQ_SKILL)}, -- Seen on the enchanter-only ring enchantments when you're not an enchanter, and socketed jewelcrafter-only BoP gems
	{L.Corruption}, -- /pawn compare item:172198::::::::120:262::3:1:3524
	
	-- ========================================
	-- Strings that represent statistics that Pawn cares about
	-- ========================================
	{L.HeirloomLevelRange, "MaxScalingLevel"}, -- Scaling heirloom items
	{L.HeirloomXpBoost, "XpBoost", 1, PawnMultipleStatsFixed}, -- Experience-granting heirloom items
	{L.HeirloomXpBoost2, "XpBoost", 1, PawnMultipleStatsFixed}, -- unused in English
	{PawnGameConstant(INVTYPE_RANGED), "IsRanged", 1, PawnMultipleStatsFixed}, -- Ranged
	{PawnGameConstant(INVTYPE_RANGEDRIGHT), "IsRanged", 1, PawnMultipleStatsFixed}, -- Ranged (but the translation is different in Russian)
	{PawnGameConstant(INVTYPE_WEAPON), "IsOneHand", 1, PawnMultipleStatsFixed}, -- One-Hand
	{PawnGameConstant(INVTYPE_2HWEAPON), "IsTwoHand", 1, PawnMultipleStatsFixed}, -- Two-Hand
	{PawnGameConstant(INVTYPE_WEAPONMAINHAND), "IsMainHand", 1, PawnMultipleStatsFixed}, -- Main Hand
	{PawnGameConstant(INVTYPE_WEAPONOFFHAND), "IsOffHand", 1, PawnMultipleStatsFixed}, -- Off Hand
	{PawnGameConstant(INVTYPE_HOLDABLE), "IsFrill", 1, PawnMultipleStatsFixed}, -- Held In Off-Hand
	{L.WeaponDamage, "MinDamage", 1, PawnMultipleStatsExtract, "MaxDamage", 2, PawnMultipleStatsExtract}, -- Standard weapon (heirlooms can have decimal points in their damage values)
	{L.WeaponDamageExact, "MinDamage", 1, PawnMultipleStatsExtract, "MaxDamage", 1, PawnMultipleStatsExtract}, -- Weapons with no damage range: Crossbow of the Albatross or Fine Light Crossbow, /pawn compare 15808
	{L.WeaponDamageFire, "MinDamage", 1, PawnMultipleStatsExtract, "MaxDamage", 2, PawnMultipleStatsExtract}, -- /pawn compare 19367
	{L.WeaponDamageFireExact, "MinDamage", 1, PawnMultipleStatsExtract, "MaxDamage", 1, PawnMultipleStatsExtract}, -- Wand
	{L.WeaponDamageShadow, "MinDamage", 1, PawnMultipleStatsExtract, "MaxDamage", 2, PawnMultipleStatsExtract}, -- /pawn compare 18301
	{L.WeaponDamageShadowExact, "MinDamage", 1, PawnMultipleStatsExtract, "MaxDamage", 1, PawnMultipleStatsExtract}, -- Battle Medic's Wand
	{L.WeaponDamageNature, "MinDamage", 1, PawnMultipleStatsExtract, "MaxDamage", 2, PawnMultipleStatsExtract}, -- /pawn compare 16997
	{L.WeaponDamageNatureExact, "MinDamage", 1, PawnMultipleStatsExtract, "MaxDamage", 1, PawnMultipleStatsExtract}, -- Wand
	{L.WeaponDamageArcane, "MinDamage", 1, PawnMultipleStatsExtract, "MaxDamage", 2, PawnMultipleStatsExtract}, -- /pawn compare 13938
	{L.WeaponDamageArcaneExact, "MinDamage", 1, PawnMultipleStatsExtract, "MaxDamage", 1, PawnMultipleStatsExtract}, -- Wand
	{L.WeaponDamageFrost, "MinDamage", 1, PawnMultipleStatsExtract, "MaxDamage", 2, PawnMultipleStatsExtract}, -- /pawn compare 19108
	{L.WeaponDamageFrostExact, "MinDamage", 1, PawnMultipleStatsExtract, "MaxDamage", 1, PawnMultipleStatsExtract}, -- Wand
	{L.WeaponDamageHoly, "MinDamage", 1, PawnMultipleStatsExtract, "MaxDamage", 2, PawnMultipleStatsExtract}, -- /pawn compare 22254
	{L.WeaponDamageHolyExact, "MinDamage", 1, PawnMultipleStatsExtract, "MaxDamage", 1, PawnMultipleStatsExtract}, -- Wand
	{L.WeaponDamageEnchantment, "MinDamage", 1, PawnMultipleStatsExtract, "MaxDamage", 1, PawnMultipleStatsExtract}, -- Weapon enchantments
	{L.WeaponDamageEquip, "MinDamage", 1, PawnMultipleStatsExtract, "MaxDamage", 1, PawnMultipleStatsExtract}, -- Braided Eternium Chain (it's an item, not an enchantment)
	{L.Scope, "MinDamage", 1, PawnMultipleStatsExtract, "MaxDamage", 1, PawnMultipleStatsExtract}, -- Ranged weapon scopes
	{L.AllStats, "Strength", 1, PawnMultipleStatsExtract, "Agility", 1, PawnMultipleStatsExtract, "Stamina", 1, PawnMultipleStatsExtract, "Intellect", 1, PawnMultipleStatsExtract, "Spirit", 1, PawnMultipleStatsExtract}, -- Enchanted Pearl, Enchanted Tear, chest enchantments
	{L.Strength, "Strength"},
	{L.Agility, "Agility"},
	{L.Stamina, "Stamina"},
	{L.Intellect, "Intellect"}, -- negative Intellect: Kreeg's Mug
	{L.Spirit, "Spirit"},
	{L.EnchantmentTitaniumWeaponChain, "HasteRating", 28, PawnMultipleStatsFixed}, -- Weapon enchantment; also reduces disarm duration (may be obsolete?)
	{L.EnchantmentPyriumWeaponChain, "HasteRating", 8, PawnMultipleStatsFixed}, -- Weapon enchantment; also reduces disarm duration
	{L.EnchantmentLivingSteelWeaponChain, "CritRating", 13, PawnMultipleStatsFixed}, -- Weapon enchantment; also reduces disarm duration
	{L.Dodge, "DodgeRating"}, -- /pawn compare item:789::::::1754, or Classic arcanum and enchantment: /pawn compare item:19386:2622 /pawn compare item:21693:2545
	{L.Dodge2, "DodgeRating"}, -- unused in English
	{L.Dodge3, "DodgeRating"}, -- unused in English
	{L.DodgePercent, "DodgeRating"}, -- Classic, /pawn compare 11755
	{L.DodgeRating, "DodgeRating"}, -- Burning Crusade Classic, /pawn compare 11755
	{L.DodgeRating2, "DodgeRating"}, -- Burning Crusade Classic, /pawn compare 29323
	{L.DodgeRatingShort, "DodgeRating"}, -- Burning Crusade Classic, /pawn compare item:789::::::1754
	{L.Parry, "ParryRating"},
	{L.Parry2, "ParryRating"}, -- unused in English
	{L.ParryPercent, "ParryRating"}, -- Classic, /pawn compare 19351
	{L.ParryRating, "ParryRating"}, -- Burning Crusade Classic, /pawn compare 19351
	{L.ParryRatingShort, "ParryRating"}, -- Burning Crusade Classic, /pawn compare 24036
	{L.DefenseRating, "DefenseRating"}, -- Burning Crusade, /pawn compare 19867
	{L.DefenseRating2, "DefenseRating"}, -- Burning Crusade esMX or deDE, /pawn compare 29171
	{L.DefenseRatingSimple, "DefenseRating"}, -- Burning Crusade, /pawn compare item:789::::::89
	{L.DefenseSkill, "DefenseRating"}, -- Classic, /pawn compare 19867
	{L.DefenseSkillSimple, "DefenseRating"}, -- Classic, /pawn compare item:789::::::89
	{L.BlockPercent, "BlockRating"}, -- Classic, /pawn compare 18499
	{L.BlockRating, "BlockRating"}, -- Burning Crusade, /pawn compare 18499
	{L.BlockRating2, "BlockRating"}, -- Burning Crusade, /pawn compare 29323
	{L.Block, "BlockValue"}, -- Classic, /pawn compare 18499
	{L.BlockValue, "BlockValue"}, -- Classic, /pawn compare 18499
	{L.Dps}, -- Ignore this; DPS is calculated manually
	{L.DpsAdd, "Dps"},
	{L.EnchantmentFieryWeapon, "Dps", 4, PawnMultipleStatsFixed}, -- weapon enchantment
	{L.Crit, "CritRating"},
	{L.Crit2, "CritRating"},
	{L.CritPercent, "CritRating"}, -- Classic, /pawn compare 15062
	{L.CritRating, "CritRating"}, -- Burning Crusade, /pawn compare 15062
	{L.CritRating2, "CritRating"}, -- Burning Crusade, /pawn compare 30710
	{L.CritRating3, "CritRating"}, -- Burning Crusade, /pawn compare 28796
	{L.CritRatingShort, "CritRating"}, -- Burning Crusade, /pawn compare item:789::::::78
	{L.ScopeCrit, "CritRating"},
	{L.ScopeRangedCrit, "CritRating"}, -- Heartseeker Scope
	{L.SpellCrit, "SpellCritRating"}, -- Classic, /pawn compare 16947
	{L.SpellCritRating, "SpellCritRating"}, -- Burning Crusade, /pawn compare 16947
	{L.SpellCritRating2, "SpellCritRating"}, -- Burning Crusade, /pawn compare 24256
	{L.SpellCritRatingShort, "SpellCritRating"}, -- Burning Crusade, https://tbc.wowhead.com/item=24050/gleaming-dawnstone
	{L.SpellCritRatingShort2, "SpellCritRating"}, -- Burning Crusade, /pawn compare 29317 (socket bonus)
	{L.Hit, "HitRating"}, -- Classic, /pawn compare 16947
	{L.Hit2, "HitRating"}, -- unused in English
	{L.HitRating, "HitRating"}, -- Burning Crusade, /pawn compare 28182
	{L.HitRating2, "HitRating"}, -- Burning Crusade, /pawn compare 18500
	{L.HitRating3, "HitRating"}, -- Burning Crusade in Spanish, /pawn compare 32570
	{L.HitRatingShort, "HitRating"}, -- Burning Crusade, https://tbc.wowhead.com/item=24051/rigid-dawnstone
	{L.SpellHit, "SpellHitRating"}, -- /pawn compare 16795
	{L.SpellHitRating, "SpellHitRating"}, -- Burning Crusade, /pawn compare 16795
	{L.SpellHitRating2, "SpellHitRating"}, -- Burning Crusade, /pawn compare 24266
	{L.SpellHitRatingShort, "SpellHitRating"}, -- Burning Crusade, https://tbc.wowhead.com/item=31861/great-dawnstone
	{L.ExpertiseRating, "ExpertiseRating"}, -- Burning Crusade, /pawn compare 19351
	-- {L.ExpertiseRatingShort, "ExpertiseRating"}, -- Wrath, /pawn compare 39910
	{L.ArmorPenetration, "ArmorPenetration"}, -- Burning Crusade, /pawn compare 34703
	-- {L.ArmorPenetrationShort, "ArmorPenetration"}, -- Wrath, Fractured Scarlet Ruby
	{L.Resilience, "ResilienceRating"}, -- Mystic Dawnstone
	{L.Resilience2, "ResilienceRating"}, -- unused in English
	{L.ResilienceRating, "ResilienceRating"}, -- /pawn compare 29181
	{L.ResilienceRatingShort, "ResilienceRating"}, -- Burning Crusade, https://tbc.wowhead.com/item=24053/mystic-dawnstone
	{L.PvPPower, "Stamina"}, -- Stormy Chalcedony
	{L.EnchantmentCounterweight, "HasteRating"}, -- won't work on classic since the live string includes the word "haste" and it's worded differently in classic
	{L.Haste, "HasteRating"}, -- Leggings of the Betrayed
	{L.Haste2, "HasteRating"}, -- unused in English
	{L.HasteRating, "HasteRating"}, -- Burning Crusade, /pawn compare 32570
	{L.HasteRating2, "HasteRating"}, -- Burning Crusade esES, /pawn compare 32570
	{L.HasteRatingShort, "HasteRating"}, -- Wrath, Quick Sun Crystal / Burning Crusade, random-stat items only
	{L.SpellHasteRating, "SpellHasteRating"}, -- /pawn compare 34360
	{L.SpellHasteRatingShort, "SpellHasteRating"}, -- https://tbc.wowhead.com/item=35315/quick-dawnstone
	{L.SpellPenetration, "SpellPenetration"}, -- Burning Crusade, /pawn compare 21563
	{L.SpellPenetrationClassic, "SpellPenetration"}, -- Classic (pre-TBC), /pawn compare 21338
	{L.SpellPenetrationShort, "SpellPenetration"}, -- Burning Crusade, https://tbc.wowhead.com/item=24039/stormy-star-of-elune
	{L.Mastery, "MasteryRating"}, -- Zen Dream Emerald
	{L.Mastery2, "MasteryRating"}, -- unused in English
	{L.Versatility, "Versatility"}, -- http://wod.wowhead.com/item=100945
	{L.Leech, "Leech"}, -- http://wod.wowhead.com/item=100945
	{L.Avoidance, "Avoidance"}, -- http://wod.wowhead.com/item=100945
	{PawnGameConstant(STAT_STURDINESS), "Indestructible", 1, PawnMultipleStatsFixed}, -- http://wod.wowhead.com/item=100945
	{L.MovementSpeed, "MovementSpeed"}, -- http://wod.wowhead.com/item=100945
	{L.Ap, "Ap"}, -- /pawn compare item:789::::::1547
	{L.Ap2, "Ap"}, -- /pawn compare 15062
	{L.Ap3, "Ap"}, -- /pawn compare 18821
	{L.Rap, "Rap"}, -- /pawn compare 18473
	{L.FeralAp, "FeralAp"}, -- Classic, /pawn compare 22988
	{L.FeralApMoonkin, "FeralAp"}, -- Burning Crusade, /pawn compare 22988
	{L.Mp5, "Mp5"}, -- /pawn compare 22988
	{L.Mp52, "Mp5"}, -- /pawn compare item:789::::::2074
	{L.Mp53, "Mp5"}, -- Burning Crusade, socket bonus on /pawn compare 34360
	{L.Mp54, "Mp5"}, -- Burning Crusade, /script PawnUIGetAllTextForItem("item:24057") and /pawn compare 28522
	{L.Mp55, "Mp5"}, -- Burning Crusade, /pawn compare 28304
	{L.Hp5, "Hp5"}, -- (on live, we used to count 1 HP5 = 3 Stamina)
	{L.Hp52, "Hp5"}, -- Demon's Blood
	{L.Hp53, "Hp5"}, -- Aquamarine Signet of Regeneration or /pawn compare item:789::::::2110
	{L.Hp54, "Hp5"}, -- Lifestone
	{L.Hp55, "Hp5"}, -- /pawn compare item:789::::::-28
	{L.EnchantmentHealth, "Stamina", 1/12.5, PawnSingleStatMultiplier}, -- +100 health head/leg enchantment (counting 1 HP = 1/12.5 Stamina)
	{L.EnchantmentHealth2, "Stamina", 1/12.5, PawnSingleStatMultiplier}, -- +150 health enchantment (counting 1 HP = 1/12.5 Stamina)
	{L.Armor, "Armor"}, -- normal armor and cloak armor enchantments
	{L.Armor2, "Armor"}, -- unused in English
	{L.EnchantmentArmorKit, "Armor"}, -- armor kits
	{L.FireResist, "FireResist"}, -- /pawn compare 12609
	{L.NatureResist, "NatureResist"}, -- /pawn compare 12609
	{L.FrostResist, "FrostResist"}, -- /pawn compare 12609
	{L.ShadowResist, "ShadowResist"}, -- /pawn compare 12609
	{L.ArcaneResist, "ArcaneResist"}, -- /pawn compare 12609
	{L.SpellDamage, "SpellDamage", 1, PawnMultipleStatsExtract, "Healing", 1, PawnMultipleStatsExtract}, -- /pawn compare item:20686::::::2159 ("of Sorcery" on Classic)
	{L.SpellDamage2, "SpellDamage", 1, PawnMultipleStatsExtract, "Healing", 1, PawnMultipleStatsExtract}, -- /pawn compare 16947
	{L.SpellDamage3, "SpellDamage", 1, PawnMultipleStatsExtract, "Healing", 1, PawnMultipleStatsExtract}, -- French on Classic uses two different wordings:  /pawn compare 20641 vs. /pawn compare 10041
	{L.SpellDamage4, "SpellDamage", 1, PawnMultipleStatsExtract, "Healing", 1, PawnMultipleStatsExtract}, -- Simplified Chinese on Classic uses many different wordings:  /pawn compare 16923 vs. /pawn compare 18608
	{L.SpellDamage5, "SpellDamage", 1, PawnMultipleStatsExtract, "Healing", 1, PawnMultipleStatsExtract}, -- Burning Crusade, /pawn compare item:789::::::-36
	{L.SpellDamageAndHealing, "Healing", 1, PawnMultipleStatsExtract, "SpellDamage", 2, PawnMultipleStatsExtract}, -- Burning Crusade, /pawn compare 34360
	{L.SpellDamageAndHealing2, "Healing", 1, PawnMultipleStatsExtract, "SpellDamage", 2, PawnMultipleStatsExtract}, -- Burning Crusade, /pawn compare 28304
	{L.SpellDamageAndHealingEnchant, "Healing", 1, PawnMultipleStatsExtract, "SpellDamage", 2, PawnMultipleStatsExtract}, -- Burning Crusade, /script PawnUIGetAllTextForItem("item:16943:2566") (matches Short in some locales; don't double-dip)
	{L.SpellDamageAndHealingShort, "Healing", 1, PawnMultipleStatsExtract, "SpellDamage", 2, PawnMultipleStatsExtract}, -- Burning Crusade, /pawn compare item:789::::::2041
	{L.SpellDamageAndHealingShort2, "Healing", 1, PawnMultipleStatsExtract, "SpellDamage", 2, PawnMultipleStatsExtract}, -- Burning Crusade, /script PawnUIGetAllTextForItem("item:24060")
	{L.FireSpellDamage, "FireSpellDamage"}, -- /pawn compare item:789::::::1878
	{L.FireSpellDamage2, "FireSpellDamage"}, -- /pawn compare 944
	{L.FireSpellDamage3, "FireSpellDamage"}, -- /pawn compare item:789::::::-22
	{L.ShadowSpellDamage, "ShadowSpellDamage"}, -- /pawn compare item:789::::::1841
	{L.ShadowSpellDamage2, "ShadowSpellDamage"}, -- /pawn compare 1980
	{L.ShadowSpellDamage3, "ShadowSpellDamage"}, -- /pawn compare 19133, zhCN Classic only
	{L.ShadowSpellDamage4, "ShadowSpellDamage"}, -- /pawn compare item:789::::::-25
	{L.NatureSpellDamage, "NatureSpellDamage"}, -- /pawn compare item:789::::::1997
	{L.NatureSpellDamage2, "NatureSpellDamage"}, -- /pawn compare 18829
	{L.NatureSpellDamage3, "NatureSpellDamage"}, -- /pawn compare item:789::::::-24
	{L.ArcaneSpellDamage, "ArcaneSpellDamage"}, -- /pawn compare item:789::::::1801
	{L.ArcaneSpellDamage2, "ArcaneSpellDamage"}, -- /pawn compare 19308
	{L.ArcaneSpellDamage3, "ArcaneSpellDamage"}, -- /pawn compare item:789::::::-21
	{L.FrostSpellDamage, "FrostSpellDamage"}, -- /pawn compare item:789::::::1954
	{L.FrostSpellDamage2, "FrostSpellDamage"}, -- /pawn compare 944
	{L.FrostSpellDamage3, "FrostSpellDamage"}, -- /pawn compare item:789::::::-23
	{L.HolySpellDamage, "HolySpellDamage"},
	{L.HolySpellDamage2, "HolySpellDamage"}, -- /pawn compare 20504
	{L.HolySpellDamage3, "HolySpellDamage"}, -- /pawn compare 30642
	{L.Healing, "Healing"}, -- /pawn compare item:789::::::2028
	{L.Healing2, "Healing"}, -- /pawn compare 16947
	{L.Healing3, "Healing"}, -- Burning Crusade, /pawn compare item:789::::::-38
	{L.SpellPower, "SpellDamage", 1, PawnMultipleStatsExtract, "Healing", 1, PawnMultipleStatsExtract}, -- enchantments
	{PawnGameConstant(EMPTY_SOCKET_RED), "RedSocket", 1, PawnMultipleStatsFixed},
	{PawnGameConstant(EMPTY_SOCKET_YELLOW), "YellowSocket", 1, PawnMultipleStatsFixed},
	{PawnGameConstant(EMPTY_SOCKET_BLUE), "BlueSocket", 1, PawnMultipleStatsFixed},
	{PawnGameConstant(EMPTY_SOCKET_META), "MetaSocket", 1, PawnMultipleStatsFixed},
	{PawnGameConstant(EMPTY_SOCKET_COGWHEEL), "CogwheelSocket", 1, PawnMultipleStatsFixed},
	{PawnGameConstant(EMPTY_SOCKET_PRISMATIC), "PrismaticSocket", 1, PawnMultipleStatsFixed},
	{PawnGameConstant(EMPTY_SOCKET_DOMINATION or "^UNUSED$"), "DominationSocket", 1, PawnMultipleStatsFixed},

	-- In WoW Classic, crossbows, guns, and wands don't show "Ranged" and instead show the weapon type on the left.
	{L.Bow, "IsBow", 1, PawnMultipleStatsFixed, "IsRanged", 1, PawnMultipleStatsFixed},
	{L.Crossbow, "IsCrossbow", 1, PawnMultipleStatsFixed, "IsRanged", 1, PawnMultipleStatsFixed},
	{L.Gun, "IsGun", 1, PawnMultipleStatsFixed, "IsRanged", 1, PawnMultipleStatsFixed},
	{L.Wand, "IsWand", 1, PawnMultipleStatsFixed, "IsRanged", 1, PawnMultipleStatsFixed},
	{L.Thrown, "IsThrown", 1, PawnMultipleStatsFixed, "IsRanged", 1, PawnMultipleStatsFixed},

	-- ========================================
	-- Rare strings that are ignored (common ones are at the top of the file)
	-- ========================================
	{'^"'}, -- Flavor text
	{PawnGameConstantIgnoredPlaceholder(ITEM_MIN_LEVEL)}, -- "Requires Level XX"... but "Requires level XX to YY" we DO care about.
	{PawnGameConstantIgnoredPlaceholder(ITEM_REQ_SKILL)}, -- "Requires SKILL (XX)"
	{L.Requires2}, -- unused in English
}

-- These regexes work exactly the same as PawnRegexes, but they're used to parse the right side of tooltips.
-- Unrecognized stats on the right side are always ignored.
-- Two-handed Axes, Maces, and Swords will have their stats converted to the 2H version later.
PawnRightHandRegexes =
{
	{L.Speed, "Speed"},
	{L.Speed2, "Speed"}, -- unused in English
	{L.Axe, "IsAxe", 1, PawnMultipleStatsFixed},
	{L.Bow, "IsBow", 1, PawnMultipleStatsFixed},
	{L.Crossbow, "IsCrossbow", 1, PawnMultipleStatsFixed},
	{L.Dagger, "IsDagger", 1, PawnMultipleStatsFixed},
	{L.FistWeapon, "IsFist", 1, PawnMultipleStatsFixed},
	{L.Gun, "IsGun", 1, PawnMultipleStatsFixed},
	{L.Mace, "IsMace", 1, PawnMultipleStatsFixed},
	{L.Polearm, "IsPolearm", 1, PawnMultipleStatsFixed},
	{L.Staff, "IsStaff", 1, PawnMultipleStatsFixed},
	{L.Sword, "IsSword", 1, PawnMultipleStatsFixed},
	{L.Warglaives, "IsWarglaive", 1, PawnMultipleStatsFixed},
	{L.Wand, "IsWand", 1, PawnMultipleStatsFixed},
	{L.Cloth, "IsCloth", 1, PawnMultipleStatsFixed},
	{L.Leather, "IsLeather", 1, PawnMultipleStatsFixed},
	{L.Mail, "IsMail", 1, PawnMultipleStatsFixed},
	{L.Plate, "IsPlate", 1, PawnMultipleStatsFixed},
	{L.Shield, "IsShield", 1, PawnMultipleStatsFixed},
}

-- Each language has some regexes that aren't necessary for that particular language. For performance, let's remove those from the table right now.
-- TODO: For even more of a performance boost, filter out every regex that produces a stat that doesn't exist on the current version of the game.
local FilteredRegexes = {}
local _, Regex, LastRegex
local KeptCount, RemovedCount = 0, 0
for _, Regex in pairs(PawnRegexes) do
	if Regex[1] == "" or Regex[1] == "^UNUSED$" then
		RemovedCount = RemovedCount + 1
	elseif Regex[1] == nil then
		VgerCore.Fail("Localization error in regex table for " .. tostring(Regex[2]) .. " AFTER \"" .. VgerCore.Color.Blue .. PawnEscapeString(tostring(LastRegex)) .. "|r\".")
	else
		tinsert(FilteredRegexes, Regex)
		KeptCount = KeptCount + 1
		LastRegex = Regex[1]
	end
end
PawnRegexes = FilteredRegexes
--VgerCore.Message("Performance boost: removed " .. RemovedCount .. " regexes (" .. floor(100 * RemovedCount / (RemovedCount + KeptCount)) .. "%)")





function PawnGetStatsFromTooltip(TooltipName, DebugMessages)
	local Tooltip = _G[TooltipName]
	if DebugMessages == nil then DebugMessages = true end
	
	-- Get the item name.  It could be on line 2 if the first line is "Currently Equipped".
	local ItemName, ItemNameLineNumber = PawnGetItemNameFromTooltip(TooltipName)
	if (not ItemName) or (not ItemNameLineNumber) then
		return
	end

	-- Now, read the tooltip for stats.
	local Stats, SocketBonusStats, UnknownLines = {}, {}, {}
	local HadUnknown = false
	local ItemHasSocketBonus = false
	local SocketBonusIsValid = false
	local UnderstoodAnyLinesYet = false
	local LookForNBSP = GetLocale() == "frFR"

	for i = ItemNameLineNumber + 1, Tooltip:NumLines() do
		local LeftLine = _G[TooltipName .. "TextLeft" .. i]
		local LeftLineText = LeftLine:GetText()
		if not LeftLineText then break end

		-- Look for this line in the "kill lines" list.  If it's there, we're done.
		local IsKillLine = false
		-- Dirty, dirty hack for artifacts: check the color of the text; if it's artifact gold and it's not at the beginning of the tooltip, then treat it as a kill line.
		if i > ItemNameLineNumber + 2 and strfind(LeftLineText, "|cFFE6CC80", 1, true) == 1 then
			IsKillLine = true
		end
		if not IsKillLine then
			local ThisKillLine
			for _, ThisKillLine in pairs(PawnKillLines) do
				if strfind(LeftLineText, ThisKillLine) then
					-- This is a known ignored kill line; stop now.
					IsKillLine = true
					break
				end
			end
		end
		if IsKillLine then break end

		for Side = 1, 2 do
			local CurrentParseText, RegexTable, CurrentDebugMessages, IgnoreErrors
			if Side == 1 then
				CurrentParseText = LeftLineText
				RegexTable = PawnRegexes
				CurrentDebugMessages = DebugMessages
				IgnoreErrors = false
			else
				local RightLine = _G[TooltipName .. "TextRight" .. i]
				CurrentParseText = RightLine:GetText()
				if (not CurrentParseText) or (CurrentParseText == "") then break end
				RegexTable = PawnRightHandRegexes
				CurrentDebugMessages = false
				IgnoreErrors = true
			end

			-- Just for French: replace any non-breaking spaces in the string with regular spaces.
			if LookForNBSP then
				CurrentParseText = gsub(CurrentParseText, "\194\160", " ")
			end

			local ThisLineIsSocketBonus = false
			if Side == 1 and strfind(CurrentParseText, PawnLocal.TooltipParsing.SocketBonusPrefix, 1, true) then
				-- This line is the socket bonus.
				ThisLineIsSocketBonus = true
				ItemHasSocketBonus = true
				if LeftLine.GetTextColor then
					SocketBonusIsValid = (LeftLine:GetTextColor() == 0) -- green's red component is 0, but grey's red component is .5
					if SocketBonusIsValid then
						--PawnDebugMessage("  Socket bonus (valid):")
					else
						--PawnDebugMessage("  Socket bonus (invalid):")
					end
				else
					--PawnDebugMessage(VgerCore.Color.Blue .. "  Socket bonus (not sure if valid):")
					SocketBonusIsValid = true
				end
				CurrentParseText = strsub(CurrentParseText, strlen(PawnLocal.TooltipParsing.SocketBonusPrefix) + 1)
			end

			local Understood
			if ThisLineIsSocketBonus then
				Understood = PawnLookForSingleStat(RegexTable, SocketBonusStats, CurrentParseText, CurrentDebugMessages)
			else
				Understood = PawnLookForSingleStat(RegexTable, Stats, CurrentParseText, CurrentDebugMessages)
			end

            if Understood and not UnderstoodAnyLinesYet then
                -- If this is the first full line on the tooltip we've understood, and there were lines before this that we didn't understand, they don't count.
                -- They were probably things like "Mythic".
                UnderstoodAnyLinesYet = true
                HadUnknown = false
                UnknownLines = {}
            end

			if not Understood then
				-- We don't understand this line.  Let's see if it's a complex stat.
				
				-- First, check to see if it starts with any of the ignore prefixes, such as "Use:".
				local IgnoreLine = false
				local ThisPrefix
				for _, ThisPrefix in pairs(PawnSeparatorIgnorePrefixes) do
					if strfind(CurrentParseText, ThisPrefix, 1, true) == 1 then
						-- We know that this line doesn't contain a complex stat, so ignore it.
						IgnoreLine = true
						--if CurrentDebugMessages then PawnDebugMessage(VgerCore.Color.Blue .. format(PawnLocal.DidntUnderstandMessage, PawnEscapeString(CurrentParseText))) end
						if not Understood and not IgnoreErrors then HadUnknown = true UnknownLines[CurrentParseText] = 1 end
						break
					end
				end

				-- If this line wasn't ignorable, try to break it up.
				if not IgnoreLine then
					-- We'll assume the entire line was understood for now, but if we find any PART that
					-- we don't understand, we'll clear the "understood" flag again.
					Understood = true
					
					local Pos = 1
					local NextPos = 0
					local InnerStatLine = nil
					local InnerUnderstood = nil
					
					while Pos < strlen(CurrentParseText) do
						local ThisSeparator
						for _, ThisSeparator in pairs(PawnSeparators) do
							NextPos = strfind(CurrentParseText, ThisSeparator, Pos, false)
							if NextPos then
								-- One of the separators was found.  Check this string.
								InnerStatLine = strsub(CurrentParseText, Pos, NextPos - 1)
								if ThisLineIsSocketBonus then
									InnerUnderstood = PawnLookForSingleStat(RegexTable, SocketBonusStats, InnerStatLine, CurrentDebugMessages)
								else
									InnerUnderstood = PawnLookForSingleStat(RegexTable, Stats, InnerStatLine, CurrentDebugMessages)
								end
								if not InnerUnderstood then
									-- We don't understand this line.
									Understood = false
									--if CurrentDebugMessages then PawnDebugMessage(VgerCore.Color.Blue .. format(PawnLocal.DidntUnderstandMessage, PawnEscapeString(InnerStatLine))) end
									if not Understood and not IgnoreErrors then HadUnknown = true UnknownLines[InnerStatLine] = 1 end
								end
								-- Regardless of the outcome, advance to the next position.
								Pos = NextPos + strlen(ThisSeparator)
								break
							end -- (if NextPos...)
							-- If we didn't find that separator, continue the for loop to try the next separator.
						end -- (for ThisSeparator...)
						if (Pos > 1) and (not NextPos) then
							-- If there are no more separators left in the string, but we did find one before that, then we have
							-- one last string to check: everything after the last separator.
							InnerStatLine = strsub(CurrentParseText, Pos)
							if ThisLineIsSocketBonus then
								InnerUnderstood = PawnLookForSingleStat(RegexTable, SocketBonusStats, InnerStatLine, CurrentDebugMessages)
							else
								InnerUnderstood = PawnLookForSingleStat(RegexTable, Stats, InnerStatLine, CurrentDebugMessages)
							end
							if not InnerUnderstood then
								-- We don't understand this line.
								Understood = false
								--if CurrentDebugMessages then PawnDebugMessage(VgerCore.Color.Blue .. format(PawnLocal.DidntUnderstandMessage, PawnEscapeString(InnerStatLine))) end
								if not Understood and not IgnoreErrors then HadUnknown = true UnknownLines[InnerStatLine] = 1 end
							end
							break
						elseif not NextPos then
							-- If there are no more separators in the string and we hadn't found any before that, we're done.
							Understood = false
							--if CurrentDebugMessages then PawnDebugMessage(VgerCore.Color.Blue .. format(PawnLocal.DidntUnderstandMessage, PawnEscapeString(CurrentParseText))) end
							if not Understood and not IgnoreErrors then HadUnknown = true UnknownLines[CurrentParseText] = 1 end
							break
						end 
						-- Continue on to the next portion of the string.  The loop ends when we run out of string.
					end -- (while Pos...)
				end -- (if not IgnoreLine...)
			end
		end
	end

	-- Before returning, some stats require special handling.

	if Stats["IsRanged"] and Stats["IsRanged"] > 1 then
		-- Fix for non-Russian locales: INVTYPE_RANGED and INVTYPE_RANGEDRIGHT evaluate to the same thing, so don't count
		-- IsRanged for double.  (In Russian, they're translated differently.)
		Stats["IsRanged"] = 1
	end
	
	if Stats["IsMainHand"] or Stats["IsOneHand"] or Stats["IsOffHand"] or Stats["IsTwoHand"] or Stats["IsRanged"] then
		-- Only perform this conversion if this is an actual weapon.  This works around a problem that occurs when you
		-- enchant your ring with weapon damage and then Pawn would try to calculate DPS for your ring with no Min/MaxDamage.
		local Min = Stats["MinDamage"]
		if not Min then Min = 0 end
		local Max = Stats["MaxDamage"]
		if not Max then Max = 0 end
		if (Min > 0 or Max > 0) and Stats["Speed"] then
			-- Convert damage to DPS if *either* minimum or maximum damage is present.  (A few annoying items
			-- like the Brewfest steins have only max damage.)
			PawnAddStatToTable(Stats, "Dps", (Min + Max) / Stats["Speed"] / 2)
		else
			local WeaponStats = 0
			if Stats["MinDamage"] then WeaponStats = WeaponStats + 1 end
			if Stats["MaxDamage"] then WeaponStats = WeaponStats + 1 end
			if Stats["Speed"] then WeaponStats = WeaponStats + 1 end
			VgerCore.Assert(WeaponStats == 0 or WeaponStats == 3, "Pawn couldn't read speed and damage stats from " .. ItemName .. "; translation problem?")
		end
	end
	
	if Stats["IsMainHand"] then
		PawnAddStatToTable(Stats, "MainHandDps", Stats["Dps"])
		PawnAddStatToTable(Stats, "MainHandSpeed", Stats["Speed"])
		PawnAddStatToTable(Stats, "MainHandMinDamage", Stats["MinDamage"])
		PawnAddStatToTable(Stats, "MainHandMaxDamage", Stats["MaxDamage"])
		PawnAddStatToTable(Stats, "IsMelee", 1)
		Stats["IsMainHand"] = nil
	end

	if Stats["IsShield"] then
		-- Shields aren't off-hand weapons.
		Stats["IsOffHand"] = nil
	end
	if Stats["IsOffHand"] and Stats["Dps"] then
		-- Spanish translates INVTYPE_WEAPONOFFHAND and INVTYPE_HOLDABLE the same, but holdable off-hand frill
		-- items aren't weapons. So only add these stats if the item has DPS, which should be true for all weapons and no off-hand frill items.
		-- (We don't have access to the INVTYPE here.)
		PawnAddStatToTable(Stats, "OffHandDps", Stats["Dps"])
		PawnAddStatToTable(Stats, "OffHandSpeed", Stats["Speed"])
		PawnAddStatToTable(Stats, "OffHandMinDamage", Stats["MinDamage"])
		PawnAddStatToTable(Stats, "OffHandMaxDamage", Stats["MaxDamage"])
		PawnAddStatToTable(Stats, "IsMelee", 1)
	end

	if Stats["IsOneHand"] then
		PawnAddStatToTable(Stats, "OneHandDps", Stats["Dps"])
		PawnAddStatToTable(Stats, "OneHandSpeed", Stats["Speed"])
		PawnAddStatToTable(Stats, "OneHandMinDamage", Stats["MinDamage"])
		PawnAddStatToTable(Stats, "OneHandMaxDamage", Stats["MaxDamage"])
		PawnAddStatToTable(Stats, "IsMelee", 1)
		Stats["IsOneHand"] = nil
	end

	if Stats["IsTwoHand"] then
		PawnAddStatToTable(Stats, "TwoHandDps", Stats["Dps"])
		PawnAddStatToTable(Stats, "TwoHandSpeed", Stats["Speed"])
		PawnAddStatToTable(Stats, "TwoHandMinDamage", Stats["MinDamage"])
		PawnAddStatToTable(Stats, "TwoHandMaxDamage", Stats["MaxDamage"])
		PawnAddStatToTable(Stats, "IsMelee", 1)
		-- Also need to convert weapon stats for two-handed weapons, since two-handed appears on the left and weapon type appears on the right.
		PawnAddStatToTable(Stats, "Is2HAxe", Stats["IsAxe"])
		Stats["IsAxe"] = nil
		PawnAddStatToTable(Stats, "Is2HMace", Stats["IsMace"])
		Stats["IsMace"] = nil
		PawnAddStatToTable(Stats, "Is2HSword", Stats["IsSword"])
		Stats["IsSword"] = nil

		Stats["IsTwoHand"] = nil
	end

	if Stats["IsMelee"] and Stats["IsRanged"] then
		--VgerCore.Fail("Weapon that is both melee and ranged was converted to both Melee* and Ranged* stats")
	end	
	
	if Stats["IsMelee"] then
		PawnAddStatToTable(Stats, "MeleeDps", Stats["Dps"])
		PawnAddStatToTable(Stats, "MeleeSpeed", Stats["Speed"])
		PawnAddStatToTable(Stats, "MeleeMinDamage", Stats["MinDamage"])
		PawnAddStatToTable(Stats, "MeleeMaxDamage", Stats["MaxDamage"])
		Stats["IsMelee"] = nil
	end

	if Stats["IsRanged"] then
		PawnAddStatToTable(Stats, "RangedDps", Stats["Dps"])
		PawnAddStatToTable(Stats, "RangedSpeed", Stats["Speed"])
		PawnAddStatToTable(Stats, "RangedMinDamage", Stats["MinDamage"])
		PawnAddStatToTable(Stats, "RangedMaxDamage", Stats["MaxDamage"])
		Stats["IsRanged"] = nil
	end

	if Stats["MetaSocket"] then
		-- For each meta socket, add credit for meta socket effects.
		-- Enchanted items will get the benefit of meta sockets on their unenchanted version later.
		PawnAddStatToTable(Stats, "MetaSocketEffect", Stats["MetaSocket"])
	end

	-- Now, socket bonuses require special handling.
	if ItemHasSocketBonus then
		if SocketBonusIsValid then
			-- If the socket bonus is valid (green), then just add those stats directly to the main stats table and be done with it.
			--PawnDebugMessage("   (Including socket bonus stats because requirements were met)")
			PawnAddStatsToTable(Stats, SocketBonusStats)
			SocketBonusStats = {}
		else
			-- If the socket bonus is not valid, then we need to check for sockets.
			if Stats["PrismaticSocket"] or Stats["RedSocket"] or Stats["YellowSocket"] or Stats["BlueSocket"] or Stats["MetaSocket"] then
				-- There are sockets left, so the player could still meet the requirements.
				--PawnDebugMessage("   (Socket bonus requirements could potentially be met)")
			else
				-- There are no sockets left and the socket bonus requirements were not met.  Ignore the
				-- socket bonus, since the user purposely chose to mis-socket.
				--PawnDebugMessage("   (Ignoring socket bonus stats since the requirements were not met)")
				SocketBonusStats = {}
			end
		end
	end

	-- Done!
	local _, PrettyLink = Tooltip:GetItem()
	if not HadUnknown then UnknownLines = nil end
	return Stats, SocketBonusStats, UnknownLines, PrettyLink
end




-- Looks for a single string in the regex table, and adds it to the stats table if it finds it.
-- Parameters: Stats, ThisString, DebugMessages
--		RegexTable: The regular expression table to look through.
--		Stats: The stats table to modify if anything is found.
--		ThisString: The string to look for.
--		DebugMessages: If true, debug messages will be shown.
-- Return value: Understood
--		Understood: True if the string was understood (even if empty or ignored), otherwise false.
function PawnLookForSingleStat(RegexTable, Stats, ThisString, DebugMessages)
	-- First, perform a series of normalizations on the string.  For example, "Stamina +5" should
	-- be converted to "+5 Stamina" so we don't need two strings for everything.
	ThisString = strtrim(ThisString)
	local Entry, Count
	for _, Entry in pairs(PawnNormalizationRegexes) do
		local Regex, Replacement = unpack(Entry)
		local OldString = ThisString
		ThisString, Count = gsub(ThisString, Regex, Replacement, 1)
		--if Count > 0 then PawnDebugMessage("Normalized string using \"" .. PawnEscapeString(Regex) .. "\" -- was " .. PawnEscapeString(OldString) .. " and is now " .. PawnEscapeString(ThisString)) end
	end

	-- Now, look for the string in the main regex table.
	local Props, Matches = PawnFindStringInRegexTable(ThisString, RegexTable)
	if not Props then
		-- We don't understand this.  Return false to indicate this, so the caller can handle the case.
		return false
	else
		-- We understand this.  It could either be an ignored line like "Soulbound", or an actual stat.
		-- The same code handles both cases; just keep going until we find a stat of nil; in the ignored case, we hit this immediately.
		local Index = 2
		while true do
			local Stat, Number, Source = Props[Index], tonumber(Props[Index + 1]), Props[Index + 2]
			if not Stat then break end -- There are no more stats left to process.
			if not Number then Number = 1 end
			
			if Source == PawnMultipleStatsExtract or Source == PawnSingleStatMultiplier or Source == nil then
				-- This is a variable number of a stat, the standard case.
				local MatchIndex
				if Source == PawnMultipleStatsExtract then
					MatchIndex = math.abs(Number)
				else
					MatchIndex = 1
				end
				local ExtractedValue = Matches[MatchIndex]
				if not ExtractedValue then
					ExtractedValue = 0
				end
				if Stat ~= "Speed" and (PawnLocal.ThousandsSeparator ~= "" or (PawnLocal.ThousandsSeparator == PawnLocal.DecimalSeparator)) then
					-- Skip this for Speed because Spanish uses the wrong character for speed, and speed would never be >=1,000
					-- In 7.0, Russian also used the comma for both thousands and decimal separators, so use the same logic then.
					-- Remove commas in numbers.  We need to use % in case it's a dot, and we need to 
					-- skip this entirely in case there's no large number separator at all (Spanish).
					ExtractedValue = gsub(ExtractedValue, "%" .. PawnLocal.ThousandsSeparator, "")
				end
				if PawnLocal.DecimalSeparator ~= "." then
					-- If this is the German client or any other version that uses something other than "." for
					-- the decimal separator, we need to substitute here, because tonumber() parses things
					-- in English format only.
					ExtractedValue = gsub(ExtractedValue, PawnLocal.DecimalSeparator, ".")
				end
				if Stat == "Speed" and VgerCore.IsClassic and GetLocale() == "frFR" then
					-- In French WoW Classic, the weapon speed value uses a comma for the decimal even though everything else uses a period.
					-- UGH BLIZZARD WHY MUST YOU DO THIS TO ME
					ExtractedValue = gsub(ExtractedValue, ",", ".")
				end
				ExtractedValue = tonumber(ExtractedValue) -- broken onto multiple lines because gsub() returns multiple values and tonumber accepts multiple arguments
				if Number < 0 then ExtractedValue = -ExtractedValue end
				if Source == PawnSingleStatMultiplier then ExtractedValue = ExtractedValue * Number end
				--if DebugMessages then PawnDebugMessage(format(PawnLocal.FoundStatMessage, ExtractedValue, Stat)) end
				PawnAddStatToTable(Stats, Stat, ExtractedValue)
			elseif Source == PawnMultipleStatsFixed then
				-- This is a fixed number of a stat, such as a socket (1).
				--if DebugMessages then PawnDebugMessage(format(PawnLocal.FoundStatMessage, Number, Stat)) end
				PawnAddStatToTable(Stats, Stat, Number)
			else
				----VgerCore.Fail("Incorrect source value of '" .. Source .. "' for regex: " .. Props[1])
			end
			
			Index = Index + 3
		end
	end

	return true
end

-- Gets the name of an item given a tooltip name, and the line on which the item appears.
-- Normally this is line 1, but it can be line 2 if the first line is "Currently Equipped".
-- Parameters: TooltipName
--		TooltipName: The name of the tooltip to read.
-- Return value: ItemName, LineNumber
--		ItemName: The name of the item in the tooltip, or nil if the tooltip didn't have one.
--		LineNumber: The line number on which the name was found, or nil if no item was found.
function PawnGetItemNameFromTooltip(TooltipName)
	-- First, get the tooltip details.
	local TooltipTopLine = _G[TooltipName .. "TextLeft1"]
	if not TooltipTopLine then return end
	local ItemName = TooltipTopLine:GetText()
	if not ItemName or ItemName == "" or ItemName == RETRIEVING_ITEM_INFO then return end
	
	-- If this is a Currently Equipped tooltip, skip the first line.
	if ItemName == CURRENTLY_EQUIPPED then
		ItemNameLineNumber = 2
		TooltipTopLine = _G[TooltipName .. "TextLeft2"]
		if not TooltipTopLine then return end
		return TooltipTopLine:GetText(), 2
	end
	return ItemName, 1
end

-- Annotates zero or more lines in a tooltip with the name TooltipName, adding a (?) to the end
-- of each line specified by index in the list Lines.
-- Returns true if any lines were annotated.
function PawnAnnotateTooltipLines(TooltipName, Lines)
	-- Temporarily disabling this feature to see if anyone misses it.
	if not PawnCommon.ShowAsterisks then return end

	if not Lines then return false end
	local Annotated = false
	local Tooltip = _G[TooltipName]
	local LineCount = Tooltip:NumLines()
	for i = 2, LineCount do
		local LeftLine = _G[TooltipName .. "TextLeft" .. i]
		if LeftLine then
			local LeftLineText = LeftLine:GetText()
			if Lines[LeftLineText] then
				-- Getting the line text can fail in the following scenario, observable with MobInfo-2:
				-- 1. Other mod modifies a tooltip to include unrecognized text.
				-- 2. Pawn reads the tooltip, noting those unrecognized lines and remembering them so that they
				-- can get marked with (?) later.
				-- 3. Something causes the tooltip to be refreshed.  For example, picking up the item.  All customizations
				-- by Pawn and other mods are lost.
				-- 4. Pawn re-annotates the tooltip with (?) before the other mod has added the lines that are supposed
				-- to get the (?).
				-- In this case, we just ignore the problem and leave off the (?), since we can't really come back later.
				LeftLine:SetText(LeftLineText .. PawnTooltipAnnotation)
				Annotated = true
			end
		end
	end
	return Annotated
end

-- Adds an amount of one stat to a table of stats, increasing the value if
-- it's already there, or adding it if it isn't.
function PawnAddStatToTable(Stats, Stat, Amount)
	if not Amount or Amount == 0 then return end
	if Stats[Stat] then
		Stats[Stat] = Stats[Stat] + Amount
	else
		Stats[Stat] = Amount
	end
end

-- Adds the contents of one stat table to another.
function PawnAddStatsToTable(Dest, Source)
	if not Dest then
		----VgerCore.Fail("PawnAddStatsToTable requires a destination table!")
		return
	end
	if not Source then return end
	for Stat, Quantity in pairs(Source) do
		PawnAddStatToTable(Dest, Stat, Quantity)
	end
end

-- Looks for the first regular expression in a given table that matches the given string.
-- Parameters: String, RegexTable
--		String: The string to look for.
--		RegexTable: The table of regular expressions to look through.
--	Return value: Props, Matches
--		Props: The row from the table with a matching regex.
--		Matches: The array of captured matches.
-- 		Returns nil, nil if no matches were found.
--		Returns {}, {} if the string was ignored.
function PawnFindStringInRegexTable(String, RegexTable)
	if (String == nil) or (String == "") or (String == " ") then return {}, {} end
	local Entry
	for _, Entry in pairs(RegexTable) do
		LastRegex = Entry[1]
		LastStat = Entry[2]
		local StartPos, EndPos, m1, m2, m3, m4, m5 = strfind(String, LastRegex)
		if StartPos then return Entry, { m1, m2, m3, m4, m5 } end
	end
	return nil, nil
end




local MODULE_NAME = "SkuAuras"
local _G = _G
local L = Sku.L


SkuAuras.Components = {}

SkuAuras.Components.unit = {
   player = {},
}
SkuAuras.Components.object = {
   buff = {
      attributes = {
         [1] = {
            name = "name",
            get = function()
            end,
         },
      }
   },
}
SkuAuras.Components.status = {
   received = {},
}
SkuAuras.Components.value = {
   bool = {
      iterator = function()
      end,
   },
}
SkuAuras.Components.action = {
   print = {},
}

--object      subject     status      value    conditionPost     action
--buff (gs)   player      received    true     then              print


--[[
Aura     combatlog
   Received
   Lost
   Time Remaining

   Id
   Name
   Source
   Target
   RemainingSeconds
   Type
   Stacks
Unit     div
   On target change
   On timer

   UnitID
   Name
   HP
   ManaRageEnergy
   ComboPoints
   Attackable
Spell    div
   Ready
   Not ready
   Cooldown remaining

   Id
   Name
   RemainingCooldown
   Ready
   Mana available
Item     div
   Ready
   Not ready
   Cooldown remaining

   Id
   Name
   RemainingCooldown
   Ready
   Equiped


Combat
   timestamp
   subevent
      Prefixes
         SWING
         RANGE
         SPELL
         SPELL_PERIODIC
         SPELL_BUILDING
         ENVIRONMENTAL	
      Suffixes
         _DAMAGE	Triggered on damage to health. Nothing Special. (overkill returns a number greater than or equal to zero)
         _MISSED	Triggered When Effect isn't applied but mana/energy is used IE: ABSORB BLOCK DEFLECT DODGE EVADE IMMUNE MISS PARRY REFLECT RESIST
         _HEAL	Triggered when a unit is healed
         _DISPEL	A buff or debuff being actively dispelled by a spell like Remove Curse or Dispel Magic. The source is the caster of the aura that was dispelled, and the destination is the target which was dispelled (needs verifying).
         _EXTRA_ATTACKS	Unit gains extra melee attacks due to an ability (like Sword Sepcialization or Windfury). These attacks usually happen in brief succession 100-200ms following this event.
         _AURA_APPLIED	Triggered When Buffs/Debuffs are Applied. Note: This event doesn't fire if a debuff is applied twice without being removed. IE: casting Vampiric Embrace twice in a row only triggers this event once. This can make it difficult to track whether a debuff was successfully reapplied to the target. However, for instant cast spells, SPELL_CAST_SUCCESS can be used.
         _AURA_REMOVED


   hideCaster
   sourceGUID
   sourceName
   sourceFlags
   sourceRaidFlags
   destGUID
   destName
   destFlags
   destRaidFlags




conditionPreObject	   status     is     value    conditionPost	action
If	         player	   Bereit	         wahr     dann	         sagen
If not	   party (1-4)	Nicht bereit	   false    dann nicht	   sound
While	      target	   Vorhanden	      x
Until    	pet	      Nicht vorhanden   
            item        erhalten			
            spell       verloren			
            zone        in range x			
            aura        in combat			
                        not in combat
                        enthält

SkuAuras.Data = {}
SkuAuras.Data.AuraComponents = {
   ConditionPre = {
      ["wenn"] = {
         code = "if",
      }.
      ["wenn nicht"] = {
         code = "if not",
      }.
   },
   Object = {
      ["player"] = {
         code = {
            name = function()
               return UnitName("player")
            end,
            },
         },
      }.
   },
   Status = {





   },
   ConditionPost = {},
   Action = {},
}
]]

local MODULE_NAME = "SkuAuras"
local _G = _G
local L = Sku.L

--[[
conditionPreObject	   status      bool     conditionPost	action
If	         player	   Bereit	         wahr     dann	         sagen
If not	   party (1-4)	Nicht bereit	   false    dann nicht	   sound
While	      target	   Vorhanden	      
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

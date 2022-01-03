------------------------------------------------------------------------------------------------------------------
SkuAuras.DefaultAuras = {
   ["typ;aura;wenn;zauber gleich arkane intelligenz;und;ziel einheit gleich spieler;dann;audio benachrichtigung bing;"] = {
      type = "spell",
      enabled = true,
      attributes = {
         spellId = {
            [1] = {
               [1] = "is",               
               [2] = "1459",               
            },
         },
         destUnitId = {
            [1] = {
               [1] = "is",               
               [2] = "player",
            },
         },
         event = {
            [1] = {
               [1] = "is",               
               [2] = "SPELL_AURA_APPLIED;SPELL_AURA_REFRESH",               
            },
         },
      },
      actions = {
         [1] = "notifyAudioBing",
      },
      outputs = {
      },
   },
}
--setmetatable(SkuAuras.DefaultAuras, SkuPrintMTWo)

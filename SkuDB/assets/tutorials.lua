local L = Sku.L

SkuDB.Tutorials = {
   prefix = "Sku",
   deDE = {
      --[[
      ["tutorial step one"] = {
         steps = {
            [1] = {
               title = "step one title text",
               allTriggersRequired = true,
               triggers = {
                  [1] = {
                     type = "GAME_EVENT",
                     value = 84,
                  },
                  [2] = {
                     type = "KEY_PRESS",
                     value = 54,
                  },                  
               },
               beginText = "step one output text",
            },
         },
      },
      ]]
   },
   enUS = {
   },
}
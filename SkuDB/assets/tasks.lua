local L = Sku.L

SkuDB.Tasks = {
   [L["Das Auge von Acherus unterliegt Eurer Kontrolle."]] = {
      [1] = {action = "turn", triggers = {"TurnLeftStop", "TurnRightStop",}, value = 114, comment = L["Nur die tasten für vorwärts, links drehen und rechts drehen verwenden! auf keinen fall andere bewegungstasten verwenden!"]},
      [2] = {action = "forward", triggers = {"MoveForwardStart", "MoveForwardStop"}, value = 3.4, comment = L["dann aktion 1 verwenden"]},
      [3] = {action = "turn", triggers = {"TurnLeftStop", "TurnRightStop",}, value = 12, comment = nil},
      [4] = {action = "forward", triggers = {"MoveForwardStart", "MoveForwardStop"}, value = 5.1, comment = L["dann aktion 1 verwenden"]},
      [5] = {action = "turn", triggers = {"TurnLeftStop", "TurnRightStop",}, value = 291, comment = nil},
      [6] = {action = "forward", triggers = {"MoveForwardStart", "MoveForwardStop"}, value = 8.9, comment = L["dann aktion 1 verwenden"]},
      [7] = {action = "turn", triggers = {"TurnLeftStop", "TurnRightStop",}, value = 342, comment = nil},
      [8] = {action = "forward", triggers = {"MoveForwardStart", "MoveForwardStop"}, value = 6.2, comment = L["dann aktion 1 verwenden, und dann aktion 5 verwenden"]},
      endTriggers = {"LOADING_SCREEN_ENABLED",},
   },
   [L["Avoid incoming Scarlet Crusade arrows and Javelins by moving out of their line of fire!"]] = {
      [1] = {action = "pitchEndless", triggers = {"PitchDownStop", "PitchUpStop",}, value = 10.45, comment = L["Important: For this quest, first go to Sku Discord and read the post about the quest \"An End To All Things...\" that is pinned in the General channel"]},
      endTriggers = {"UNIT_EXITED_VEHICLE",},
   },
}

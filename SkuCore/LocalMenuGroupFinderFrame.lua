---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME, MODULE_PART = "SkuCore", "LocalMenu"
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

local tSkuCurrentTitleText = ""
local tCurrentActivityName = ""
local tSkuCurrentDescriptionText = ""
local tSkuCurrentItemLevelText = ""
local tSkuCurrentVoiceChatText = ""
local tSkuCurrentPrivateChecked = false


---------------------------------------------------------------------------------------------------------------------------------------
-- helpers
---------------------------------------------------------------------------------------------------------------------------------------
local function GetButtonTooltipLines(aButtonObj, aTooltipObject)

	local tTooltipObj = aTooltipObject or GameTooltip

	if not aTooltipObject then
		GameTooltip:ClearLines()
		if aButtonObj.type then
			if aButtonObj.type ~= "" then
				if aButtonObj:GetScript("OnEnter") then
					aButtonObj:GetScript("OnEnter")(aButtonObj)
				end
			end
		end
	end

	local tQualityString = nil
	local itemName, ItemLink = tTooltipObj:GetItem()
	local tEffectiveILvl

	if not itemName then
		itemName, ItemLink = tTooltipObj:GetSpell()
	end

	if ItemLink then
		for x = 0, #ITEM_QUALITY_COLORS do
			local tItemCol = ITEM_QUALITY_COLORS[x].color:GenerateHexColor()
			if tItemCol == "ffa334ee" then 
				tItemCol = "ffa335ee"
			end
			if string.find(ItemLink, tItemCol) then
				if _G["ITEM_QUALITY"..x.."_DESC"] then
					tQualityString = _G["ITEM_QUALITY"..x.."_DESC"]
				end
			end
		end
		tEffectiveILvl = GetDetailedItemLevelInfo(ItemLink)
	end

	local tTooltipText = ""
	local tLineCounter = 1
	for i = 1, select("#", tTooltipObj:GetRegions()) do
		local region = select(i, tTooltipObj:GetRegions())
		if region and region:GetObjectType() == "FontString" then
			local text = region:GetText() -- string or nil
			if text then
				if tLineCounter == 1 and tQualityString and SkuOptions.db.profile["SkuCore"].itemSettings.ShowItemQality == true then
					tTooltipText = tTooltipText..text.." ("..tQualityString..")\r\n"
				elseif tLineCounter == 2 and tEffectiveILvl then
					tTooltipText = tTooltipText..L["Item Level"]..": "..tEffectiveILvl.."\r\n"
					tTooltipText = tTooltipText..text.."\r\n"
				else
					tTooltipText = tTooltipText..text.."\r\n"
				end
				tLineCounter = tLineCounter + 1
			end
		end
	end

	if not aTooltipObject then
		tTooltipObj:SetOwner(UIParent, "Center")
		tTooltipObj:Hide()
		if aButtonObj:GetScript("OnLeave") then
			aButtonObj:GetScript("OnLeave")(aButtonObj)
		end
	end
	
	if tTooltipText ~= "asd" then
		if tTooltipText ~= "" then
			tTooltipText = SkuChat:Unescape(tTooltipText)
			if tTooltipText then
				local tText, tTextf = SkuCore:ItemName_helper(tTooltipText)
				return tText, tTextf, ItemLink
			end
		end
	end

	return "", ""
end



function SkuCore:LFDRoleCheckPopupFrame(aParentChilds)

   table.insert(aParentChilds, "Roles")
   aParentChilds["Roles"] = {
      frameName = "",
      RoC = "Child",
      type = "Button",
      --obj = _G["GroupFinderFrame"],
      textFirstLine = "Roles",
      textFull = "",
      childs = {},
   }      

   local tParentRoles = aParentChilds["Roles"].childs
   local tEnlistRole = {
      [1] = {name = _G["TANK"], selected = false, buttonName = "LFDRoleCheckPopupRoleButtonTank"},
      [2] = {name = _G["HEALER"], selected = false, buttonName = "LFDRoleCheckPopupRoleButtonHealer"},
      [3] = {name = _G["DAMAGER"], selected = false, buttonName = "LFDRoleCheckPopupRoleButtonDPS"},
      --[4] = {name = L["leader"], selected = false, buttonName = "LFDQueueFrameRoleButtonLeader"},
   }
   for x = 1, #tEnlistRole do
      if _G[tEnlistRole[x].buttonName].checkButton:IsVisible() == true then
         local tText = tEnlistRole[x].name
         if _G[tEnlistRole[x].buttonName].checkButton:GetChecked() == true then
            tText = tText.." ("..L["checked"]..")"
         else
            tText = tText.." ("..L["not checked"]..")"
         end

         table.insert(tParentRoles, tEnlistRole[x].name)
         tParentRoles[tEnlistRole[x].name] = {
            frameName = tEnlistRole[x].buttonName,
            RoC = "Child",
            type = "Button",
            obj = _G[tEnlistRole[x].buttonName].checkButton,
            textFirstLine = tText,
            textFull = "",
            childs = {},
            func = function()
               --[[
               local mode, subMode = GetLFGMode(LE_LFG_CATEGORY_LFD);
               print("mode, subMode", mode, subMode)
               if mode == "queued" or mode == "listed" then
                  print("no change whiele queued or listed")
               else
                  ]]
                  _G[tEnlistRole[x].buttonName].checkButton:Click()
                  C_Timer.After(0.3, function()
                     SkuOptions.currentMenuPosition.parent:OnUpdate()
                  end)
               --end
            end,            
            click = true,            
         }
      end    
   end   

   table.insert(aParentChilds, "LFDRoleCheckPopupFrameConfirm")
   aParentChilds["LFDRoleCheckPopupFrameConfirm"] = {
      frameName = "",
      RoC = "Child",
      type = "Button",
      textFirstLine = "Confirm",
      childs = {},
      func = function()
         LFDRoleCheckPopupAcceptButton:Click()
         C_Timer.After(0.3, function()
            SkuOptions:SlashFunc(L["short"]..","..L["Local"])
            C_Timer.After(0.1, function()
               SkuOptions.currentMenuPosition:OnUpdate()
            end)
         end)
      end,            
   }  

   table.insert(aParentChilds, "LFDRoleCheckPopupDeclineButton")
   aParentChilds["LFDRoleCheckPopupDeclineButton"] = {
      frameName = "",
      RoC = "Child",
      type = "Button",
      textFirstLine = "Cancel",
      childs = {},
      func = function()
         LFDRoleCheckPopupDeclineButton:Click()
         C_Timer.After(0.3, function()
            SkuOptions:SlashFunc(L["short"]..","..L["Local"])
            C_Timer.After(0.1, function()
               SkuOptions.currentMenuPosition:OnUpdate()
            end)
         end)
      end,            
   }  

end


function SkuCore:LFGListCreateRoleDialogFrame(aParentChilds)

   table.insert(aParentChilds, "Roles")
   aParentChilds["Roles"] = {
      frameName = "",
      RoC = "Child",
      type = "Button",
      --obj = _G["GroupFinderFrame"],
      textFirstLine = "Roles",
      textFull = "",
      childs = {},
   }      

   local tParentRoles = aParentChilds["Roles"].childs
   local tEnlistRole = {
      [1] = {name = _G["TANK"], selected = false, buttonName = "TankButton"},
      [2] = {name = _G["HEALER"], selected = false, buttonName = "HealerButton"},
      [3] = {name = _G["DAMAGER"], selected = false, buttonName = "DamagerButton"},
      --[4] = {name = L["leader"], selected = false, buttonName = "LFDQueueFrameRoleButtonLeader"},
   }
   for x = 1, #tEnlistRole do
      if _G["LFGListCreateRoleDialog"][tEnlistRole[x].buttonName].CheckButton:IsVisible() == true then
         local tText = tEnlistRole[x].name
         if _G["LFGListCreateRoleDialog"][tEnlistRole[x].buttonName].CheckButton:GetChecked() == true then
            tText = tText.." ("..L["checked"]..")"
         else
            tText = tText.." ("..L["not checked"]..")"
         end

         table.insert(tParentRoles, tEnlistRole[x].name)
         tParentRoles[tEnlistRole[x].name] = {
            frameName = tEnlistRole[x].buttonName,
            RoC = "Child",
            type = "Button",
            obj = _G["LFGListCreateRoleDialog"][tEnlistRole[x].buttonName].CheckButton,
            textFirstLine = tText,
            textFull = "",
            childs = {},
            func = function()
               --[[
               local mode, subMode = GetLFGMode(LE_LFG_CATEGORY_LFD);
               print("mode, subMode", mode, subMode)
               if mode == "queued" or mode == "listed" then
                  print("no change whiele queued or listed")
               else
                  ]]
                  _G["LFGListCreateRoleDialog"][tEnlistRole[x].buttonName].CheckButton:Click()
                  C_Timer.After(0.3, function()
                     SkuOptions.currentMenuPosition.parent:OnUpdate()
                  end)
               --end
            end,            
            click = true,            
         }
      end
   end   

   table.insert(aParentChilds, "LFGListCreateRoleDialogConfirm")
   aParentChilds["LFGListCreateRoleDialogConfirm"] = {
      frameName = "",
      RoC = "Child",
      type = "Button",
      textFirstLine = "Confirm",
      childs = {},
      func = function()
         LFGListCreateRoleDialog.SignUpButton:Click()
         C_Timer.After(0.3, function()
            SkuOptions:SlashFunc(L["short"]..","..L["Local"])
            C_Timer.After(0.1, function()
               SkuOptions.currentMenuPosition:OnUpdate()
            end)
         end)
      end,            
   }  

   table.insert(aParentChilds, "LFGListCreateRoleDialogDeclineButton")
   aParentChilds["LFGListCreateRoleDialogDeclineButton"] = {
      frameName = "",
      RoC = "Child",
      type = "Button",
      textFirstLine = "Cancel",
      childs = {},
      func = function()
         LFGListCreateRoleDialog.CancelButton:Click()
         C_Timer.After(0.3, function()
            SkuOptions:SlashFunc(L["short"]..","..L["Local"])
            C_Timer.After(0.1, function()
               SkuOptions.currentMenuPosition:OnUpdate()
            end)
         end)
      end,            
   }     
end



function SkuCore:Build_GroupFinderFrame(aParentChilds)
   local GroupFinderFrame = _G["GroupFinderFrame"]
   local LFDQueueFrame = _G["LFDQueueFrame"]
   --local RaidFinderFrame = _G["RaidFinderFrame"]
   local LFGListFrame = _G["LFGListFrame"]

   SkuCore:Build_LFDQueueFrame(aParentChilds)
   SkuCore:Build_LFDListFrame(aParentChilds)

end

function SkuCore:Build_LFDQueueFrame(aParentChilds)
   local GroupFinderFrame = _G["GroupFinderFrame"]
   local LFDQueueFrame = _G["LFDQueueFrame"]

   if LFDQueueFrame then
      local tLfdType


      table.insert(aParentChilds, L["LFD Queue Frame"])
      aParentChilds[L["LFD Queue Frame"]] = {
         frameName = "LFDQueueFrame",
         RoC = "Child",
         --RoC = "Region",
         type = "Button",
         obj = _G["LFDQueueFrame"],
         textFirstLine = L["LFD Queue Frame"],
         textFull = "",
         childs = {},
         onEnter = function()
            --print("onEnter")
            --_G["GroupFinderFrameGroupButton1"]:Click()
         end,
         --[[
         func = function()
            print("func LFD Queue Frame")
            C_Timer.After(0.3, function()
               SkuOptions.currentMenuPosition.parent:OnUpdate()
            end)
         end,            
         click = true,
         ]]
      }

      local tParentLFD = aParentChilds[L["LFD Queue Frame"]].childs


      if _G["LFDQueueFrame"]:IsVisible() == false then
         table.insert(tParentLFD, "SelectLFDQueueFrame")
         tParentLFD["SelectLFDQueueFrame"] = {
            frameName = "",
            RoC = "Child",
            type = "Button",
            --obj = _G["GroupFinderFrameGroupButton1"],
            textFirstLine = L["Select"],
            childs = {},
            func = function()
               _G["GroupFinderFrameGroupButton1"]:Click()
               C_Timer.After(0.3, function()
                  SkuOptions.currentMenuPosition:OnUpdate()
               end)
            end,            
            --click = true,            
         }  
      else




         --roles
         table.insert(tParentLFD, L["Roles"])
         tParentLFD[L["Roles"]] = {
            frameName = "",
            RoC = "Child",
            type = "Button",
            --obj = _G["GroupFinderFrame"],
            textFirstLine = L["Roles"],
            textFull = "",
            childs = {},
         }      

         local tParentRoles = tParentLFD[L["Roles"]].childs
         local tEnlistRole = {
            [1] = {name = _G["TANK"], selected = false, buttonName = "LFDQueueFrameRoleButtonTank"},
            [2] = {name = _G["HEALER"], selected = false, buttonName = "LFDQueueFrameRoleButtonHealer"},
            [3] = {name = _G["DAMAGER"], selected = false, buttonName = "LFDQueueFrameRoleButtonDPS"},
            [4] = {name = L["leader"], selected = false, buttonName = "LFDQueueFrameRoleButtonLeader"},
         }
         for x = 1, #tEnlistRole do
            local tText = tEnlistRole[x].name
            if _G[tEnlistRole[x].buttonName].permDisabled == true then
               tText = tText.." ("..L["disabled"]..")"
            else
               if _G[tEnlistRole[x].buttonName].checkButton:GetChecked() == true then
                  tText = tText.." ("..L["checked"]..")"
               else
                  tText = tText.." ("..L["not checked"]..")"
               end
            end

            table.insert(tParentRoles, tEnlistRole[x].name)
            tParentRoles[tEnlistRole[x].name] = {
               frameName = tEnlistRole[x].buttonName,
               RoC = "Child",
               type = "Button",
               obj = _G[tEnlistRole[x].buttonName].checkButton,
               textFirstLine = tText,
               textFull = "",
               childs = {},
               func = function()
                  local mode, subMode = GetLFGMode(LE_LFG_CATEGORY_LFD);
                  --print("mode, subMode", mode, subMode)
                  if mode == "queued" or mode == "listed" then
                     print("no change while queued or listed")
                  else
                     if _G[tEnlistRole[x].buttonName].permDisabled ~= true then
                        _G[tEnlistRole[x].buttonName].checkButton:Click()
                        C_Timer.After(0.3, function()
                           SkuOptions.currentMenuPosition.parent:OnUpdate()
                        end)
                     end
                  end
               end,            
               click = true,            
            }     
         end

         --dungeon types
         local tSelectedValue = UIDropDownMenu_GetSelectedValue(_G["LFDQueueFrameTypeDropDown"]) or "nil"
         local tSelectedName = L["specific"]
         if tSelectedValue then
            if type(tSelectedValue) == "number" then
               tSelectedName = GetLFGDungeonInfo(tSelectedValue) --typeID, subtypeID, minLevel, maxLevel, recLevel, minRecLevel, maxRecLevel, expansionLevel, groupID, textureFilename, difficulty, maxPlayers, description, isHoliday, _, _, isTimeWalker 
            end
         end

         local tHasSelection = false

         local mode, subMode = GetLFGMode(LE_LFG_CATEGORY_LFD);
         if mode == nil or (  mode ~= "rolecheck" and mode ~= "suspended" ) then
            --print("tSelectedValue", tSelectedValue, "tSelectedName", tSelectedName)
            table.insert(tParentLFD, "Type")
            tParentLFD["Type"] = {
               frameName = "",
               RoC = "Child",
               type = "Button",
               --obj = _G["GroupFinderFrame"],
               textFirstLine = "Type".." ("..tSelectedName.." "..tSelectedValue..")",
               textFull = "",
               childs = {},
            }      

            local tParentType = tParentLFD["Type"].childs
            table.insert(tParentType, "Specific")
            tParentType["Specific"] = {
               frameName = "",
               RoC = "Child",
               type = "Button",
               --obj = "",
               textFirstLine = "Specific",
               childs = {},
               func = function()
                  local mode, subMode = GetLFGMode(LE_LFG_CATEGORY_LFD);
                  --print("mode, subMode", mode, subMode)
                  if mode == "queued" or mode == "listed" then
                     print("No changes possible while queued or listed")
                  else
                     LFDQueueFrame_SetType("specific");
                  end
                  C_Timer.After(0.3, function()
                     SkuOptions.currentMenuPosition.parent:OnUpdate()
                  end)
               end,            
               --click = true,            
            }    

            for i=1, GetNumRandomDungeons() do
               local id, name = GetLFGRandomDungeonInfo(i);
               local isAvailableForAll, isAvailableForPlayer, hideIfNotJoinable = IsLFGDungeonJoinable(id);
               if isAvailableForPlayer or not hideIfNotJoinable then
                  if isAvailableForAll then
                     table.insert(tParentType, name)
                     tParentType[name] = {
                        frameName = "",
                        RoC = "Child",
                        type = "Button",
                        --obj = "",
                        textFirstLine = name.." "..id,
                        childs = {},
                        func = function()
                           local mode, subMode = GetLFGMode(LE_LFG_CATEGORY_LFD);
                           --print("mode, subMode", mode, subMode)
                           if mode == "queued" or mode == "listed" then
                              print("No changes possible while queued or listed")
                           else
                              LFDQueueFrame_SetType(id);
                           end
                           C_Timer.After(0.3, function()
                              SkuOptions.currentMenuPosition.parent:OnUpdate()
                           end)
                        end,            
                        --click = true,            
                     }                   
                  else
                     table.insert(tParentType, name)
                     tParentType[name] = {
                        frameName = "",
                        RoC = "Child",
                        type = "Button",
                        --obj = "",
                        textFirstLine = name.." "..id.." "..YOU_MAY_NOT_QUEUE_FOR_THIS,
                        childs = {},
                        func = function()
                           local mode, subMode = GetLFGMode(LE_LFG_CATEGORY_LFD);
                           if mode == "queued" or mode == "listed" then
                              print("no change while queued or listed")
                           else
                              LFDQueueFrame_SetType(id);
                           end
                           C_Timer.After(0.3, function()
                              SkuOptions.currentMenuPosition.parent:OnUpdate()
                           end)
                        end,            
                        --click = true,            
                     }                     
                  end
               end
            end      

            --dungeon specific selection
            if tSelectedValue == "specific" then
               table.insert(tParentLFD, "tParentSpecificList")
               tParentLFD["tParentSpecificList"] = {
                  frameName = "",
                  RoC = "Child",
                  type = "Button",
                  --obj = _G["GroupFinderFrame"],
                  textFirstLine = "Specific dungeon selection",
                  textFull = "",
                  childs = {},
               }      

               local tParentSpecificList = tParentLFD["tParentSpecificList"].childs
               for x = 1, #LFDQueueFrameSpecific.ScrollBox.view.dataProvider.collection do
                  local displayName = select(LFG_RETURN_VALUES.name, GetLFGDungeonInfo(LFDQueueFrameSpecific.ScrollBox.view.dataProvider.collection[x].dungeonID));
                  local name, typeID, subtypeID, minLevel, maxLevel, recLevel, minRecLevel, maxRecLevel, expansionLevel, groupID, textureFilename, difficulty, maxPlayers, description, isHoliday, bonusRepAmount, minPlayers, isTimeWalker, name2, minGearLevel, isScalingDungeon, lfgMapID = GetLFGDungeonInfo(LFDQueueFrameSpecific.ScrollBox.view.dataProvider.collection[x].dungeonID)
                  local tChecked = ""
                  --print(x, LFDQueueFrameSpecific.ScrollBox.view.dataProvider.collection[x].dungeonID, LFGEnabledList[LFDQueueFrameSpecific.ScrollBox.view.dataProvider.collection[x].dungeonID])
                  --print(name, typeID, subtypeID, minLevel, maxLevel, recLevel, minRecLevel, maxRecLevel, expansionLevel, "groupID", groupID, textureFilename, difficulty, maxPlayers, description, isHoliday, bonusRepAmount, minPlayers, isTimeWalker, name2, minGearLevel, isScalingDungeon, lfgMapID)
                  if LFGEnabledList then
                     if LFGEnabledList[LFDQueueFrameSpecific.ScrollBox.view.dataProvider.collection[x].dungeonID] and LFGEnabledList[LFDQueueFrameSpecific.ScrollBox.view.dataProvider.collection[x].dungeonID] == true then
                        tChecked = "checked"
                        tHasSelection = true
                     end
                  end

                  local tLocked = "LOCKED"
                  if not LFGLockList[LFDQueueFrameSpecific.ScrollBox.view.dataProvider.collection[x].dungeonID] then --or not LFGLockList[LFDQueueFrameSpecific.ScrollBox.view.dataProvider.collection[x].dungeonID].hideEntry then
                     tLocked = ""
                  end

                  local tHeader = ""
                  if LFDQueueFrameSpecific.ScrollBox.view.dataProvider.collection[x].dungeonID < 0 then
                     tHeader = "KATEGORIE"
                  end

                  local tName = x..";"..tLocked..";"..tHeader..";"..displayName..";"..tChecked,-- .." - " ..(groupID or LFDQueueFrameSpecific.ScrollBox.view.dataProvider.collection[x].dungeonID).." - "..tLocked.." "..tHeader.." "..displayName.." "..LFDQueueFrameSpecific.ScrollBox.view.dataProvider.collection[x].dungeonID.." ("..tChecked..")", --" "..LFDQueueFrameSpecific.ScrollBox.view.dataProvider.collection[x].dungeonID..
                  table.insert(tParentSpecificList, x..displayName)
                  tParentSpecificList[x..displayName] = {
                     frameName = "",
                     RoC = "Child",
                     type = "Button",
                     --obj = "",
                     textFirstLine = tName,
                     childs = {},
                     func = function()
                        local mode, subMode = GetLFGMode(LE_LFG_CATEGORY_LFD);
                        --print("mode, subMode", mode, subMode)
                        if mode == "queued" or mode == "listed" then
                           print("No changes possible while queued or listed")
                        else
                           local dungeonID = LFDQueueFrameSpecific.ScrollBox.view.dataProvider.collection[x].dungeonID
                           local category = LE_LFG_CATEGORY_LFD
                           local isChecked = tChecked == ""
                           local dungeonList, hiddenByCollapseList = LFDDungeonList, LFDHiddenByCollapseList
                           if ( LFGIsIDHeader(dungeonID) ) then
                              --print(1)
                              LFGDungeonList_SetHeaderEnabled(category, dungeonID, isChecked, dungeonList, hiddenByCollapseList);
                           else
                              --print(2)
                              LFGDungeonList_SetDungeonEnabled(dungeonID, isChecked);
                              LFGListUpdateHeaderEnabledAndLockedStates(dungeonList, LFGEnabledList, hiddenByCollapseList);
                           end
                           LFDQueueFrameSpecificList_Update()
                        end

                        C_Timer.After(0.3, function()
                           SkuOptions.currentMenuPosition.parent:OnUpdate()
                        end)
                     end,            
                     --click = true,            
                  }  
                  if tLocked == "LOCKED" then
                     tParentSpecificList[x..displayName].type = "Text"
                  end
               end
            end
         end


         --rewards
         --https://github.com/Gethe/wow-ui-source/blob/d306d7354ad1f1d0ac118ec6a4dfc14746c04720/Interface/FrameXML/LFGFrame.lua#L1178
         if tSelectedValue ~= L["specific"] then
            table.insert(tParentLFD, L["Description and Rewards"])
            tParentLFD[L["Description and Rewards"]] = {
               frameName = "",
               RoC = "Child",
               type = "Button",
               textFirstLine = L["Description and Rewards"],
               childs = {},
            }    

            local dungeonID = tSelectedValue
         
            local dungeonName, typeID, subtypeID,_,_,_,_,_,_,_,backgroundTexture,difficulty,_,dungeonDescription, isHoliday, bonusRepAmount, _, isTimewalker = GetLFGDungeonInfo(dungeonID);
            local isScenario = (subtypeID == LFG_SUBTYPEID_SCENARIO);
            local doneToday, moneyAmount, moneyVar, experienceGained, experienceVar, numRewards, spellID = GetLFGDungeonRewards(dungeonID);
            local leaderChecked, tankChecked, healerChecked, damageChecked = LFDQueueFrame_GetRoles();
            
            --[[
               if ( difficulty > 0 ) then
                  --print("HEROIC")
               else
                  --print("QUESTPAPER")
               end
            ]]
         
            local trewardsDescription, ttitle, tdescription = "", "", ""
            if ( isTimewalker ) then
               trewardsDescription = LFD_RANDOM_REWARD_EXPLANATION2
               ttitle = LFG_TYPE_RANDOM_TIMEWALKER_DUNGEON
               tdescription = LFD_TIMEWALKER_RANDOM_EXPLANATION
            elseif ( isHoliday ) then
               if ( doneToday ) then
                  trewardsDescription = LFD_HOLIDAY_REWARD_EXPLANATION2
               else
                  trewardsDescription = LFD_HOLIDAY_REWARD_EXPLANATION1
               end
               ttitle = dungeonName
               tdescription = dungeonDescription
            elseif ( subtypeID == LFG_SUBTYPEID_RAID ) then
               if ( doneToday ) then --May not actually be today, but whatever this reset period is.
                  trewardsDescription = RF_REWARD_EXPLANATION2
               else
                  trewardsDescription = RF_REWARD_EXPLANATION1
               end
               ttitle = dungeonName
               tdescription = dungeonDescription
            else
               local numCompletions, isWeekly = LFGRewardsFrame_EstimateRemainingCompletions(dungeonID);
               if ( numCompletions <= 0 ) then
                  trewardsDescription = LFD_RANDOM_REWARD_EXPLANATION2
               elseif ( isWeekly ) then
                  trewardsDescription = format(LFD_REWARD_DESCRIPTION_WEEKLY, numCompletions)
               else
                  trewardsDescription = format(LFD_REWARD_DESCRIPTION_DAILY, numCompletions)
               end
               if ( isScenario ) then
                  if ( LFG_IsHeroicScenario(dungeonID) ) then
                     ttitle = LFG_TYPE_RANDOM_HEROIC_SCENARIO
                     tdescription = SCENARIO_RANDOM_HEROIC_EXPLANATION
                  else
                     ttitle = LFG_TYPE_RANDOM_SCENARIO
                     tdescription = SCENARIO_RANDOM_EXPLANATION
                  end
               else
                  ttitle = LFG_TYPE_RANDOM_DUNGEON
                  tdescription = LFD_RANDOM_EXPLANATION
               end
            end
         
            local tTokenRewards = ""
            local itemButtonIndex = 1;
            for i=1, numRewards do
               local name, texture, numItems, isBonusReward, rewardType, rewardID, quality = GetLFGDungeonRewardInfo(dungeonID, i);
               if (isBonusReward == false) then
                  if rewardType == "currency" and C_CurrencyInfo.IsCurrencyContainer(rewardID, numItems) then
                     name, texture, numItems, quality = CurrencyContainerUtil.GetCurrencyContainerInfo(rewardID, numItems, name, texture, quality);
                  end
                  tTokenRewards = tTokenRewards..numItems.." "..name..";"
                  itemButtonIndex = itemButtonIndex + 1;
               end
            end
         
            if ( not IsInGroup(LE_PARTY_CATEGORY_HOME) ) then
               for shortageIndex=1, LFG_ROLE_NUM_SHORTAGE_TYPES do
                  local eligible, forTank, forHealer, forDamage, itemCount = GetLFGRoleShortageRewards(dungeonID, shortageIndex);
                  if ( eligible and ((tankChecked and forTank) or (healerChecked and forHealer) or (damageChecked and forDamage)) ) then
                     for rewardIndex=1, itemCount do
                        local name, texture, numItems, _, rewardType, rewardID, quality = GetLFGDungeonShortageRewardInfo(dungeonID, shortageIndex, rewardIndex);
                        if rewardType == "currency" and C_CurrencyInfo.IsCurrencyContainer(rewardID, numItems) then
                           name, texture, numItems, quality = CurrencyContainerUtil.GetCurrencyContainerInfo(rewardID, numItems, name, texture, quality);
                        end
                        tTokenRewards = tTokenRewards..numItems.." "..name..";"
                        itemButtonIndex = itemButtonIndex + 1;
                     end
                  end
               end
            end
         
            local totalRewards = itemButtonIndex - 1;
         
            local tamountText = ""
            if ( moneyAmount > 0 ) then
               tamountText = GetMoneyString(moneyAmount)
            end
         
            local txpAmount = ""
            if ( experienceGained > 0 ) then
               txpAmount = experienceGained
            end
         
            local numEncounters, numCompleted = GetLFGDungeonNumEncounters(dungeonID);
            if ( numCompleted > 0 ) then
               --parentFrame.encounterList:Show();
            else
               --parentFrame.encounterList:Hide();
            end

            local tFirst, tFull = "", ""
            if _G["LFDQueueFrameRandomScrollFrameChildFrameTitle"] then
               ttitle = _G["LFDQueueFrameRandomScrollFrameChildFrameTitle"]:GetText()
            end

            if _G["LFDQueueFrameRandomScrollFrameChildFrameDescription"] then
               tdescription = _G["LFDQueueFrameRandomScrollFrameChildFrameDescription"]:GetText()
            end
            if _G["LFDQueueFrameRandomScrollFrameChildFrameRandomList"] then
               _G["LFDQueueFrameRandomScrollFrameChildFrameRandomList"].type = "rdf"
               tFirst, tFull = GetButtonTooltipLines(_G["LFDQueueFrameRandomScrollFrameChildFrameRandomList"])
            end

            local tDescriptionAndRewardsParent = tParentLFD[L["Description and Rewards"]].childs
            table.insert(tDescriptionAndRewardsParent, "title")
            tDescriptionAndRewardsParent["title"] = {
               frameName = "",
               RoC = "Child",
               type = "Text",
               textFirstLine = L["Text"]..": "..L["Title"]..": "..ttitle,
               textFull = tFull,
               childs = {},
            }  

            table.insert(tDescriptionAndRewardsParent, "numEncounters")
            tDescriptionAndRewardsParent["numEncounters"] = {
               frameName = "",
               RoC = "Child",
               type = "Text",
               textFirstLine = L["Text"]..": "..L["Encounters"]..": "..numEncounters.." / "..numCompleted,
               childs = {},
            }  

            table.insert(tDescriptionAndRewardsParent, L["description"])
            tDescriptionAndRewardsParent[L["description"]] = {
               frameName = "",
               RoC = "Child",
               type = "Text",
               textFirstLine = L["Text"]..": "..L["description"]..": "..tdescription,
               childs = {},
            }  

            if _G["LFDQueueFrameRandomScrollFrameChildFrameRewardsDescription"] and _G["LFDQueueFrameRandomScrollFrameChildFrameRewardsDescription"]:GetText() ~= "" then
               table.insert(tDescriptionAndRewardsParent, "tRewardsDesc")
               tDescriptionAndRewardsParent["tRewardsDesc"] = {
                  frameName = "",
                  RoC = "Child",
                  type = "Text",
                  textFirstLine = L["Text"]..": "..L["Reward description"]..": ".._G["LFDQueueFrameRandomScrollFrameChildFrameRewardsDescription"]:GetText(),
                  childs = {},
               }
            end

            if tTokenRewards ~= "" then
               table.insert(tDescriptionAndRewardsParent, "tTokenRewards")
               tDescriptionAndRewardsParent["tTokenRewards"] = {
                  frameName = "",
                  RoC = "Child",
                  type = "Text",
                  textFirstLine = L["Text"]..": "..L["Reward Items"]..": "..tTokenRewards,
                  childs = {},
               }
            end
            
            if tamountText ~= "" then
               tamountText = string.gsub(tamountText, [[|TInterface\MoneyFrame\UI%-GoldIcon:0:0:2:0|t]], " "..L["Gold"])
               tamountText = string.gsub(tamountText, [[|TInterface\MoneyFrame\UI%-SilverIcon:0:0:2:0|t]], " "..L["Silver"])
               tamountText = string.gsub(tamountText, [[|TInterface\MoneyFrame\UI%-CopperIcon:0:0:2:0|t]], " "..L["Copper"])

               table.insert(tDescriptionAndRewardsParent, "goldamountText")
               tDescriptionAndRewardsParent["goldamountText"] = {
                  frameName = "",
                  RoC = "Child",
                  type = "Text",
                  textFirstLine = L["Text"]..": "..L["Reward Gold"]..": "..tamountText,
                  childs = {},
               }
            end

            if txpAmount ~= "" then
               table.insert(tDescriptionAndRewardsParent, "txpAmount")
               tDescriptionAndRewardsParent["txpAmount"] = {
                  frameName = "",
                  RoC = "Child",
                  type = "Text",
                  textFirstLine = L["Text"]..": "..L["Reward XP"]..": "..txpAmount,
                  childs = {},
               }
            end
         end

         local mode, subMode = GetLFGMode(LE_LFG_CATEGORY_LFD);
         if tSelectedValue ~= L["specific"] or tHasSelection == true or (mode == "queued" or mode == "listed") then
            table.insert(tParentLFD, LFG_LIST_FIND_A_GROUP)
            tParentLFD[LFG_LIST_FIND_A_GROUP] = {
               frameName = "LFDQueueFrameFindGroupButton",
               RoC = "Child",
               type = "Button",
               obj = _G["LFDQueueFrameFindGroupButton"],
               textFirstLine = _G["LFDQueueFrameFindGroupButton"]:GetText(),
               childs = {},
               func = function()
                  local mode, subMode = GetLFGMode(LE_LFG_CATEGORY_LFD);
                  if ( mode == "queued" or mode == "listed" or mode == "rolecheck" or mode == "suspended" ) then
                     LeaveLFG(LE_LFG_CATEGORY_LFD);
                  else
                     LFDQueueFrame_Join();
                  end

                  C_Timer.After(1.0, function()
                     tParentLFD[LFG_LIST_FIND_A_GROUP].textFirstLine = _G["LFDQueueFrameFindGroupButton"]:GetText()
                     SkuOptions.currentMenuPosition.parent:OnUpdate()
                  end)
               end,
               --click = true,            
            }    
         end
      end

   end

end


function SkuCore:Build_LFDListFrame(aParentChilds)
   local GroupFinderFrame = _G["GroupFinderFrame"]
   local LFGListFrame = _G["LFGListFrame"]

   if LFGListFrame then
      table.insert(aParentChilds, L["LFD list Frame"])
      aParentChilds[L["LFD list Frame"]] = {
         frameName = "LFGListFrame",
         RoC = "Child",
         --RoC = "Region",
         type = "Button",
         obj = _G["LFGListFrame"],
         textFirstLine = L["LFD list Frame"],
         textFull = "",
         childs = {},
         onEnter = function()
            --print("onEnter")
            --_G["GroupFinderFrameGroupButton3"]:Click()
         end,
      }

      local tParentLFD = aParentChilds[L["LFD list Frame"]].childs


      if _G["LFGListFrame"]:IsVisible() == false then
         table.insert(tParentLFD, "SelectLFGListFrame")
         tParentLFD["SelectLFGListFrame"] = {
            frameName = "",
            RoC = "Child",
            type = "Button",
            --obj = _G["GroupFinderFrameGroupButton3"],
            textFirstLine = L["Select"],
            childs = {},
            
            func = function()
               _G["GroupFinderFrameGroupButton3"]:Click()
               C_Timer.After(0.3, function()
                  SkuOptions.currentMenuPosition:OnUpdate()
               end)
            end,
            
            --click = true,            
         }  
      else
        --LFGListFrame.CategorySelection
         if LFGListFrame.CategorySelection:IsVisible() == true then
            table.insert(tParentLFD, L["Category"])
            tParentLFD[L["Category"]] = {
               frameName = "",
               RoC = "Child",
               type = "Button",
               --obj = _G["GroupFinderFrame"],
               textFirstLine = L["Select category"],
               textFull = "",
               childs = {},
            }      

            local tParentCategory = tParentLFD[L["Category"]].childs

            for x = 1, #LFGListFrame.CategorySelection.CategoryButtons do
               --print(x, LFGListFrame.CategorySelection.selectedCategory, LFGListFrame.CategorySelection.CategoryButtons[x].categoryID)
               local tIsSelected = ""
               if LFGListFrame.CategorySelection.selectedCategory == LFGListFrame.CategorySelection.CategoryButtons[x].categoryID then
                  tIsSelected = L["selected"]
               end

               table.insert(tParentCategory, "CategoryButtons"..x)
               tParentCategory["CategoryButtons"..x] = {
                  frameName = "",
                  RoC = "Child",
                  type = "Button",
                  --obj = LFGListFrame.CategorySelection.CategoryButtons[x],
                  textFirstLine = LFGListFrame.CategorySelection.CategoryButtons[x].Label:GetText()..";"..tIsSelected,
                  textFull = "",
                  childs = {},
                  func = function()
                     LFGListFrame.CategorySelection.CategoryButtons[x]:Click()

                     C_Timer.After(0.3, function()
                        SkuOptions.currentMenuPosition.parent:OnUpdate()
                     end)
                  end,            
                  --click = true,            
               }     
            end

            if LFGListFrame.CategorySelection.selectedCategory ~= nil then
               table.insert(tParentLFD, "StartGroup")
               tParentLFD["StartGroup"] = {
                  frameName = "",
                  RoC = "Child",
                  type = "Button",
                  --obj = LFGListFrame.CategorySelection.StartGroupButton,
                  textFirstLine = L["Start Group"],
                  textFull = "",
                  childs = {},
                  func = function()
                     LFGListFrame.CategorySelection.StartGroupButton:Click()
                     C_Timer.After(0.3, function()
                        SkuOptions.currentMenuPosition:OnUpdate()
                        LFGListFrame.EntryCreation.Name:ClearFocus()
                     end)
                  end,            
                  --click = true,            
               }    

               table.insert(tParentLFD, "FindGroup")
               tParentLFD["FindGroup"] = {
                  frameName = "",
                  RoC = "Child",
                  type = "Button",
                  --obj = LFGListFrame.CategorySelection.FindGroupButton,
                  textFirstLine = L["Find Group"],
                  textFull = "",
                  childs = {},
                  func = function()
                     LFGListFrame.CategorySelection.FindGroupButton:Click()
                     C_Timer.After(0.3, function()
                        SkuOptions.currentMenuPosition:OnUpdate()
                     end)
                  end,            
                  --click = true,            
               }    
            end

         elseif LFGListFrame.EntryCreation:IsVisible() == true then
            table.insert(tParentLFD, "EntryCreation")
            tParentLFD["EntryCreation"] = {
               frameName = "",
               RoC = "Child",
               type = "Button",
               --obj = _G["GroupFinderFrame"],
               textFirstLine = L["Entry Creation"],
               textFull = "",
               childs = {},
            }      

            local tParentEntryCreation = tParentLFD["EntryCreation"].childs

            table.insert(tParentEntryCreation, "CancelButton")
            tParentEntryCreation["CancelButton"] = {
               frameName = "",
               RoC = "Child",
               type = "Button",
               --obj = LFGListFrame.CategorySelection.StartGroupButton,
               textFirstLine = L["Cancel Button"],
               textFull = "",
               childs = {},
               func = function()
                  LFGListFrame.EntryCreation.CancelButton:Click()
                  C_Timer.After(0.3, function()
                     SkuOptions.currentMenuPosition.parent:OnUpdate()
                  end)
               end,            
               --click = true,            
            }  

            --activities
            if _G["LFGListEntryCreationGroupDropDown"] and _G["LFGListEntryCreationGroupDropDown"]:IsVisible() == true then
               table.insert(tParentEntryCreation, L["activities"])
               tParentEntryCreation[L["activities"]] = {
                  frameName = "",
                  RoC = "Child",
                  type = "Button",
                  --obj = _G["GroupFinderFrame"],
                  textFirstLine = L["Activity"]..": "..tCurrentActivityName,
                  textFull = "",
                  childs = {},
               }      

               local tParentactivities = tParentEntryCreation[L["activities"]].childs

               local tSelf = LFGListFrame.EntryCreation
               local groups = C_LFGList.GetAvailableActivityGroups(tSelf.selectedCategory, bit.bor(tSelf.baseFilters, tSelf.selectedFilters));
               --local activities = C_LFGList.GetAvailableActivities(tSelf.selectedCategory, 0, bit.bor(tSelf.baseFilters, tSelf.selectedFilters));

               for x = 1, #groups do
                  local activities = C_LFGList.GetAvailableActivities(LFGListFrame.EntryCreation.selectedCategory, groups[x], LFGListFrame.EntryCreation.selectedFilters)
                  for y = 1, #activities do
                     local activityInfo = C_LFGList.GetActivityInfoTable(activities[y])
                     table.insert(tParentactivities, L["Activity"].."-"..x.."-"..y)
                     tParentactivities[L["Activity"].."-"..x.."-"..y] = {
                        frameName = "",
                        RoC = "Child",
                        type = "Button",
                        textFirstLine = x.."-"..y.." "..activityInfo.fullName,
                        textFull = "",
                        childs = {},
                        func = function()
                           LFGListEntryCreation_Select(LFGListFrame.EntryCreation, nil, nil, nil, activities[y])
                           tCurrentActivityName = (activityInfo.fullName or "")
                           C_Timer.After(0.3, function()
                              SkuOptions.currentMenuPosition:OnUpdate()
                           end)
                        end,            
                     }  
                  end
               end
            end

            --name
            table.insert(tParentEntryCreation, "nameEditBox")
            tParentEntryCreation["nameEditBox"] = {
               frameName = "",
               RoC = "Child",
               type = "Button",
               textFirstLine = L["Title"]..": "..tSkuCurrentTitleText,
               textFull = "",
               childs = {},
               func = function()
                  C_Timer.After(0.1, function()
                     SkuOptions.Voice:OutputStringBTtts(L["input text and complete with enter"], false, true, 0.8, true, nil, nil, 1, nil, nil, true)
                  end)
                  LFGListFrame.EntryCreation.Name:SetFocus()
                  LFGListFrame.EntryCreation.Name:HookScript("OnEditFocusLost", function(self)
                     C_Timer.After(0.1, function()
                        PlaySound(89) 
                        tSkuCurrentTitleText = LFGListFrame.EntryCreation.Name:GetText() or ""
                        C_Timer.After(0.1, function()
                           SkuOptions.currentMenuPosition:OnUpdate()
                        end)
                     end)
                  end)
               end,            
            }  

            --description
            table.insert(tParentEntryCreation, "descriptionEditBox")
            tParentEntryCreation["descriptionEditBox"] = {
               frameName = "",
               RoC = "Child",
               type = "Button",
               textFirstLine = L["description"]..": "..tSkuCurrentDescriptionText,
               textFull = "",
               childs = {},
               func = function()
                  C_Timer.After(0.1, function()
                     SkuOptions.Voice:OutputStringBTtts(L["input text and complete with escape"], false, true, 0.8, true, nil, nil, 1, nil, nil, true)
                  end)
                  LFGListFrame.EntryCreation.Description.EditBox:SetFocus()
                  LFGListFrame.EntryCreation.Description.EditBox:HookScript("OnEditFocusLost", function(self)
                     C_Timer.After(0.1, function()
                        PlaySound(89) 
                        tSkuCurrentDescriptionText = LFGListFrame.EntryCreation.Description.EditBox:GetText() or ""
                        C_Timer.After(0.1, function()
                           SkuOptions.currentMenuPosition:OnUpdate()
                        end)
                     end)
                  end)
               end,            
            }  

            --min item level
            table.insert(tParentEntryCreation, "ItemlevelEditBox")
            tParentEntryCreation["ItemlevelEditBox"] = {
               frameName = "",
               RoC = "Child",
               type = "Button",
               textFirstLine = L["Item level"]..": "..tSkuCurrentItemLevelText,
               textFull = "",
               childs = {},
               func = function()
                  C_Timer.After(0.1, function()
                     SkuOptions.Voice:OutputStringBTtts(L["input number and complete with enter"], false, true, 0.8, true, nil, nil, 1, nil, nil, true)
                  end)
                  LFGListFrame.EntryCreation.ItemLevel.EditBox:SetText("")
                  LFGListFrame.EntryCreation.ItemLevel.EditBox:SetFocus()
                  LFGListFrame.EntryCreation.ItemLevel.EditBox:HookScript("OnEditFocusLost", function(self)
                     C_Timer.After(0.1, function()
                        PlaySound(89) 
                        tSkuCurrentItemLevelText = LFGListFrame.EntryCreation.ItemLevel.EditBox:GetText() or ""
                        if tSkuCurrentItemLevelText == "" then
                           LFGListFrame.EntryCreation.ItemLevel.CheckButton:SetChecked(false)
                        else
                           LFGListFrame.EntryCreation.ItemLevel.CheckButton:SetChecked(true)
                        end
                        C_Timer.After(0.1, function()
                           SkuOptions.currentMenuPosition:OnUpdate()
                        end)
                     end)
                  end)
               end,            
            }  

            --voicechat
            table.insert(tParentEntryCreation, "VoiceChatEditBox")
            tParentEntryCreation["VoiceChatEditBox"] = {
               frameName = "",
               RoC = "Child",
               type = "Button",
               textFirstLine = L["Voice chat"]..": "..tSkuCurrentVoiceChatText,
               textFull = "",
               childs = {},
               func = function()
                  C_Timer.After(0.1, function()
                     SkuOptions.Voice:OutputStringBTtts(L["input text and complete with enter"], false, true, 0.8, true, nil, nil, 1, nil, nil, true)
                  end)
                  LFGListFrame.EntryCreation.VoiceChat.EditBox:SetText("")
                  LFGListFrame.EntryCreation.VoiceChat.EditBox:SetFocus()
                  LFGListFrame.EntryCreation.VoiceChat.EditBox:HookScript("OnEditFocusLost", function(self)
                     C_Timer.After(0.1, function()
                        PlaySound(89) 
                        tSkuCurrentVoiceChatText = LFGListFrame.EntryCreation.VoiceChat.EditBox:GetText() or ""
                        if tSkuCurrentVoiceChatText == "" then
                           LFGListFrame.EntryCreation.VoiceChat.CheckButton:SetChecked(false)
                        else
                           LFGListFrame.EntryCreation.VoiceChat.CheckButton:SetChecked(true)
                        end
                        C_Timer.After(0.1, function()
                           SkuOptions.currentMenuPosition:OnUpdate()
                        end)
                     end)
                  end)
               end,            
            }  

            --private
            table.insert(tParentEntryCreation, "PrivateGroup")
            tParentEntryCreation["PrivateGroup"] = {
               frameName = "",
               RoC = "Child",
               type = "Button",
               textFirstLine = L["Private"]..": "..tostring(tSkuCurrentPrivateChecked),
               textFull = "",
               childs = {},
               func = function()
                  if LFGListFrame.EntryCreation.PrivateGroup.CheckButton:GetChecked() == false then
                     LFGListFrame.EntryCreation.PrivateGroup.CheckButton:SetChecked(true)
                  else
                     LFGListFrame.EntryCreation.PrivateGroup.CheckButton:SetChecked(false)
                  end
                  tSkuCurrentPrivateChecked = LFGListFrame.EntryCreation.PrivateGroup.CheckButton:GetChecked()
                  C_Timer.After(0.3, function()
                     SkuOptions.currentMenuPosition:OnUpdate()
                  end)
               end,            
            }  

            --create
            if LFGListFrame.EntryCreation.ListGroupButton:IsEnabled() == true then
               table.insert(tParentEntryCreation, "CreateButton")
               tParentEntryCreation["CreateButton"] = {
                  frameName = "",
                  RoC = "Child",
                  type = "Button",
                  --obj = LFGListFrame.CategorySelection.StartGroupButton,
                  textFirstLine = L["Create Group"],
                  textFull = "",
                  childs = {},
                  func = function()
                     LFGListFrame.EntryCreation.ListGroupButton:Click()
                     C_Timer.After(0.3, function()
                        if (_G["LFGListCreateRoleDialog"] and _G["LFGListCreateRoleDialog"]:IsVisible() == true) or (_G["LFDRoleCheckPopup"] and _G["LFDRoleCheckPopup"]:IsVisible() == true) then
                           SkuOptions:SlashFunc(L["short"]..","..L["Local"] ..","..L["role selection"])
                           SkuOptions.currentMenuPosition:OnUpdate()
                        else
                           SkuOptions.currentMenuPosition.parent:OnUpdate()
                        end
                     end)
                  end,            
                  --click = true,            
               } 
            end 


         --searchpanel
         elseif LFGListFrame.SearchPanel:IsVisible() == true then
            table.insert(tParentLFD, "SearchPanel")
            tParentLFD["SearchPanel"] = {
               frameName = "",
               RoC = "Child",
               type = "Button",
               --obj = _G["GroupFinderFrame"],
               textFirstLine = L["Search Panel"],
               textFull = "",
               childs = {},
            }      

            local tParentSearchPanel = tParentLFD["SearchPanel"].childs

            table.insert(tParentSearchPanel, "BackButton")
            tParentSearchPanel["BackButton"] = {
               frameName = "",
               RoC = "Child",
               type = "Button",
               --obj = LFGListFrame.CategorySelection.StartGroupButton,
               textFirstLine = L["Back Button"],
               textFull = "",
               childs = {},
               func = function()
                  LFGListFrame.SearchPanel.BackButton:Click()
                  C_Timer.After(0.3, function()
                     SkuOptions.currentMenuPosition.parent:OnUpdate()
                  end)
               end,            
               --click = true,            
            }              



            --LFGListFrame.SearchPanel.SearchBox
            --LFGListFrame.SearchPanel.RefreshButton







         
            --[[
            local isPartyLeader = UnitIsGroupLeader("player", LE_PARTY_CATEGORY_HOME);
            local canBrowseWhileQueued = C_LFGList.HasActiveEntryInfo() and isPartyLeader;
            --Update the StartGroupButton
            if ( IsInGroup(LE_PARTY_CATEGORY_HOME) and not isPartyLeader ) then
               self.ScrollBox.StartGroupButton:Disable();
               self.ScrollBox.StartGroupButton.tooltip = LFG_LIST_NOT_LEADER;
            else
               local messageStart = LFGListUtil_GetActiveQueueMessage(false);
               local startError, errorText = GetStartGroupRestriction();
               if ( messageStart ) then
                  self.ScrollBox.StartGroupButton:Disable();
                  self.ScrollBox.StartGroupButton.tooltip = messageStart;
               elseif ( startError ~= nil ) then
                  self.ScrollBox.StartGroupButton:Disable();
                  self.ScrollBox.StartGroupButton.tooltip = errorText;
               elseif (canBrowseWhileQueued) then
                  self.ScrollBox.StartGroupButton:Disable();
                  self.ScrollBox.StartGroupButton.tooltip = CANNOT_DO_THIS_WHILE_LFGLIST_LISTED;
               else
                  self.ScrollBox.StartGroupButton:Enable();
                  self.ScrollBox.StartGroupButton.tooltip = nil;
               end
            end
         
            self.BackButton:SetShown(not canBrowseWhileQueued);
            self.BackToGroupButton:SetShown(canBrowseWhileQueued)
            ]]














            local dtc = { LFGListFrame.SearchPanel.ScrollBox.ScrollTarget:GetChildren() }
            for x = 1, #dtc do
               local resultID = dtc[x].resultID;


               local CancelButton = true
               local PendingLabel = ""
               local ExpirationTime = false
               --[[
               if not C_LFGList.HasSearchResultInfo(resultID) then
                  return;
               end
               ]]
               local _, appStatus, pendingStatus, appDuration = C_LFGList.GetApplicationInfo(resultID);
               local isApplication = (appStatus ~= "none" or pendingStatus);
               local isAppFinished = LFGListUtil_IsStatusInactive(appStatus) or LFGListUtil_IsStatusInactive(pendingStatus);
               --Update visibility based on whether we're an application or not
               --dtc[x].isApplication = isApplication;
               --dtc[x].CancelButton:SetShown(isApplication and pendingStatus ~= "applied");
               --dtc[x].CancelButton:SetEnabled(LFGListUtil_IsAppEmpowered());
               --dtc[x].CancelButton.tooltip = (not LFGListUtil_IsAppEmpowered()) and LFG_LIST_APP_UNEMPOWERED;
               --dtc[x].Spinner:SetShown(pendingStatus == "applied");
               if ( pendingStatus == "applied" and C_LFGList.GetRoleCheckInfo() ) then
                  PendingLabel = LFG_LIST_ROLE_CHECK
                  CancelButton = false
               elseif ( pendingStatus == "cancelled" or appStatus == "cancelled" or appStatus == "failed" ) then
                  PendingLabel = LFG_LIST_APP_CANCELLED
                  CancelButton = false
               elseif ( appStatus == "declined" or appStatus == "declined_full" or appStatus == "declined_delisted" ) then
                  PendingLabel = (appStatus == "declined_full") and LFG_LIST_APP_FULL or LFG_LIST_APP_DECLINED
                  CancelButton = false
               elseif ( appStatus == "timedout" ) then
                  PendingLabel = LFG_LIST_APP_TIMED_OUT
                  CancelButton = false
               elseif ( appStatus == "invited" ) then
                  PendingLabel = LFG_LIST_APP_INVITED
                  CancelButton = false
               elseif ( appStatus == "inviteaccepted" ) then
                  PendingLabel = LFG_LIST_APP_INVITE_ACCEPTED
                  CancelButton = false
               elseif ( appStatus == "invitedeclined" ) then
                  PendingLabel = LFG_LIST_APP_INVITE_DECLINED
                  CancelButton = false
               elseif ( isApplication and pendingStatus ~= "applied" ) then
                  PendingLabel = LFG_LIST_PENDING
                  ExpirationTime = true
                  CancelButton = true
               else
                  CancelButton = false
               end











               --entry
               dtc[x].type = "tmp"
               local tFirst, tFull = GetButtonTooltipLines(dtc[x])
               tFirst = MaskBattleNetNames(tFirst)
               tFull = MaskBattleNetNames(tFull)
               local tText = x..": "
               tText = tText..tFirst
               tText = tText..";"..SkuChat:Unescape(dtc[x].ActivityName:GetText())
               tText = tText..";"..L["Mitglieder"]..": "
               for z = 5, 1, -1 do
                  if dtc[x].DataDisplay.Enumerate.Icons[z] then
                     tText = tText..(L[dtc[x].DataDisplay.Enumerate.Icons[z]:GetAtlas() or L["empty"]])..";"
                  end
               end


               tText = tText..";CancelButton "..tostring(CancelButton)
               tText = tText..";PendingLabel "..tostring(PendingLabel)
               tText = tText..";ExpirationTime "..tostring(ExpirationTime)
               tText = tText..";pendingStatus "..tostring(pendingStatus)
               tText = tText..";appStatus "..tostring(appStatus)
               --self.VoiceChat:SetShown(searchResultInfo.voiceChat ~= "");
               --self.VoiceChat.tooltip = searchResultInfo.voiceChat;


               table.insert(tParentSearchPanel, L["Entry"]..x)
               tParentSearchPanel[L["Entry"]..x] = {
                  frameName = "",
                  RoC = "Child",
                  type = "Button",
                  obj = dtc[x],
                  textFirstLine = tText,
                  textFull = tFull,
                  childs = {},
                  click = true,   
                  func = dtc[x]:GetScript("OnClick"),
               }
               

               --signup
               self = dtc[x]
               local SignUpButton = true
               local SignUpButtonTooltip = ""
               local resultID = self.selectedResult;
               local numApplications, numActiveApplications = C_LFGList.GetNumApplications();
               local messageApply = LFGListUtil_GetActiveQueueMessage(true);
               local availTank, availHealer, availDPS = C_LFGList.GetAvailableRoles();
               if ( messageApply ) then
                  SignUpButton = false
                  SignUpButtonTooltip = messageApply;
               elseif ( not LFGListUtil_IsAppEmpowered() ) then
                  SignUpButton = false
                  SignUpButtonTooltip = LFG_LIST_APP_UNEMPOWERED;
               elseif ( IsInGroup(LE_PARTY_CATEGORY_HOME) and C_LFGList.IsCurrentlyApplying() ) then
                  SignUpButton = false
                  SignUpButtonTooltip = LFG_LIST_APP_CURRENTLY_APPLYING;
               elseif ( numActiveApplications >= MAX_LFG_LIST_APPLICATIONS ) then
                  SignUpButton = false
                  SignUpButtonTooltip = string.format(LFG_LIST_HIT_MAX_APPLICATIONS, MAX_LFG_LIST_APPLICATIONS);
               elseif ( GetNumGroupMembers(LE_PARTY_CATEGORY_HOME) > MAX_PARTY_MEMBERS + 1 ) then
                  SignUpButton = false
                  SignUpButtonTooltip = LFG_LIST_MAX_MEMBERS;
               elseif ( not (availTank or availHealer or availDPS) ) then
                  SignUpButton = false
                  SignUpButtonTooltip = LFG_LIST_MUST_CHOOSE_SPEC;
               elseif ( GroupHasOfflineMember(LE_PARTY_CATEGORY_HOME) ) then
                  SignUpButton = false
                  SignUpButtonTooltip = LFG_LIST_OFFLINE_MEMBER;
               elseif ( resultID ) then
                  SignUpButton = true
                  SignUpButtonTooltip = nil;
               else
                  SignUpButton = false
                  SignUpButtonTooltip = LFG_LIST_SELECT_A_SEARCH_RESULT;
               end

               if SignUpButton == true then
                  table.insert(tParentSearchPanel[L["Entry"]..x].childs, "EntrySignup"..x)
                  tParentSearchPanel[L["Entry"]..x].childs["EntrySignup"..x] = {
                     frameName = "",
                     RoC = "Child",
                     type = "Button",
                     obj = LFGListFrame.SearchPanel.SignUpButton,
                     textFirstLine = L["Sign up"],
                     textFull = SignUpButtonTooltip,
                     childs = {},
                     click = true,   
                     func = function()
                        dtc[x]:GetScript("OnClick")(dtc[x])
                        C_Timer.After(3, function()
                           LFGListFrame.SearchPanel.SignUpButton:GetScript("OnClick")(LFGListFrame.SearchPanel.SignUpButton)
                        end)
                     end,
                  }
               end

            end







         --ApplicationViewer
         elseif LFGListFrame.ApplicationViewer:IsVisible() == true then
            table.insert(tParentLFD, "ApplicationViewer")
            tParentLFD["ApplicationViewer"] = {
               frameName = "",
               RoC = "Child",
               type = "Button",
               --obj = _G["GroupFinderFrame"],
               textFirstLine = L["Application Viewer"],
               textFull = "",
               childs = {},
            }      

            local tParentApplicationViewer = tParentLFD["ApplicationViewer"].childs

            table.insert(tParentApplicationViewer, "RemoveEntryButton")
            tParentApplicationViewer["RemoveEntryButton"] = {
               frameName = "",
               RoC = "Child",
               type = "Button",
               --obj = LFGListFrame.CategorySelection.StartGroupButton,
               textFirstLine = L["Remove Entry"],
               textFull = "",
               childs = {},
               func = function()
                  LFGListFrame.ApplicationViewer.RemoveEntryButton:Click()
                  C_Timer.After(1, function()
                     SkuOptions.currentMenuPosition.parent:OnUpdate()
                  end)
               end,            
               --click = true,            
            }    












         end
      end
   end
end
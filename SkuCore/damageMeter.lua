---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME, MODULE_PART = "SkuCore", "aq"
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

SkuCore.damageMeter = {}

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:DamageMeterOnInitialize()
	--SkuCore:RegisterEvent("")
end

---------------------------------------------------------------------------------------------------------------------------------------
local function SkuDetailsCloseAssistant()
   if not Details then
      return
   end

   if DetailsWelcomeWindow and DetailsWelcomeWindow:IsShown() == true then
      for i, v in pairs({DetailsWelcomeWindow:GetChildren()}) do
         if v.GetNormalTexture and v:IsEnabled() == true then 
            local tx = v:GetNormalTexture()
            if tx and tx:GetTexture() == 130866 then
               C_Timer.After(0.01, function()
                  v:Click()
                  SkuDetailsCloseAssistant()
               end)
               return
            end
         end
      end
      
      for i, v in pairs({DetailsWelcomeWindow:GetChildren()}) do
         if v.GetNormalTexture and v:IsEnabled() == true then 
            local tx = v:GetNormalTexture()
            if tx and tx:GetTexture() == 130775 then
               C_Timer.After(0.01, function()
                  v:Click()
               end)
               C_Timer.After(2, function()
                  Details:ShutDownAllInstances()
                  if DetailsBaseFrame1 and DetailsBaseFrame1:IsShown() then
                     DetailsBaseFrame1:Hide()
                  end
               end)
               --return
            end
         end
      end
   end
   Details:ShutDownAllInstances()
   if DetailsBaseFrame1 then
      DetailsBaseFrame1:Hide()
   end
   if DetailsNewsWindowCloseButton then
      DetailsNewsWindowCloseButton:Click()
   end
   if DetailsProfilerProfileConfirmButton then
      DetailsProfilerProfileConfirmButton:GetParent():Hide()
   end
end
---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:DamageMeterOnLogin()
	SkuOptions.db.char[MODULE_NAME].damageMeter = SkuOptions.db.char[MODULE_NAME].damageMeter or {}

   C_Timer.After(15, function()
      SkuDetailsCloseAssistant()
   end)
   C_Timer.After(90, function()
      SkuDetailsCloseAssistant()
   end)
   C_Timer.After(180, function()
      SkuDetailsCloseAssistant()
   end)

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:DamageMeterSlashHandler(aFieldsTable)
	if aFieldsTable[2] == "" then
		
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
local function BuildCombatTooltip(aCombat, aName, aAll)
   --[[
   combat
   start_time
	end_time
	CombatEndedAt
	overall_enemy_name
	enemy			string
	raid_roster		table
	raid_roster_indexed	table
	playing_solo
	instance_type				raid party

   actor
   start_time		long
   end_time		long
   grupo 			bool
   displayName 		string
   total_without_pet	double
   total			double
   classe			string (CAP)
   serial			GUID
   nome			string
   pets			table
   spec			number
   spells			table
   damage_taken		double
   ]]   
   local tTooltipText = {}
   local tPlayerName = UnitName("player")

   --
   table.insert(tTooltipText, aName)

   -- DPS
   local tActorList = aCombat:GetActorList(DETAILS_ATTRIBUTE_DAMAGE)
   table.sort(tActorList, function(a, b)
      return a.total / aCombat:GetCombatTime() > b.total / aCombat:GetCombatTime()
   end)
   local tText = L["DPS"]..":\r\n"
   local tRank = 1
   for i, actor in ipairs(tActorList) do
      if (aCombat.playing_solo == true and actor.displayName == tPlayerName) or (aCombat.playing_solo ~= true and aCombat.raid_roster[actor.displayName]) or aAll == true then
         local efDPS = math.floor(actor.total / aCombat:GetCombatTime())
         tText = tText..tRank.." "..actor.nome.." "..(SkuQuest.classesFriendly[actor.classe] or L["unknown"]).." "..efDPS.."\r\n"
         tRank = tRank + 1
      end
   end
   table.insert(tTooltipText, tText)

   --dmg total
   local tActorList = aCombat:GetActorList(DETAILS_SUBATTRIBUTE_DAMAGEDONE)
   table.sort(tActorList, function(a, b)
      return a.total > b.total
   end)
   local tText = L["Damage total"]..":\r\n"
   local tRank = 1
   for i, actor in ipairs(tActorList) do
      if (aCombat.playing_solo == true and actor.displayName == tPlayerName) or (aCombat.playing_solo ~= true and aCombat.raid_roster[actor.displayName]) or aAll == true then
         local efDPS = math.floor(actor.total)
         tText = tText..tRank.." "..actor.nome.." "..(SkuQuest.classesFriendly[actor.classe] or L["unknown"]).." ".." "..efDPS.."\r\n"
         tRank = tRank + 1
      end
   end
   table.insert(tTooltipText, tText)

   --dmg taken
   local tActorList = aCombat:GetActorList(DETAILS_SUBATTRIBUTE_DAMAGEDONE)
   table.sort(tActorList, function(a, b)
      return a.damage_taken > b.damage_taken
   end)
   local tText = L["Damage taken"]..":\r\n"
   local tRank = 1
   for i, actor in ipairs(tActorList) do
      if (aCombat.playing_solo == true and actor.displayName == tPlayerName) or (aCombat.playing_solo ~= true and aCombat.raid_roster[actor.displayName]) or aAll == true then
         local efDPS = math.floor(actor.damage_taken)
         tText = tText..tRank.." "..actor.nome.." "..(SkuQuest.classesFriendly[actor.classe] or L["unknown"]).." ".." "..efDPS.."\r\n"
         tRank = tRank + 1
      end
   end
   table.insert(tTooltipText, tText)

   return tTooltipText
end

---------------------------------------------------------------------------------------------------------------------------------------
local function tDPSDetailsTooltip(spell)
   spell.o_amt = (spell.n_amt or 0) + (spell.c_amt or 0) + (spell.g_amt or 0) + (spell.r_amt or 0) + (spell.b_amt or 0) + (spell.a_amt or 0)
   spell.o_dmg = (spell.n_dmg or 0) + (spell.c_dmg or 0) + (spell.g_dmg or 0) + (spell.r_dmg or 0) + (spell.b_dmg or 0) + (spell.a_dmg or 0)

   local tTip = L["Total hits: "]..(spell.o_amt or 0).."\r\n"
   tTip = tTip..L["Total Damage: "]..(spell.o_dmg or 0).."\r\n"

   tTip = tTip..L["Normal hits: "]..(spell.n_amt or 0).."\r\n"
   tTip = tTip..L["Normal Damage: "]..(spell.n_dmg or 0).."\r\n"
   tTip = tTip..L["Normal Min hit: "]..(spell.n_min or 0).."\r\n"
   tTip = tTip..L["Normal Max hit: "]..(spell.n_max or 0).."\r\n"

   tTip = tTip..L["Critical hits: "]..(spell.c_amt or 0).."\r\n"
   tTip = tTip..L["Critical Damage: "]..(spell.c_dmg or 0).."\r\n"
   tTip = tTip..L["Critical Min hit: "]..(spell.c_min or 0).."\r\n"
   tTip = tTip..L["Critical Max hit: "]..(spell.c_max or 0).."\r\n"

   tTip = tTip..L["Glancing hits: "]..(spell.g_amt or 0).."\r\n"
   tTip = tTip..L["Glancing Damage: "]..(spell.g_dmg or 0).."\r\n"

   tTip = tTip..L["Resisted hits: "]..(spell.r_amt or 0).."\r\n"
   tTip = tTip..L["Resisted Damage: "]..(spell.r_dmg or 0).."\r\n"

   tTip = tTip..L["Blocked hits: "]..(spell.b_amt or 0).."\r\n"
   tTip = tTip..L["Blocked Damage: "]..(spell.b_dmg or 0).."\r\n"

   tTip = tTip..L["Absorbed hits: "]..(spell.a_amt or 0).."\r\n"
   tTip = tTip..L["Absorbed Damage: "]..(spell.a_dmg or 0).."\r\n"

   return tTip
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:DamageMeterMenuBuilder()
   if Details == nil then
      local tNewMenuEntry = InjectMenuItemsNew(self, {L["Details addon not installed"]}, SkuGenericMenuItem)
      return
   end

   local tNewMenuEntry = InjectMenuItemsNew(self, {L["Reports"]}, SkuGenericMenuItem)
   tNewMenuEntry.dynamic = true
   tNewMenuEntry.BuildChildren = function(self)
      local tEmpty = true
      local tCombatId = -1
      local Combat = Details:GetCombat(1) -- -1 all
      while Details:GetCombat(tCombatId) ~= nil do
         local tNewMenuEntry
         
         local tTime = ""
         if Combat and Combat.end_time then
            tTime = Combat.data_fim
         end

         local tAll
         if tCombatId == -1 then
            tNewMenuEntry = InjectMenuItemsNew(self, {L["All fights"]}, SkuGenericMenuItem)
            tAll = true
         elseif tCombatId == 0 then
            tNewMenuEntry = InjectMenuItemsNew(self, {L["Current fight"].. " "..(Combat.enemy or L["unknown"]).." "..tTime}, SkuGenericMenuItem)
         else
            tNewMenuEntry = InjectMenuItemsNew(self, {L["Fight"].." "..tCombatId.. " "..(Combat.enemy or L["unknown"]).." "..tTime}, SkuGenericMenuItem)
         end
         tNewMenuEntry.combatID = tCombatId
         tNewMenuEntry.OnEnter = function(self, aValue, aName)
            local Combat = Details:GetCombat(self.combatID)
            local body = L["no data"]
            if Combat then
               body = BuildCombatTooltip(Combat, self.name, tAll)
            end
            SkuOptions.currentMenuPosition.textFirstLine, SkuOptions.currentMenuPosition.textFull = aName, body
         end

         tNewMenuEntry.BuildChildren = function(self)
            local Combat = Details:GetCombat(self.combatID)
            local tPlayerName = UnitName("player")

            local tActorList = Combat:GetActorList(DETAILS_ATTRIBUTE_DAMAGE)
            if tActorList then
               table.sort(tActorList, function(a, b)
                  return a.total / Combat:GetCombatTime() > b.total / Combat:GetCombatTime()
               end)
               for i, actor in ipairs(tActorList) do
                  if (Combat.playing_solo == true and actor.displayName == tPlayerName) or (Combat.playing_solo ~= true and Combat.raid_roster[actor.displayName]) or tAll == true then
                     self.dynamic = true
                     local efDPS = math.floor(actor.total / Combat:GetCombatTime())
                     tNewMenuEntrysub = InjectMenuItemsNew(self, {actor.nome.." "..(SkuQuest.classesFriendly[actor.classe] or L["unknown"]).." "..efDPS.." DPS"}, SkuGenericMenuItem)                  
                     if actor.spells and actor.spells._ActorTable then
                        tNewMenuEntrysub.spells = actor.spells._ActorTable
                     end
            
                     tNewMenuEntrysub.OnEnter = function(self, aValue, aName)
                        local tTips = {L["no data"]}
                        if self.spells then
                           tTips = {L["Spell details for "]..actor.nome.." "..(SkuQuest.classesFriendly[actor.classe] or L["unknown"]).." "..efDPS.." DPS"}

                           for iId, vDa in pairs(self.spells) do
                              local body = ""
                              if iId then
                                 if iId == 1 then
                                    body = body..L["Spell: "]..L["Melee combat"].."\r\n"
                                 elseif SkuDB.SpellDataTBC[iId] then
                                    body = body..L["Spell: "]..SkuDB.SpellDataTBC[iId][Sku.Loc][1].."\r\n"
                                 end
                                 local tPartTip = tDPSDetailsTooltip(vDa)
                                 body = body..tPartTip.."\r\n"
                              end
                              table.insert(tTips, body)
                           end
                        end
                        SkuOptions.currentMenuPosition.textFirstLine, SkuOptions.currentMenuPosition.textFull = aName, tTips
                     end
                  end
               end


               --DETAILS_ATTRIBUTE_HEAL
            end
         end

         tEmpty = false

         tCombatId = tCombatId + 1
         if tCombatId == 0 then
            tCombatId = tCombatId + 1
         end
         Combat = Details:GetCombat(tCombatId) -- -1 all
      end
      if tEmpty == true then
         local tNewMenuEntry = InjectMenuItemsNew(self, {L["empty"]}, SkuGenericMenuItem)
      end
   end

   local tNewMenuEntry = InjectMenuItemsNew(self, {L["Clear data"]}, SkuGenericMenuItem)
   tNewMenuEntry.isSelect = true
   tNewMenuEntry.OnAction = function(self, aValue, aName)
      Details:ResetSegmentData()
   end

end
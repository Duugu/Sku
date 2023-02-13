---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME, MODULE_PART = "SkuCore", "FriendsFrame"  
local L = Sku.L
local _G = _G

SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:FriendsOnInitialize()
   SkuCore:RegisterEvent("FRIENDLIST_UPDATE")
   
   hooksecurefunc(FriendsFrame, "Show", SkuCore.ONSHOW)
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:ONSHOW()
   SkuOptions:SlashFunc(L["short"]..",Core,"..L["Social"])
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:FRIENDLIST_UPDATE()
   --print("FRIENDLIST_UPDATE")
end

---------------------------------------------------------------------------------------------------------------------------------------
local function tAddFriendSubmenu(aParent, aIndex, aOnline, aIsBnet)
   local tNewMenuEntry = SkuOptions:InjectMenuItems(aParent, {L["edit note"]}, SkuGenericMenuItem)
   tNewMenuEntry.isSelect = true
   tNewMenuEntry.OnAction = function(self)
      SkuOptions:EditBoxShow(
         "",
         function(self)
            if aIsBnet then
               local accountInfo = C_BattleNet.GetFriendAccountInfo(aIndex)
               BNSetFriendNote(accountInfo.bnetAccountID, self:GetText() or "")
            else
               local info = C_FriendList.GetFriendInfoByIndex(aIndex)
               C_FriendList.SetFriendNotesByIndex(aIndex, self:GetText() or "")
            end
            C_Timer.After(0.65, function()
               SkuOptions.currentMenuPosition.parent:OnSelect()
               SkuOptions:VocalizeCurrentMenuName()
            end)
         end,
         nil
      )
      C_Timer.After(0.1, function()
         SkuOptions.Voice:OutputStringBTtts(L["Notiz eingeben und Enter drücken"], true, true, 0.1, nil, nil, nil, 1)
      end)
   end  



   local tNewMenuEntry = SkuOptions:InjectMenuItems(aParent, {L["remove"]}, SkuGenericMenuItem)
   tNewMenuEntry.isSelect = true
   tNewMenuEntry.OnAction = function(self)
      if aIsBnet then
         local accountInfo = C_BattleNet.GetFriendAccountInfo(aIndex)
         BNRemoveFriend(accountInfo.bnetAccountID)
      else
         local info = C_FriendList.GetFriendInfoByIndex(aIndex)
         C_FriendList.AddOrRemoveFriend(info.name, "")
      end
      C_Timer.After(0.65, function()
         SkuOptions.currentMenuPosition.parent.parent:OnSelect()
         SkuOptions:VocalizeCurrentMenuName()
      end)
   end  

   if aOnline == true then
      local tNewMenuEntry = SkuOptions:InjectMenuItems(aParent, {L["invite"]}, SkuGenericMenuItem)
      tNewMenuEntry.isSelect = true
      tNewMenuEntry.OnAction = function(self)
         if not aIsBnet then
            local info = C_FriendList.GetFriendInfoByIndex(aIndex)
            InviteUnit(info.name)
         end
      end  

      local tNewMenuEntry = SkuOptions:InjectMenuItems(aParent, {L["whisper"]}, SkuGenericMenuItem)
      tNewMenuEntry.isSelect = true
      tNewMenuEntry.OnAction = function(self)
         if aIsBnet then
            local accountInfo = C_BattleNet.GetFriendAccountInfo(aIndex)
            SkuChat:SetEditboxToCustom("BN_WHISPER", accountInfo.accountName, "")
         else
            local info = C_FriendList.GetFriendInfoByIndex(aIndex)
            SkuChat:SetEditboxToCustom("WHISPER", info.name, "")
         end
      end

   end
end

---------------------------------------------------------------------------------------------------------------------------------------
local function tAddWowFriend(aParent, aIndex, aOnline)
   local info = C_FriendList.GetFriendInfoByIndex(aIndex)
   --[[
   info = C_FriendList.GetFriendInfoByIndex(index)
   Key	Type	Description
   connected	boolean	If the friend is online
   name	string	
   className	string?	Friend's class, or "Unknown" (if offline)
   area	string?	Current location, or "Unknown" (if offline)
   notes	string?	
   guid	string	GUID, example: "Player-1096-085DE703"
   level	number	Friend's level, or 0 (if offline)
   dnd	boolean	If the friend's current status flag is DND
   afk	boolean	If the friend's current status flag is AFK
   rafLinkType	Enum.RafLinkType	
   mobile	boolean	
   ]]   
   if info.connected == true and aOnline == true then
      local tNewMenuEntry = SkuOptions:InjectMenuItems(aParent, {"wow: "..info.name.." - online"}, SkuGenericMenuItem)
      tNewMenuEntry.dynamic = true
      local tText = info.name.."\r\n"
      if info.dnd == true then
         tText = tText.."DND "
      end
      if info.afk == true then
         tText = tText.. "AFK "
      end
      if info.afk == true or info.dnd == true then
         tText = tText.."\r\n"
      end
      tText = tText..info.className.."\r\n"
      tText = tText.."level "..info.level.."\r\n"
      tText = tText..info.area.."\r\n"
      if info.notes then
         tText = tText..L["note"]..": "..info.notes.."\r\n"
      end
      tNewMenuEntry.textFull = tText
      tNewMenuEntry.BuildChildren = function(self)
         tAddFriendSubmenu(self, aIndex, aOnline, nil)
      end

   elseif info.connected ~= true and aOnline ~= true then
      local tNewMenuEntry = SkuOptions:InjectMenuItems(aParent, {"wow: "..info.name.." - offline"}, SkuGenericMenuItem)
      tNewMenuEntry.dynamic = true
      if info.notes then
         tNewMenuEntry.textFull = L["note"]..": "..info.notes.."\r\n"
      end
      tNewMenuEntry.BuildChildren = function(self)
         tAddFriendSubmenu(self, aIndex, aOnline, nil)
      end
      
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
local function tAddBnetFriend(aParent, aIndex, aOnline)
   local accountInfo = C_BattleNet.GetFriendAccountInfo(aIndex)
   --[[
   BNetAccountInfo?
   Key	Type	Description
   bnetAccountID	number	A temporary ID for the friend's battle.net account during this session
   accountName	string	A protected string representing the friend's full name or BattleTag name
   battleTag	string	The friend's BattleTag (e.g., "Nickname#0001")
   isFriend	boolean	
   isBattleTagFriend	boolean	Whether or not the friend is known by their BattleTag
   lastOnlineTime	number	The number of seconds elapsed since this friend was last online (from the epoch date of January 1, 1970). Returns nil if currently online.
   isAFK	boolean	Whether or not the friend is flagged as Away
   isDND	boolean	Whether or not the friend is flagged as Busy
   isFavorite	boolean	Whether or not the friend is marked as a favorite by you
   appearOffline	boolean	
   customMessage	string	The Battle.net broadcast message
   customMessageTime	number	The number of seconds elapsed since the current broadcast message was sent
   note	string	The contents of the player's note about this friend
   rafLinkType	Enum.RafLinkType	Enum.RafLinkType
   gameAccountInfo	BNetGameAccountInfo	

      BNetGameAccountInfo
      Key	Type	Description
      gameAccountID	number?	A temporary ID for the friend's battle.net game account during this session.
      clientProgram	string	BNET_CLIENT
      isOnline	boolean	
      isGameBusy	boolean	
      isGameAFK	boolean	
      wowProjectID	number?	
      characterName	string?	The name of the logged in toon/character
      realmName	string?	The name of the logged in realm
      realmDisplayName	string?	
      realmID	number?	The ID for the logged in realm
      factionName	string?	The englishFaction name (i.e., "Alliance" or "Horde")
      raceName	string?	The localized race name (e.g., "Blood Elf")
      className	string?	The localized class name (e.g., "Death Knight")
      areaName	string?	The localized zone name (e.g., "The Undercity")
      characterLevel	number?	The current level (e.g., "90")
      richPresence	string?	For WoW, returns "zoneName - realmName". For StarCraft 2 and Diablo 3, returns the location or activity the player is currently engaged in.
      playerGuid	string?	A unique numeric identifier for the friend's character during this session.
      isWowMobile	boolean	
      canSummon	boolean	
      hasFocus	boolean	Whether or not this toon is the one currently being displayed in Blizzard's FriendFrame
      regionID	number	Added in 9.1.0
      isInCurrentRegion	boolean	Added in 9.1.0

      BNET_CLIENT
      Global	Value	Description
      BNET_CLIENT_WOW	WoW	World of Warcraft
      BNET_CLIENT_SC2	S2	StarCraft 2
      BNET_CLIENT_D3	D3	Diablo 3
      BNET_CLIENT_WTCG	WTCG	Hearthstone
      BNET_CLIENT_APP	App	Battle.net desktop app
      BSAp	Battle.net mobile app
      BNET_CLIENT_HEROES	Hero	Heroes of the Storm
      BNET_CLIENT_OVERWATCH	Pro	Overwatch
      BNET_CLIENT_CLNT	CLNT	
      BNET_CLIENT_SC	S1	StarCraft: Remastered
      BNET_CLIENT_DESTINY2	DST2	Destiny 2
      BNET_CLIENT_COD	VIPR	Call of Duty: Black Ops 4
      BNET_CLIENT_COD_MW	ODIN	Call of Duty: Modern Warfare
      BNET_CLIENT_COD_MW2	LAZR	Call of Duty: Modern Warfare 2
      BNET_CLIENT_COD_BOCW	ZEUS	Call of Duty: Black Ops Cold War
      BNET_CLIENT_WC3	W3	Warcraft III: Reforged
      BNET_CLIENT_ARCADE	RTRO	Blizzard Arcade Collection
      BNET_CLIENT_CRASH4	WLBY	Crash Bandicoot 4
      BNET_CLIENT_D2	OSI	Diablo II: Resurrected
      BNET_CLIENT_COD_VANGUARD	FORE	Call of Duty: Vanguard
      BNET_CLIENT_DI	ANBS	Diablo Immortal
      BNET_CLIENT_ARCLIGHT	GRY	Warcraft Arclight Rumble
   ]]
   if accountInfo and accountInfo.gameAccountInfo and accountInfo.gameAccountInfo.isOnline == true and aOnline == true then
      local tNewMenuEntry = SkuOptions:InjectMenuItems(aParent, {"Bnet: "..accountInfo.battleTag.." - online"}, SkuGenericMenuItem)
      tNewMenuEntry.dynamic = true
      local tText = accountInfo.battleTag.."\r\n"
      if accountInfo.isDND == true then
         tText = tText.."DND "
      end
      if accountInfo.isAFK == true then
         tText = tText.. "AFK "
      end
      if accountInfo.isAFK == true or accountInfo.isDND == true then
         tText = tText.."\r\n"
      end
      if accountInfo.gameAccountInfo.richPresence then
         tText = tText..accountInfo.gameAccountInfo.richPresence.."\r\n"
      end
      if accountInfo.gameAccountInfo.characterName then
         tText = tText..accountInfo.gameAccountInfo.characterName.."\r\n"
      end   
      if accountInfo.gameAccountInfo.factionName then
         tText = tText..accountInfo.gameAccountInfo.factionName.."\r\n"
      end
      if accountInfo.gameAccountInfo.raceName then
         tText = tText..accountInfo.gameAccountInfo.raceName.."\r\n"
      end
      if accountInfo.gameAccountInfo.className then
         tText = tText..accountInfo.gameAccountInfo.className.."\r\n"
      end
      if accountInfo.gameAccountInfo.characterLevel then
         tText = tText.."level "..accountInfo.gameAccountInfo.characterLevel.."\r\n"
      end
      if accountInfo.gameAccountInfo.areaName then
         tText = tText..accountInfo.gameAccountInfo.areaName.."\r\n"
      end
      if accountInfo.note and accountInfo.note ~= "" then
         tText = tText..L["note"]..": "..accountInfo.note.."\r\n"
      end
      tNewMenuEntry.textFull = tText
      tNewMenuEntry.BuildChildren = function(self)
         tAddFriendSubmenu(self, aIndex, aOnline, true)
      end

   elseif accountInfo and accountInfo.gameAccountInfo and accountInfo.gameAccountInfo.isOnline ~= true and aOnline ~= true then
      local tNewMenuEntry = SkuOptions:InjectMenuItems(aParent, {"Bnet: "..accountInfo.battleTag.." - offline"}, SkuGenericMenuItem)
      tNewMenuEntry.dynamic = true
      local tText = accountInfo.battleTag.."\r\n"
      if accountInfo.note and accountInfo.note ~= "" then
         tText = tText..L["note"]..": "..accountInfo.note
      end
      if accountInfo.lastOnlineTime then
         tText = tText..L["last online"]..": "..SkuEpochValueHelper(accountInfo.lastOnlineTime)
      end
      tNewMenuEntry.textFull = tText
      tNewMenuEntry.BuildChildren = function(self)
         tAddFriendSubmenu(self, aIndex, aOnline, true)
      end
   end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:FriendsMenuBuilder()
   local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Contacts"]}, SkuGenericMenuItem)
   tNewMenuEntry.dynamic = true
   tNewMenuEntry.BuildChildren = function(self)

      local tNewMenuEntryContacts = SkuOptions:InjectMenuItems(self, {L["Friend List"]}, SkuGenericMenuItem)
      tNewMenuEntryContacts.dynamic = true
      tNewMenuEntryContacts.filterable = true
      tNewMenuEntryContacts.OnEnter = function(self, aValue, aName, aEnterFlag)
         C_FriendList.ShowFriends()
      end
      tNewMenuEntryContacts.BuildChildren = function(self)
         local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["add friend"]}, SkuGenericMenuItem)
         tNewMenuEntry.isSelect = true
         tNewMenuEntry.OnAction = function(self)
            SkuOptions:EditBoxShow("", function(self)
               if self:GetText() and self:GetText() ~= "" then
                  C_FriendList.AddFriend(self:GetText())
               end
               PlaySound(89)
               C_Timer.After(0.65, function()
                  SkuOptions.currentMenuPosition.parent:OnSelect()
                  SkuOptions:VocalizeCurrentMenuName()
               end)
            end)					
            SkuOptions.Voice:OutputStringBTtts(L["name eingeben und Enter drücken"], true, true, 0.2, nil, nil, nil, 2)
         end
         
         local tNumFriends = C_FriendList.GetNumFriends()
         for x = 1, tNumFriends do
            tAddWowFriend(self, x, true)
         end
         local numBNetTotal, numBNetOnline, numBNetFavorite, numBNetFavoriteOnline = BNGetNumFriends()
         for x = 1, numBNetTotal do
            tAddBnetFriend(self, x, true)
         end
         for x = 1, tNumFriends do
            tAddWowFriend(self, x, false)
         end
         for x = 1, numBNetTotal do
            tAddBnetFriend(self, x, false)
         end      
      end
      
      local tNewMenuEntryIgnore = SkuOptions:InjectMenuItems(self, {L["Ignore List"]}, SkuGenericMenuItem)
      tNewMenuEntryIgnore.dynamic = true
      tNewMenuEntryIgnore.BuildChildren = function(self)
         local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["noch nicht implementiert"]}, SkuGenericMenuItem)
      end

   end

   local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Who"]}, SkuGenericMenuItem)
   tNewMenuEntry.dynamic = true
   tNewMenuEntry.BuildChildren = function(self)

      local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["noch nicht implementiert"]}, SkuGenericMenuItem)

   end

   local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["Guild"]}, SkuGenericMenuItem)
   tNewMenuEntry.dynamic = true
   tNewMenuEntry.BuildChildren = function(self)

      local tNewMenuEntry = SkuOptions:InjectMenuItems(self, {L["noch nicht implementiert"]}, SkuGenericMenuItem)

   end
end
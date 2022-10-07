---------------------------------------------------------------------------------------------------------------------------------------
local MODULE_NAME = "SkuCore"
SkuCore = SkuCore or LibStub("AceAddon-3.0"):NewAddon("SkuCore", "AceConsole-3.0", "AceEvent-3.0")
local L = Sku.L
---------------------------------------------------------------------------------------------------------------------------------------
function MacroMenuBuilderNew(aParent)
    local  tNameMenuEntry= SkuOptions:InjectMenuItems(aParent, { L["MacroName"] }, SkuGenericMenuItem)
    tNameMenuEntry.dynamic = true

    tNameMenuEntry.OnAction = function(self)
        PlaySound(88)
        SkuOptions.Voice:OutputStringBTtts(L["EnterMacroName"], false, true, 0.2)
        SkuOptions:EditBoxShow("", function(self)
            local tText = SkuOptionsEditBoxEditBox:GetText()
            aParent["Name"] = tText
        end)
    end

    aParent["MacroScope"] = nil
    local tScopeMenuEntry= SkuOptions:InjectMenuItems(aParent, { L["MacroScope"] }, SkuGenericMenuItem)
    tScopeMenuEntry.BuildChildren = function(self)
        local tGlobalMenuEntry = SkuOptions:InjectMenuItems(self, { L["MacroScopeGlobal"] }, SkuGenericMenuItem)
        tGlobalMenuEntry .OnAction = function(self)
            aParent["MacroScope"] = nil
        end
        local tCharMenuEntry = SkuOptions:InjectMenuItems(self, { L["MacroScopeChar"] }, SkuGenericMenuItem)
        tCharMenuEntry.OnAction = function(self)
            aParent["MacroScope"] = 1
        end
    end

    local tMacroBodyMenuEntry = SkuOptions:InjectMenuItems(aParent, { L["MacroBody"] }, SkuGenericMenuItem)
    tMacroBodyMenuEntry .OnAction = function(self)
        PlaySound(88)
        SkuOptions.Voice:OutputStringBTtts(L["EnterMacroBody"], false, true, 0.2)
        SkuOptions:EditBoxShow("", function(self)
            local tText = SkuOptionsEditBoxEditBox:GetText()
            aParent["MacroBody"] = tText
        end)
    end

    local tCreateMenuEntry = SkuOptions:InjectMenuItems(aParent, { L["CreateMacro"] }, SkuGenericMenuItem)
    tCreateMenuEntry.OnAction = function(self)
        if aParent["Name"] == nil or aParent["Name"] == '' then
            SkuOptions.Voice:OutputStringBTtts(L["MissingMacroName"], false, true, 0.2)
            return
        end
        if aParent["MacroBody"] == nil or aParent["MacroBody"] == '' then
            SkuOptions.Voice:OutputStringBTtts(L["MissingMacroBody"], false, true, 0.2)
            return
        end

        CreateMacro(aParent["Name"], "INV_MISC_QUESTIONMARK", aParent["MacroBody"], aParent["MacroScope"])
        aParent["Name"]=nil
        aParent["MacroBody"]=nil
        aParent["MacroScope"]=nil
    end
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuCore:MacroMenuBuilder()
    local aParent = self
    local tNewMenuEntry = SkuOptions:InjectMenuItems(aParent, { L["NewMacro"] }, SkuGenericMenuItem)
    tNewMenuEntry.dynamic = true
    tNewMenuEntry.BuildChildren = MacroMenuBuilderNew
MacroMenuBuilderList(aParent)
end

function MacroMenuBuilderList(aParent)
    local firstCharNumber=37
    local tGlobalMenuEntry = SkuOptions:InjectMenuItems(aParent, { L["MacroScopeGlobal"] }, SkuGenericMenuItem) 
    tGlobalMenuEntry.BuildChildren=function(self)
        local numGlobal,numChar = GetNumMacros()
        for i=1,numGlobal do 
            local currentMacro=GetMacroInfo(i)
            local tGlobalEntry= SkuOptions:InjectMenuItems(tGlobalMenuEntry, {currentMacro.name }, SkuGenericMenuItem) 
        end
    end
end
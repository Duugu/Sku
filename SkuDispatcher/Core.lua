local MODULE_NAME = "SkuDispatcher"
local _G = _G
local L = Sku.L

SkuDispatcher = LibStub("AceAddon-3.0"):NewAddon("SkuDispatcher", "AceConsole-3.0", "AceEvent-3.0")

---------------------------------------------------------------------------------------------------------------------------------------
SkuDispatcher.Registered = {}

---------------------------------------------------------------------------------------------------------------------------------------
function SkuDispatcher:OnDisable()
	
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuDispatcher:OnInitialize()

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuDispatcher:OnEnable()

end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuDispatcher:UnregisterEventCallback(aEventName, aCallbackFunc)
	if not SkuDispatcher.Registered[aEventName] then
		return
	end

	if not SkuDispatcher.Registered[aEventName].callbacks[aCallbackFunc] then
		return
	end

	SkuDispatcher.Registered[aEventName].callbacks[aCallbackFunc] = nil

	for i, v in pairs(SkuDispatcher.Registered[aEventName].callbacks) do
		return
	end

	-- no callbacks left > unregister event
	SkuDispatcher:UnregisterEvent(aEventName)
	SkuDispatcher[aEventName] = nil
	SkuDispatcher.Registered[aEventName] = nil
end

---------------------------------------------------------------------------------------------------------------------------------------
function SkuDispatcher:RegisterEventCallback(aEventName, aCallbackFunc)
	if not SkuDispatcher.Registered[aEventName] then
		SkuDispatcher[aEventName] = function(...)
			for callbackFunc in pairs(SkuDispatcher.Registered[aEventName].callbacks) do
				callbackFunc(...)
			end
		end

		SkuDispatcher.Registered[aEventName] = {
			handler = SkuDispatcher[aEventName],
			callbacks = {},
		}

		SkuDispatcher:RegisterEvent(aEventName)
	end

	if not SkuDispatcher.Registered[aEventName].callbacks[aCallbackFunc] then
		SkuDispatcher.Registered[aEventName].callbacks[aCallbackFunc] = true
	end
end
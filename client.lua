local oldPrint = print
print = function(trash)
	oldPrint('^7[^2Rise Ozel Mesaj^7] '..trash..'^0')
end

--[[
    Variables
]]
local lastSender = ""

--[[
    Reply Commands
]]
RegisterCommand("r", function(source, args, rawCommand) --[[ Reply Command ]]
    if lastSender == nil then
        TriggerEvent('rise-pm:error', 'You haven\'t yet gotten any private messages.')
    else
        TriggerServerEvent('rise-pm:reply', lastSender, args)
    end
end, false)
RegisterCommand("reply", function(source, args, rawCommand) --[[ Reply Command ]]
    if lastSender == nil then
        TriggerEvent('rise-pm:error', 'You haven\'t yet gotten any private messages.')
    else
        TriggerServerEvent('rise-pm:reply', lastSender, args)
    end
end, false)

--[[
    Chat Suggestions
]]
if Config.chatSuggestions then
    AddEventHandler('onClientResourceStart', function (resourceName)
        if (GetCurrentResourceName() == resourceName) then
            TriggerEvent('chat:addSuggestion', '/pm', 'Send someone a private message', {
                { name="id", help="Enter target player id." },
                { name="message", help="Enter the message." }
            })
            TriggerEvent('chat:addSuggestion', '/r', 'Reply to last private message', {
                { name="message", help="Enter the message." }
            })
            TriggerEvent('chat:addSuggestion', '/reply', 'Reply to last private message', {
                { name="message", help="Enter the message." }
            })
        end
    end)
    AddEventHandler('onClientResourceStop', function(resourceName)
        if (GetCurrentResourceName() == resourceName) then
            TriggerEvent('chat:removeSuggestion', '/pm')
            TriggerEvent('chat:removeSuggestion', '/r')
            TriggerEvent('chat:removeSuggestion', '/reply')
        end
    end)
end


--[[
    Registered Events
]]
RegisterNetEvent('rise-pm:error')
AddEventHandler('rise-pm:error', function(err)
    TriggerEvent("chatMessage", "^7[^1Error^7]", {255,0,0}, err )
end)

RegisterNetEvent('rise-pm:lastSender')
AddEventHandler('rise-pm:lastSender', function(sender)
    lastSender = sender
end)

--[[ Taken from mythic_notify (https://github.com/wowpanda/mythic_notify) ]]
RegisterNetEvent("rise-pm:SendAlert")
AddEventHandler("rise-pm:SendAlert", function(data)
    SendNUIMessage({
		action = 'notif',
		type = data.type,
		text = data.text
	})
end)
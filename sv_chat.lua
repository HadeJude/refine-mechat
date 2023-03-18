RegisterNetEvent('_chat:messageEntered', function(author, color, message)
    if not message or not author then
        return
    end
    TriggerEvent('chatMessage', source, author, message)
end)

RegisterNetEvent('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)

    TriggerEvent('chatMessage', source, name, '/' .. command)

    if not WasEventCanceled() then
        TriggerClientEvent('chatMessage', -1, name, false, '/' .. command) 
    end

    CancelEvent()
end)


-- command suggestions for clients
local function refreshCommands(player)
    if GetRegisteredCommands then
        local registeredCommands = GetRegisteredCommands()

        local suggestions = {}

        for _, command in ipairs(registeredCommands) do
            if IsPlayerAceAllowed(player, ('command.%s'):format(command.name)) then
                table.insert(suggestions, {
                    name = '/' .. command.name,
                    help = ''
                })
            end
        end

        TriggerClientEvent('chat:addSuggestions', player, suggestions)
    end
end

RegisterNetEvent('chat:init', function()
    refreshCommands(source)
end)

RegisterNetEvent('onServerResourceStart', function(resName)
    Wait(500)

    for _, player in ipairs(GetPlayers()) do
        refreshCommands(player)
    end
end)

RegisterCommand('me', function(source, args)
    local src = source
    local ped = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(ped)
    local msg = table.concat(args, ' '):gsub('[~<].-[>~]', '')
    local Players = GetPlayers()
    local QBCore = exports['qb-core']:GetCoreObject()
    local Identity = QBCore.Functions.GetPlayer(src)

    for i=1, #Players do
        local Player = Players[i]
        local target = GetPlayerPed(Player)
        local tCoords = GetEntityCoords(target)
        if target == ped or #(playerCoords - tCoords) < 8.0 then
            TriggerClientEvent("me:client:command", Player, src, msg)
            TriggerClientEvent('chat:addMessage', Player, {
                color = { 0, 0, 255},
                multiline = true,
                args = {'' .. Identity.PlayerData.charinfo.firstname .. ' ' .. Identity.PlayerData.charinfo.lastname, msg}
            })
        end
    end
end)

local name = 'Anon'

RegisterCommand('mename', function(source, args)
    local msg = table.concat(args, ' '):gsub('[~<].-[>~]', '')
    name = msg
end)

RegisterCommand('mea', function(source, args)
    local src = source
    local ped = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(ped)
    local msg = table.concat(args, ' '):gsub('[~<].-[>~]', '')
    local Players = GetPlayers()
    local QBCore = exports['qb-core']:GetCoreObject()
    local Identity = QBCore.Functions.GetPlayer(src)

    for i=1, #Players do
        local Player = Players[i]
        local target = GetPlayerPed(Player)
        local tCoords = GetEntityCoords(target)
        if target == ped or #(playerCoords - tCoords) < 8.0 then
            TriggerClientEvent("me:client:command", Player, src, msg)
            TriggerClientEvent('chat:addMessage', Player, {
                color = { 0, 0, 255},
                multiline = true,
                args = {name, msg}
            })
        end
    end
end)

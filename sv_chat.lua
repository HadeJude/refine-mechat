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

if Config.DoEnable then
    RegisterCommand('do', function(source, args)
        local src = source
        local ped = GetPlayerPed(src)
        local playerCoords = GetEntityCoords(ped)
        local msg = table.concat(args, ' '):gsub('[~<].-[>~]', '')
        local Players = GetPlayers()
        local QBCore = exports['qb-core']:GetCoreObject()
        local Identity = QBCore.Functions.GetPlayer(src)
        local firstName = Identity.PlayerData.charinfo.firstname
        local lastName = Identity.PlayerData.charinfo.lastname
        local fullName = Config.NameDoChat and (firstName .. ' ' .. lastName) or 'DO'
    
        for i = 1, #Players do
            local Player = Players[i]
            local target = GetPlayerPed(Player)
            local tCoords = GetEntityCoords(target)
            
            if target == ped or #(playerCoords - tCoords) < 8.0 then
                local meMsg = '*' .. msg .. '*'
                local chatMsg = msg
                local chatArgs = { color = { 0, 0, 255 }, multiline = true, args = { fullName, chatMsg } }
                
                if Config.NameDo then
                    meMsg = fullName .. ': ' .. meMsg
                else
                    meMsg = meMsg
                end
                
                if not Config.NameDoChat then
                    chatArgs.args[1] = 'DO'
                end
                
                TriggerClientEvent("do:client:command", Player, src, meMsg)
                TriggerClientEvent('chat:addMessage', Player, chatArgs)
            end
        end
    end)
end

if Config.MedEnable then
    RegisterCommand('med', function(source, args)
        local src = source
        local ped = GetPlayerPed(src)
        local playerCoords = GetEntityCoords(ped)
        local msg = table.concat(args, ' '):gsub('[~<].-[>~]', '')
        local Players = GetPlayers()
        local QBCore = exports['qb-core']:GetCoreObject()
        local Identity = QBCore.Functions.GetPlayer(src)
        local firstName = Identity.PlayerData.charinfo.firstname
        local lastName = Identity.PlayerData.charinfo.lastname
        local fullName = Config.NameMedChat and (firstName .. ' ' .. lastName) or 'MED'
    
        for i = 1, #Players do
            local Player = Players[i]
            local target = GetPlayerPed(Player)
            local tCoords = GetEntityCoords(target)
            
            if target == ped or #(playerCoords - tCoords) < 8.0 then
                local meMsg = '*' .. msg .. '*'
                local chatMsg = msg
                local chatArgs = { color = { 0, 0, 255 }, multiline = true, args = { fullName, chatMsg } }
                
                if Config.NameMed then
                    meMsg = fullName .. ': ' .. meMsg
                else
                    meMsg = meMsg
                end
                
                if not Config.NameMedChat then
                    chatArgs.args[1] = 'MED'
                end
                
                TriggerClientEvent("med:client:command", Player, src, meMsg)
                TriggerClientEvent('chat:addMessage', Player, chatArgs)
            end
        end
    end)
end


if Config.MeEnable then
    RegisterCommand('me', function(source, args)
        local src = source
        local ped = GetPlayerPed(src)
        local playerCoords = GetEntityCoords(ped)
        local msg = table.concat(args, ' '):gsub('[~<].-[>~]', '')
        local Players = GetPlayers()
        local QBCore = exports['qb-core']:GetCoreObject()
        local Identity = QBCore.Functions.GetPlayer(src)
        local firstName = Identity.PlayerData.charinfo.firstname
        local lastName = Identity.PlayerData.charinfo.lastname
        local fullName = Config.NameMeChat and (firstName .. ' ' .. lastName) or 'ME'

        for i = 1, #Players do
            local Player = Players[i]
            local target = GetPlayerPed(Player)
            local tCoords = GetEntityCoords(target)
            
            if target == ped or #(playerCoords - tCoords) < 8.0 then
                local meMsg = '*' .. msg .. '*'
                local chatMsg = msg
                local chatArgs = { color = { 0, 0, 255 }, multiline = true, args = { fullName, chatMsg } }
                
                if Config.NameMe then
                    meMsg = fullName .. ': ' .. meMsg
                else
                    meMsg = meMsg
                end
                
                if not Config.NameMeChat then
                    chatArgs.args[1] = 'ME'
                end
                
                TriggerClientEvent("me:client:command", Player, src, meMsg, 255, 255, 255)
                TriggerClientEvent('chat:addMessage', Player, chatArgs)
            end
        end
    end)
end


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

if Config.JobCall then
    RegisterCommand('911', function(source, args)
        local src = source
        local ped = GetPlayerPed(src)
        local playerCoords = GetEntityCoords(ped)
        local msg = table.concat(args, ' '):gsub('[~<].-[>~]', '')
        local QBCore = exports['qb-core']:GetCoreObject()
        local Player = QBCore.Functions.GetPlayer(src)
        local Count = QBCore.Functions.GetQBPlayers()
        local firstName = Player.PlayerData.charinfo.firstname
        local lastName = Player.PlayerData.charinfo.lastname
        local cid = Player.PlayerData.source
        local fullName = '( '.. cid ..' ) ' .. firstName .. ' ' .. lastName
        for _, v in pairs(Count) do
            if v and v.PlayerData.job.name == Config.PolJob and v.PlayerData.job.onduty then
                TriggerClientEvent("chat:addMessage", v.PlayerData.source, {
                    template = '<div style="padding: 0.25vw; margin: 0.1vw; border-radius: 2px; background-color: rgba(2, 67, 253, 0.650); border: 2px solid rgb(2, 67, 253);"><i class="fas fa-user-shield"style="font-size:15px"></i> <b>DISPATCH</b> | {0} </font></i></b></div>',
                    multiline = true,
                    args = {fullName .. ' : ' .. msg}
                })
            end
        end
    end)

    RegisterCommand('311', function(source, args)
        local src = source
        local ped = GetPlayerPed(src)
        local playerCoords = GetEntityCoords(ped)
        local msg = table.concat(args, ' '):gsub('[~<].-[>~]', '')
        local QBCore = exports['qb-core']:GetCoreObject()
        local Player = QBCore.Functions.GetPlayer(src)
        local Count = QBCore.Functions.GetQBPlayers()
        local firstName = Player.PlayerData.charinfo.firstname
        local lastName = Player.PlayerData.charinfo.lastname
        local cid = Player.PlayerData.source
        local fullName = '( '.. cid ..' ) ' .. firstName .. ' ' .. lastName
        for _, v in pairs(Count) do
            if v and v.PlayerData.job.name == Config.EmsJob and v.PlayerData.job.onduty then
                TriggerClientEvent("chat:addMessage", v.PlayerData.source, {
                    template = '<div style="padding: 0.25vw; margin: 0.1vw; border-radius: 2px; background-color: rgba(254, 1, 3, 0.650); border: 2px solid rgb(254, 1, 3);"><i class="fas fa-user-nurse"style="font-size:15px"></i> <b>DISPATCH</b> | {0} </font></i></b></div>',
                    multiline = true,
                    args = {fullName .. ' : ' .. msg}
                })
            end
        end
    end)

    RegisterCommand('911a', function(source, args)
        local src = source
        local ped = GetPlayerPed(src)
        local playerCoords = GetEntityCoords(ped)
        local msg = table.concat(args, ' '):gsub('[~<].-[>~]', '')
        local QBCore = exports['qb-core']:GetCoreObject()
        local Count = QBCore.Functions.GetQBPlayers()
        for _, v in pairs(Count) do
            if v and v.PlayerData.job.name == Config.PolJob and v.PlayerData.job.onduty then
                TriggerClientEvent("chat:addMessage", v.PlayerData.source, {
                    template = '<div style="padding: 0.25vw; margin: 0.1vw; border-radius: 2px; background-color: rgba(2, 67, 253, 0.650); border: 2px solid rgb(2, 67, 253);"><i class="fas fa-user-shield"style="font-size:15px"></i> <b>DISPATCH</b> | {0} </font></i></b></div>',
                    multiline = true,
                    args = {'Anon : ' .. msg}
                })
            end
        end
    end)

    RegisterCommand('311a', function(source, args)
        local src = source
        local ped = GetPlayerPed(src)
        local playerCoords = GetEntityCoords(ped)
        local msg = table.concat(args, ' '):gsub('[~<].-[>~]', '')
        local QBCore = exports['qb-core']:GetCoreObject()
        local Count = QBCore.Functions.GetQBPlayers()
        for _, v in pairs(Count) do
            if v and v.PlayerData.job.name == Config.EmsJob and v.PlayerData.job.onduty then
                TriggerClientEvent("chat:addMessage", v.PlayerData.source, {
                    template = '<div style="padding: 0.25vw; margin: 0.1vw; border-radius: 2px; background-color: rgba(254, 1, 3, 0.650); border: 2px solid rgb(254, 1, 3);"><i class="fas fa-user-nurse"style="font-size:15px"></i> <b>DISPATCH</b> | {0} </font></i></b></div>',
                    multiline = true,
                    args = {'Anon : ' .. msg}
                })
            end
        end
    end)
end

if Config.JobCallReply then
    RegisterCommand('911r', function(source, args)
        local src = source
        local playerId = tonumber(args[1])
        local msg = table.concat(args, ' ', 2):gsub('[~<].-[>~]', '')
        local QBCore = exports['qb-core']:GetCoreObject()

        local PlayerGet = QBCore.Functions.GetPlayer(playerId)

        if msg == '' then return end
        if not PlayerGet then return TriggerClientEvent('QBCore:Notify', src, 'Player is not online', 'error') end

        local Count = QBCore.Functions.GetQBPlayers()
        local Player = QBCore.Functions.GetPlayer(src)
        for _, v in pairs(Count) do
            if v and v.PlayerData.job.name == Config.PolJob and v.PlayerData.job.onduty then
                TriggerClientEvent("chat:addMessage", v.PlayerData.source, {
                    template = '<div style="padding: 0.25vw; margin: 0.1vw; border-radius: 2px; background-color: rgba(190, 97, 18, 0.650); border: 2px solid rgb(190, 97, 18);"><i class="fas fa-reply"style="font-size:15px"></i> <b>DISPATCH</b> | {0} </font></i></b></div>',
                    multiline = true,
                    args = {Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname .. ' | Reply '.. '( '.. PlayerGet.PlayerData.source ..' ) ' .. PlayerGet.PlayerData.charinfo.firstname .. ' : ' .. msg}
                })
                TriggerClientEvent("chat:addMessage", PlayerGet.PlayerData.source, {
                    template = '<div style="padding: 0.25vw; margin: 0.1vw; border-radius: 2px; background-color: rgba(190, 97, 18, 0.650); border: 2px solid rgb(190, 97, 18);"><i class="fas fa-reply"style="font-size:15px"></i> <b>MESSAGE</b> | {0} </font></i></b></div>',
                    multiline = true,
                    args = {' Reply : ' .. msg}
                })
            end
        end
    end)

    RegisterCommand('311r', function(source, args)
        local src = source
        local playerId = tonumber(args[1])
        local msg = table.concat(args, ' ', 2):gsub('[~<].-[>~]', '')
        local QBCore = exports['qb-core']:GetCoreObject()

        local PlayerGet = QBCore.Functions.GetPlayer(playerId)

        if msg == '' then return end
        if not PlayerGet then return TriggerClientEvent('QBCore:Notify', src, 'Player is not online', 'error') end

        local Count = QBCore.Functions.GetQBPlayers()
        local Player = QBCore.Functions.GetPlayer(src)
        for _, v in pairs(Count) do
            if v and v.PlayerData.job.name == Config.EmsJob and v.PlayerData.job.onduty then
                TriggerClientEvent("chat:addMessage", v.PlayerData.source, {
                    template = '<div style="padding: 0.25vw; margin: 0.1vw; border-radius: 2px; background-color: rgba(190, 97, 18, 0.650); border: 2px solid rgb(190, 97, 18);"><i class="fas fa-reply"style="font-size:15px"></i> <b>DISPATCH</b> | {0} </font></i></b></div>',
                    multiline = true,
                    args = {Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname .. ' | Reply '.. '( '.. PlayerGet.PlayerData.source ..' ) ' .. PlayerGet.PlayerData.charinfo.firstname .. ' : ' .. msg}
                })
                TriggerClientEvent("chat:addMessage", PlayerGet.PlayerData.source, {
                    template = '<div style="padding: 0.25vw; margin: 0.1vw; border-radius: 2px; background-color: rgba(190, 97, 18, 0.650); border: 2px solid rgb(190, 97, 18);"><i class="fas fa-reply"style="font-size:15px"></i> <b>MESSAGE</b> | {0} </font></i></b></div>',
                    multiline = true,
                    args = {' Reply : ' .. msg}
                })
            end
        end
    end)
end

RegisterNetEvent('refine-mechat:dispatch:police', function(msg)
    local src = source
    local ped = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(ped)
    local msg = table.concat(args, ' '):gsub('[~<].-[>~]', '')
    local QBCore = exports['qb-core']:GetCoreObject()
    local Player = QBCore.Functions.GetPlayer(src)
    local Count = QBCore.Functions.GetQBPlayers()
    local firstName = Player.PlayerData.charinfo.firstname
    local lastName = Player.PlayerData.charinfo.lastname
    local cid = Player.PlayerData.source
    local fullName = '( '.. cid ..' ) ' .. firstName .. ' ' .. lastName
    for _, v in pairs(Count) do
        if v and v.PlayerData.job.name == Config.PolJob and v.PlayerData.job.onduty then
            TriggerClientEvent("chat:addMessage", v.PlayerData.source, {
                template = '<div style="padding: 0.25vw; margin: 0.1vw; border-radius: 2px; background-color: rgba(2, 67, 253, 0.650); border: 2px solid rgb(2, 67, 253);"><i class="fas fa-user-shield"style="font-size:15px"></i> <b>DISPATCH</b> | {0} </font></i></b></div>',
                multiline = true,
                args = {fullName .. ' : ' .. msg}
            })
        end
    end
end)

RegisterNetEvent('refine-mechat:dispatch:ambulance', function(msg)
    local src = source
    local ped = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(ped)
    local msg = table.concat(args, ' '):gsub('[~<].-[>~]', '')
    local QBCore = exports['qb-core']:GetCoreObject()
    local Player = QBCore.Functions.GetPlayer(src)
    local Count = QBCore.Functions.GetQBPlayers()
    local firstName = Player.PlayerData.charinfo.firstname
    local lastName = Player.PlayerData.charinfo.lastname
    local cid = Player.PlayerData.source
    local fullName = '( '.. cid ..' ) ' .. firstName .. ' ' .. lastName
    for _, v in pairs(Count) do
        if v and v.PlayerData.job.name == Config.EmsJob and v.PlayerData.job.onduty then
            TriggerClientEvent("chat:addMessage", v.PlayerData.source, {
                template = '<div style="padding: 0.25vw; margin: 0.1vw; border-radius: 2px; background-color: rgba(254, 1, 3, 0.650); border: 2px solid rgb(254, 1, 3);"><i class="fas fa-user-nurse"style="font-size:15px"></i> <b>DISPATCH</b> | {0} </font></i></b></div>',
                multiline = true,
                args = {fullName .. ' : ' .. msg}
            })
        end
    end
end)

RegisterNetEvent('refine-mechat:anon:police', function(msg)
    local src = source
    local ped = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(ped)
    local msg = table.concat(args, ' '):gsub('[~<].-[>~]', '')
    local QBCore = exports['qb-core']:GetCoreObject()
    local Count = QBCore.Functions.GetQBPlayers()
    for _, v in pairs(Count) do
        if v and v.PlayerData.job.name == Config.PolJob and v.PlayerData.job.onduty then
            TriggerClientEvent("chat:addMessage", v.PlayerData.source, {
                template = '<div style="padding: 0.25vw; margin: 0.1vw; border-radius: 2px; background-color: rgba(2, 67, 253, 0.650); border: 2px solid rgb(2, 67, 253);"><i class="fas fa-user-shield"style="font-size:15px"></i> <b>DISPATCH</b> | {0} </font></i></b></div>',
                multiline = true,
                args = {'Anon : ' .. msg}
            })
        end
    end
end)

RegisterNetEvent('refine-mechat:anon:ambulance', function(msg)
    local src = source
    local ped = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(ped)
    local msg = table.concat(args, ' '):gsub('[~<].-[>~]', '')
    local QBCore = exports['qb-core']:GetCoreObject()
    local Count = QBCore.Functions.GetQBPlayers()
    for _, v in pairs(Count) do
        if v and v.PlayerData.job.name == Config.EmsJob and v.PlayerData.job.onduty then
            TriggerClientEvent("chat:addMessage", v.PlayerData.source, {
                template = '<div style="padding: 0.25vw; margin: 0.1vw; border-radius: 2px; background-color: rgba(254, 1, 3, 0.650); border: 2px solid rgb(254, 1, 3);"><i class="fas fa-user-nurse"style="font-size:15px"></i> <b>DISPATCH</b> | {0} </font></i></b></div>',
                multiline = true,
                args = {'Anon : ' .. msg}
            })
        end
    end
end)

RegisterNetEvent('refine-mechat:server:typing', function(bool)
    local src = source
    local ped = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(ped)
    local Players = GetPlayers()
    for i = 1, #Players do
        local Player = Players[i]
        local target = GetPlayerPed(Player)
        local tCoords = GetEntityCoords(target)
        if target == ped or #(playerCoords - tCoords) < 8.0 then
            TriggerClientEvent("refine-mechat:client:typing", Player, src, bool)
        end
    end
end)
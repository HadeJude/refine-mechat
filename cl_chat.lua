local chatInputActive = false
local chatInputActivating = false
local chatHidden = true
local chatLoaded = false

local msgSent = 0
local loops = 0

local timeControl = 0
local loopControl = false
local meControl = 1

function DrawText3Dme(x,y,z, text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  if onScreen then
      SetTextScale(0.40, 0.40)
      SetTextFont(4)
      SetTextProportional(1)
      SetTextColour(255, 255, 255, 215)
      SetTextEntry("STRING")
      SetTextCentre(true)
      AddTextComponentString(text)
      SetTextColour(255, 255, 255, 255)

      DrawText(_x,_y)
      local factor = (string.len(text)) / 250
      DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 11, 1, 11, 75)

  end
end


RegisterNetEvent('__cfx_internal:serverPrint', function(msg)

  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = {
      templateId = 'print',
      multiline = true,
      args = { msg }
    }
  })
end)

RegisterNetEvent('chatMessage', function(author, ctype, text)
  local args = { text }
  if author ~= "" then
    table.insert(args, 1, author)
  end
  local ctype = ctype ~= false and ctype or "normal"
  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = {
      template = '<div class="chat-message '..ctype..'"><div class="chat-message-body"><strong>{0}:</strong> {1}</div></div>',
      args = {author, text}
    }
  })
end)

RegisterNetEvent('chat:addMessage', function(message)
  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = message
  })
end)

RegisterNetEvent('chat:addSuggestion', function(name, help, params)
  SendNUIMessage({
    type = 'ON_SUGGESTION_ADD',
    suggestion = {
      name = name,
      help = help,
      params = params or nil
    }
  })
end)

RegisterNetEvent('chat:addSuggestions', function(suggestions)
  for _, suggestion in ipairs(suggestions) do
    SendNUIMessage({
      type = 'ON_SUGGESTION_ADD',
      suggestion = suggestion
    })
  end
end)

RegisterNetEvent('chat:removeSuggestion', function(name)
  SendNUIMessage({
    type = 'ON_SUGGESTION_REMOVE',
    name = name
  })
end)

RegisterNetEvent('chat:clear', function(name)
  SendNUIMessage({
    type = 'ON_CLEAR'
  })
end)

RegisterNUICallback('chatResult', function(data, cb)
  chatInputActive = false
  SetNuiFocus(false)

  if not data.canceled then
    if data.message:sub(1, 1) == '/' then
      ExecuteCommand(data.message:sub(2))
    else
      ExecuteCommand(data.message)
    end
  end

  cb('ok')
end)

local function refreshCommands()
  if GetRegisteredCommands then
    local registeredCommands = GetRegisteredCommands()

    local suggestions = {}

    for _, command in ipairs(registeredCommands) do
        if IsAceAllowed(('command.%s'):format(command.name)) then
            table.insert(suggestions, {
                name = '/' .. command.name,
                help = ''
            })
        end
    end

    TriggerEvent('chat:addSuggestions', suggestions)
  end
end

local function refreshThemes()
  local themes = {}

  for resIdx = 0, GetNumResources() - 1 do
    local resource = GetResourceByFindIndex(resIdx)

    if GetResourceState(resource) == 'started' then
      local numThemes = GetNumResourceMetadata(resource, 'chat_theme')

      if numThemes > 0 then
        local themeName = GetResourceMetadata(resource, 'chat_theme')
        local themeData = json.decode(GetResourceMetadata(resource, 'chat_theme_extra') or 'null')

        if themeName and themeData then
          themeData.baseUrl = 'nui://' .. resource .. '/'
          themes[themeName] = themeData
        end
      end
    end
  end

  SendNUIMessage({
    type = 'ON_UPDATE_THEMES',
    themes = themes
  })
end

RegisterNetEvent('onClientResourceStart', function(resName)
  Wait(500)

  refreshCommands()
  refreshThemes()
end)

RegisterNetEvent('onClientResourceStop', function(resName)
  Wait(500)

  refreshCommands()
  refreshThemes()
end)

RegisterNUICallback('loaded', function(data, cb)
  TriggerServerEvent('chat:init');

  refreshCommands()
  refreshThemes()

  chatLoaded = true

  cb('ok')
end)

CreateThread(function()
  SetTextChatEnabled(false)
  SetNuiFocus(false, false)

  while true do
    Wait(3)

    if not chatInputActive then
      if IsControlPressed(0, 245) then
        chatInputActive = true
        chatInputActivating = true

        SendNUIMessage({
          type = 'ON_OPEN'
        })
      end
    end

    if chatInputActivating then
      if not IsControlPressed(0, 245) then
        SetNuiFocus(true)

        chatInputActivating = false
      end
    end

    if chatLoaded then
      local shouldBeHidden = false

      if IsScreenFadedOut() or IsPauseMenuActive() then
        shouldBeHidden = true
      end

      if (shouldBeHidden and not chatHidden) or (not shouldBeHidden and chatHidden) then
        chatHidden = shouldBeHidden

        SendNUIMessage({
          type = 'ON_SCREEN_STATE_CHANGE',
          shouldHide = shouldBeHidden
        })
      end
    end
  end
end)

--Me function
RegisterNetEvent('meCoords', function(text,obj)
  if meControl > 2 then return end
  timeControl = 600
  msgSent = msgSent + 0.22
  local msgSentCount = msgSent

  loops = 600 - (msgSent * 100)
  TriggerEvent("loopControl")

  while timeControl > 0 do

      timeControl = timeControl - 1

      local plyCoords2 = GetEntityCoords(obj)
      local isInVehicle = IsPedInAnyVehicle(PlayerPedId(), false)
      output = timeControl

      if output > 255 then
          output = 255
      end

      if not isInVehicle and GetFollowPedCamViewMode() == 0 then
          DrawText3Dme(plyCoords2["x"],plyCoords2["y"],plyCoords2["z"]+(msgSentCount/2) - 0.2, text, output)
      elseif not isInVehicle and GetFollowPedCamViewMode() == 4 then
          DrawText3Dme(plyCoords2["x"],plyCoords2["y"],plyCoords2["z"]+(msgSentCount/7) - 0.1, text, output)
      elseif GetFollowPedCamViewMode() == 4 then
          DrawText3Dme(plyCoords2["x"],plyCoords2["y"],plyCoords2["z"]+(msgSentCount/7) - 0.2, text, output)
      else
          DrawText3Dme(plyCoords2["x"],plyCoords2["y"],plyCoords2["z"]+msgSentCount, text, output)
      end

      Wait(1)
  end

end)

RegisterNetEvent('loopControl', function()
  if loopControl then return end
  loopControl = true
  while loops > 0 do
      if msgSent > 2.6 then
         loops = 0
      end
      Wait(1)
      loops = loops - 1
  end
  timeControl = 0
  loopControl = false
  loops = 0
  msgSent = 0
end)



RegisterNetEvent("me:client:command", function(user, msg)
  local Player = PlayerId()
  local serverId = GetPlayerFromServerId(user)
  if serverId ~= -1 then
      if HasEntityClearLosToEntity(GetPlayerPed(Player), GetPlayerPed(serverId), 17) then
          TriggerEvent("meCoords", msg, GetPlayerPed(serverId))
      end
  end
end)


RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    TriggerEvent('chat:addSuggestion', '/me', 'Show local message', {{ name="message"}})
    TriggerEvent('chat:addSuggestion', '/mea', 'Show local message anonymous.', {{ name="message"}})
    TriggerEvent('chat:addSuggestion', '/mename', 'Change your Anonymous Name', {{ name="NAME"}})
end)

RegisterCommand('clear', function(source, args)
  TriggerEvent('chat:clear')
end, false)
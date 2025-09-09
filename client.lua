local lib = exports.ox_lib
local lastWeatherHash = nil
local alertsEnabled = true
local chatEnabled = true
local screenEnabled = true

-- Weather hash to string lookup table
local weatherHashToString = {
    [GetHashKey("CLEAR")] = "CLEAR",
    [GetHashKey("EXTRASUNNY")] = "EXTRASUNNY", 
    [GetHashKey("CLOUDS")] = "CLOUDS",
    [GetHashKey("SMOG")] = "SMOG",
    [GetHashKey("FOGGY")] = "FOGGY",
    [GetHashKey("OVERCAST")] = "OVERCAST",
    [GetHashKey("RAIN")] = "RAIN",
    [GetHashKey("DRIZZLE")] = "DRIZZLE",
    [GetHashKey("THUNDER")] = "THUNDER",
    [GetHashKey("CLEARING")] = "CLEARING",
    [GetHashKey("NEUTRAL")] = "NEUTRAL",
    [GetHashKey("SNOW")] = "SNOW",
    [GetHashKey("BLIZZARD")] = "BLIZZARD",
    [GetHashKey("SNOWLIGHT")] = "SNOWLIGHT",
    [GetHashKey("XMAS")] = "XMAS",
    [GetHashKey("HALLOWEEN")] = "HALLOWEEN"
}

function GetWeatherStringFromHash(weatherHash)
    return weatherHashToString[weatherHash] or "CLEAR"
end

RegisterNetEvent('weatheralerts:showNotification')
AddEventHandler('weatheralerts:showNotification', function(message)
    lib:notify({
        title = 'Weather Alert',
        description = message,
        type = 'inform'
    })
end)

RegisterNetEvent('weatheralerts:requestWeatherUpdate')
AddEventHandler('weatheralerts:requestWeatherUpdate', function()
    local currentWeatherHash = GetPrevWeatherTypeHashName()
    local currentWeatherString = GetWeatherStringFromHash(currentWeatherHash)
    TriggerServerEvent('weatheralerts:updateWeather', currentWeatherString)
end)

AddEventHandler('playerSpawned', function()
    TriggerServerEvent('weatheralerts:playerJoined')
end)

-- Monitor weather changes and report to server
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000) -- Check every 5 seconds
        local currentWeatherHash = GetPrevWeatherTypeHashName()
        if currentWeatherHash ~= lastWeatherHash then
            lastWeatherHash = currentWeatherHash
            local currentWeatherString = GetWeatherStringFromHash(currentWeatherHash)
            TriggerServerEvent('weatheralerts:weatherChanged', currentWeatherString)
        end
    end
end)

-- Function to open weather menu using OX_LIB
local function openWeatherMenu()
    lib:registerContext({
        id = 'weather_alerts_menu',
        title = 'Weather Alerts',
        options = {
            {
                title = 'Enable Weather Alerts',
                description = 'Toggle weather alert notifications on/off',
                icon = alertsEnabled and 'check-square' or 'square',
                onSelect = function()
                    alertsEnabled = not alertsEnabled
                    TriggerServerEvent('weatheralerts:toggleAlerts', alertsEnabled)
                    lib:notify({
                        title = 'Weather Alerts',
                        description = alertsEnabled and 'Weather alerts enabled' or 'Weather alerts disabled',
                        type = 'success'
                    })
                    openWeatherMenu() -- Refresh menu
                end
            },
            {
                title = 'Show in Chat',
                description = 'Display weather alerts in chat',
                icon = chatEnabled and 'check-square' or 'square',
                onSelect = function()
                    chatEnabled = not chatEnabled
                    TriggerServerEvent('weatheralerts:toggleChatAlerts', chatEnabled)
                    lib:notify({
                        title = 'Weather Alerts',
                        description = chatEnabled and 'Chat alerts enabled' or 'Chat alerts disabled',
                        type = 'success'
                    })
                    openWeatherMenu() -- Refresh menu
                end
            },
            {
                title = 'Show on Screen',
                description = 'Display weather alerts as notifications',
                icon = screenEnabled and 'check-square' or 'square',
                onSelect = function()
                    screenEnabled = not screenEnabled
                    TriggerServerEvent('weatheralerts:toggleScreenAlerts', screenEnabled)
                    lib:notify({
                        title = 'Weather Alerts',
                        description = screenEnabled and 'Screen alerts enabled' or 'Screen alerts disabled',
                        type = 'success'
                    })
                    openWeatherMenu() -- Refresh menu
                end
            },
            {
                title = 'Current Weather',
                description = 'View current weather information',
                icon = 'cloud-sun',
                onSelect = function()
                    local currentWeatherHash = GetPrevWeatherTypeHashName()
                    local currentWeatherString = GetWeatherStringFromHash(currentWeatherHash)
                    lib:notify({
                        title = 'Weather Service',
                        description = 'Current weather: ' .. currentWeatherString,
                        type = 'inform'
                    })
                    TriggerEvent('chat:addMessage', {
                        color = {255, 165, 0},
                        multiline = true,
                        args = {"Weather Service", "Current weather: " .. currentWeatherString}
                    })
                end
            }
        }
    })
    
    lib:showContext('weather_alerts_menu')
end

-- Command to open weather menu
RegisterCommand('weathermenu', function()
    openWeatherMenu()
end, false)

-- Key mapping for menu
RegisterKeyMapping('weathermenu', 'Open Weather Alerts Menu', 'keyboard', 'F7')

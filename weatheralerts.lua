Config = {}
Config.AlertInterval = 300000
Config.ShowInChat = true
Config.ShowOnScreen = true

Config.WeatherMessages = {
    ['CLEAR'] = {
        "The sun is shining brightly across the city with clear skies!",
        "Beautiful clear weather blankets the area today.",
        "Crystal clear skies provide perfect visibility throughout the region.",
        "Sunshine dominates the forecast with not a cloud in sight.",
        "Clear atmospheric conditions make for an ideal day outside."
    },
    ['EXTRASUNNY'] = {
        "Intense sunshine beats down with scorching heat!",
        "The sun is blazing hot today - stay hydrated!",
        "Extreme heat warning: temperatures are soaring under the blazing sun.",
        "Sweltering conditions persist with relentless sunshine.",
        "The heat is overwhelming as the sun burns bright overhead."
    },
    ['CLOUDS'] = {
        "Overcast skies dominate the weather today.",
        "A blanket of clouds covers the entire area.",
        "Cloudy conditions persist with limited sunshine breaking through.",
        "Gray clouds fill the sky creating a moody atmosphere.",
        "Dense cloud cover blocks most of the sunlight today."
    },
    ['SMOG'] = {
        "Heavy smog reduces visibility across the city.",
        "Air quality is poor due to thick smog conditions.",
        "A hazy layer of smog hangs over the metropolitan area.",
        "Pollution creates dangerous smog levels - limit outdoor activities.",
        "Thick smog makes breathing difficult and visibility low."
    },
    ['FOGGY'] = {
        "Dense fog severely limits visibility on all roads.",
        "Thick fog blankets the area - drive with extreme caution!",
        "Heavy fog creates hazardous travel conditions.",
        "Visibility is near zero due to persistent fog.",
        "Fog advisory in effect - use headlights and reduce speed."
    },
    ['OVERCAST'] = {
        "Completely overcast skies create a gloomy atmosphere.",
        "Heavy cloud cover blocks all sunlight today.",
        "Dark, overcast conditions dominate the weather pattern.",
        "The sky is completely gray with thick overcast clouds.",
        "No sunshine expected under these heavy overcast conditions."
    },
    ['RAIN'] = {
        "Steady rainfall is soaking the streets and sidewalks.",
        "Rain continues to fall across the entire region.",
        "Wet conditions persist as rain showers move through the area.",
        "Rainfall creates slippery road conditions - drive carefully!",
        "Light to moderate rain is expected to continue throughout the day."
    },
    ['DRIZZLE'] = {
        "Light drizzle creates misty conditions throughout the area.",
        "A gentle drizzle falls, creating damp conditions everywhere.",
        "Fine mist and drizzle reduce visibility slightly.",
        "Persistent drizzle makes surfaces wet and slippery.",
        "Light precipitation in the form of drizzle affects the region."
    },
    ['THUNDER'] = {
        "Thunderstorms with lightning strikes pose serious danger!",
        "Severe thunderstorm warning - seek shelter immediately!",
        "Lightning and thunder create dangerous weather conditions.",
        "Electrical storms with heavy rain and lightning are active.",
        "Take cover! Dangerous thunderstorms with frequent lightning strikes."
    },
    ['CLEARING'] = {
        "Weather conditions are improving as skies begin to clear.",
        "The storm is passing and clearer skies are emerging.",
        "Conditions are clearing up after the recent weather system.",
        "Skies are gradually clearing as the weather improves.",
        "The weather is transitioning to clearer, more pleasant conditions."
    },
    ['NEUTRAL'] = {
        "Mild weather conditions persist across the area.",
        "Moderate temperatures with partly cloudy skies.",
        "Pleasant weather conditions continue throughout the region.",
        "Comfortable atmospheric conditions with light winds.",
        "Stable weather patterns provide moderate conditions today."
    },
    ['SNOW'] = {
        "Heavy snowfall is blanketing the entire area!",
        "Snow continues to accumulate on roads and sidewalks.",
        "Winter storm conditions with significant snowfall.",
        "Dangerous driving conditions due to heavy snow accumulation.",
        "Blizzard-like conditions with intense snowfall and low visibility."
    },
    ['BLIZZARD'] = {
        "Extreme blizzard conditions with whiteout visibility!",
        "Dangerous blizzard warning - avoid all travel!",
        "Severe winter storm with hurricane-force winds and snow.",
        "Life-threatening blizzard conditions - stay indoors!",
        "Emergency blizzard alert - zero visibility and extreme cold."
    },
    ['SNOWLIGHT'] = {
        "Light snow flurries dust the ground with a thin layer.",
        "Gentle snowfall creates a winter wonderland scene.",
        "Light snow showers add a beautiful coating to the landscape.",
        "Soft snowflakes fall peacefully across the region.",
        "Light winter precipitation creates picturesque snowy conditions."
    },
    ['XMAS'] = {
        "Magical Christmas snow creates a festive winter atmosphere!",
        "Holiday snowfall brings Christmas cheer to the area.",
        "Festive winter conditions perfect for the holiday season.",
        "Christmas magic fills the air with gentle snowfall.",
        "Holiday weather brings joy with beautiful Christmas snow."
    },
    ['HALLOWEEN'] = {
        "Spooky Halloween fog creates an eerie atmosphere!",
        "Mysterious Halloween weather with haunting fog.",
        "Creepy conditions perfect for Halloween night.",
        "Ghostly fog and eerie weather set the Halloween mood.",
        "Supernatural weather conditions enhance the Halloween spirit."
    }
}

Config.WeatherTemperatures = {
    ['CLEAR'] = {min = 75, max = 85},
    ['EXTRASUNNY'] = {min = 90, max = 110},
    ['CLOUDS'] = {min = 65, max = 75},
    ['SMOG'] = {min = 80, max = 95},
    ['FOGGY'] = {min = 50, max = 65},
    ['OVERCAST'] = {min = 60, max = 70},
    ['RAIN'] = {min = 55, max = 70},
    ['DRIZZLE'] = {min = 60, max = 72},
    ['THUNDER'] = {min = 70, max = 85},
    ['CLEARING'] = {min = 68, max = 78},
    ['NEUTRAL'] = {min = 70, max = 80},
    ['SNOW'] = {min = 15, max = 32},
    ['BLIZZARD'] = {min = -10, max = 20},
    ['SNOWLIGHT'] = {min = 25, max = 35},
    ['XMAS'] = {min = 20, max = 35},
    ['HALLOWEEN'] = {min = 45, max = 60}
}

local playerPreferences = {}
local lastWeatherHash = nil
local lastMessageIndex = {}

function GetCurrentWeatherType()
    local weatherHash = GetPrevWeatherTypeHashName()
    return weatherHash
end

function GetTemperatureForWeather(weatherType)
    local tempData = Config.WeatherTemperatures[weatherType]
    if tempData then
        return math.random(tempData.min, tempData.max)
    end
    return math.random(65, 80)
end

function GetRandomWeatherMessage(weatherType)
    local messages = Config.WeatherMessages[weatherType]
    if not messages then
        messages = Config.WeatherMessages['NEUTRAL']
    end
    
    if not lastMessageIndex[weatherType] then
        lastMessageIndex[weatherType] = 0
    end
    
    local availableIndices = {}
    for i = 1, #messages do
        if i ~= lastMessageIndex[weatherType] then
            table.insert(availableIndices, i)
        end
    end
    
    if #availableIndices == 0 then
        availableIndices = {1, 2, 3, 4, 5}
    end
    
    local randomIndex = availableIndices[math.random(#availableIndices)]
    lastMessageIndex[weatherType] = randomIndex
    
    return messages[randomIndex]
end

function SendWeatherAlert()
    local currentWeather = GetCurrentWeatherType()
    local temperature = GetTemperatureForWeather(currentWeather)
    local message = GetRandomWeatherMessage(currentWeather)
    local fullMessage = string.format("🌤️ WEATHER ALERT: %s Current temperature: %d°F", message, temperature)
    
    local players = GetPlayers()
    for _, playerId in ipairs(players) do
        local playerSource = tonumber(playerId)
        if playerPreferences[playerSource] ~= false then
            if Config.ShowInChat then
                TriggerClientEvent('chat:addMessage', playerSource, {
                    color = {255, 165, 0},
                    multiline = true,
                    args = {"Weather Service", fullMessage}
                })
            end
            
            if Config.ShowOnScreen then
                TriggerClientEvent('weatheralerts:showNotification', playerSource, fullMessage)
            end
        end
    end
end

function CheckWeatherAndAlert()
    local currentWeather = GetCurrentWeatherType()
    if currentWeather ~= lastWeatherHash then
        lastWeatherHash = currentWeather
        SendWeatherAlert()
    end
end

RegisterCommand('toggleweatheralerts', function(source, args, rawCommand)
    if playerPreferences[source] == false then
        playerPreferences[source] = true
        TriggerClientEvent('chat:addMessage', source, {
            color = {0, 255, 0},
            multiline = true,
            args = {"Weather Service", "Weather alerts have been enabled for you."}
        })
    else
        playerPreferences[source] = false
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {"Weather Service", "Weather alerts have been disabled for you."}
        })
    end
end, false)

RegisterNetEvent('weatheralerts:playerJoined')
AddEventHandler('weatheralerts:playerJoined', function()
    local source = source
    if playerPreferences[source] == nil then
        playerPreferences[source] = true
    end
end)

AddEventHandler('playerDropped', function(reason)
    local source = source
    playerPreferences[source] = nil
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.AlertInterval)
        SendWeatherAlert()
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(30000)
        CheckWeatherAndAlert()
    end
end)

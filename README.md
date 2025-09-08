# WeatherAlerts - FiveM Lua Script

An immersive weather and temperature alert system for FiveM servers that automatically broadcasts realistic weather conditions and temperatures to players at configurable intervals.

## Features

- **Automatic Weather Detection**: Monitors in-game weather changes and sends alerts
- **Configurable Alert System**: Set custom time intervals for weather broadcasts
- **Realistic Temperature System**: Dynamic temperatures based on current weather conditions
- **Randomized Messages**: 5 unique alert messages per weather type to prevent repetition
- **Dual Notification System**: Chat messages and on-screen notifications
- **Player Preferences**: Individual players can toggle alerts on/off
- **16 Weather Types Supported**: Complete coverage of all GTA V weather conditions

## Installation

1. Download or clone this repository
2. Place the `weatheralerts` folder in your FiveM server's `resources` directory
3. Add `ensure weatheralerts` to your `server.cfg` file
4. Restart your server or use `refresh` and `ensure weatheralerts` commands

## Configuration

Edit the `Config` table in `weatheralerts.lua` to customize the script:

```lua
Config.AlertInterval = 300000  -- Alert interval in milliseconds (5 minutes default)
Config.ShowInChat = true       -- Enable/disable chat notifications
Config.ShowOnScreen = true     -- Enable/disable screen notifications
```

### Weather Types & Temperature Ranges

The script supports all GTA V weather types with realistic temperature ranges:

| Weather Type | Temperature Range (°F) | Description |
|--------------|------------------------|-------------|
| CLEAR | 75-85°F | Sunny, clear skies |
| EXTRASUNNY | 90-110°F | Extremely hot, blazing sun |
| CLOUDS | 65-75°F | Overcast, cloudy conditions |
| SMOG | 80-95°F | Poor air quality, hazy |
| FOGGY | 50-65°F | Dense fog, low visibility |
| OVERCAST | 60-70°F | Heavy cloud cover |
| RAIN | 55-70°F | Steady rainfall |
| DRIZZLE | 60-72°F | Light rain, misty |
| THUNDER | 70-85°F | Thunderstorms with lightning |
| CLEARING | 68-78°F | Weather improving |
| NEUTRAL | 70-80°F | Mild, pleasant conditions |
| SNOW | 15-32°F | Heavy snowfall |
| BLIZZARD | -10-20°F | Extreme winter conditions |
| SNOWLIGHT | 25-35°F | Light snow flurries |
| XMAS | 20-35°F | Festive Christmas snow |
| HALLOWEEN | 45-60°F | Spooky Halloween atmosphere |

## Commands

### `/toggleweatheralerts`
Allows individual players to enable or disable weather alerts for themselves without affecting other players.

- **Usage**: Type `/toggleweatheralerts` in chat
- **Permission**: Available to all players
- **Effect**: Toggles weather alerts on/off for the executing player only

## How It Works

### Alert System
- **Timed Alerts**: Broadcasts weather information every X seconds (configurable)
- **Weather Change Alerts**: Automatically detects weather changes and sends immediate alerts
- **Smart Message Rotation**: Prevents message repetition by cycling through different alerts

### Player Preferences
- **Individual Control**: Each player can toggle alerts independently
- **Session Persistence**: Preferences are maintained throughout the player's session
- **Automatic Cleanup**: Player preferences are cleared when they disconnect

### Notification Types
1. **Chat Messages**: Colored chat notifications with weather service branding
2. **Screen Notifications**: Native GTA V notification system for on-screen alerts

## File Structure

```
weatheralerts/
├── fxmanifest.lua      # FiveM resource manifest
├── weatheralerts.lua   # Main server-side script
├── client.lua          # Client-side notification handler
└── README.md          # This documentation
```

## Customization

### Adding New Weather Messages
Edit the `Config.WeatherMessages` table to add or modify alert messages:

```lua
Config.WeatherMessages = {
    ['CLEAR'] = {
        "Your custom clear weather message here",
        "Another clear weather message",
        -- Add up to 5 messages per weather type
    }
}
```

### Adjusting Temperature Ranges
Modify the `Config.WeatherTemperatures` table to change temperature ranges:

```lua
Config.WeatherTemperatures = {
    ['CLEAR'] = {min = 75, max = 85},
    -- Adjust min/max values as desired
}
```

### Changing Alert Intervals
Modify `Config.AlertInterval` (in milliseconds):
- 60000 = 1 minute
- 300000 = 5 minutes (default)
- 600000 = 10 minutes

## Technical Details

- **Server Performance**: Lightweight with minimal resource usage
- **Client Performance**: Efficient client-side notification system
- **Memory Management**: Automatic cleanup of disconnected players
- **Weather Detection**: Uses native GTA V weather functions
- **Random Generation**: Smart randomization prevents message repetition

## Compatibility

- **FiveM Version**: Compatible with latest FiveM builds
- **Game Version**: GTA V (all versions)
- **Dependencies**: None (standalone resource)
- **Conflicts**: No known conflicts with other weather-related scripts

## Support

For issues, suggestions, or contributions, please refer to the script documentation or contact the server administrators.

## License

This script is provided as-is for FiveM server use. Modify and distribute as needed for your server requirements.

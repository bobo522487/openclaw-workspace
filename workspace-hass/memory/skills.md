# Skills Installation History

## 2026-02-10 - Home Assistant Skills

### Installation: homeassistant-skill (ClawHub CLI)
- **Skill**: homeassistant-skill (anotb)
- **Source**: https://clawhub.ai/skills?q=homeassistant
- **Installation Method**: ClawHub CLI (node binary provided: /home/bobo/.nvm/versions/node/v24.13.0/bin/node)
- **Location**: /home/bobo/.openclaw/workspace-hass/skills/homeassistant-skill/
- **Version**: 2.0.3
- **Status**: ✅ Installed (Primary skill - more comprehensive)
- **Features** (25 entity domains supported):
  - **Switches**: Turn on/off, toggle
  - **Lights**: Brightness, RGB color, color temperature
  - **Scenes**: Trigger scenes
  - **Scripts**: Run scripts with/without variables
  - **Automations**: Trigger, enable, disable
  - **Climate**: Set temperature, HVAC mode
  - **Covers**: Open/close blinds, garage doors (requires user confirmation)
  - **Locks**: Lock/unlock (requires user confirmation)
  - **Fans**: Speed control, on/off
  - **Media Players**: Play/pause, volume
  - **Vacuum**: Start, return to dock
  - **Alarm Control Panel**: Arm/disarm (requires user confirmation)
  - **Notifications**: Send alerts
  - **Person & Presence**: Track who is home
  - **Weather**: Current conditions, forecasts
  - **Input Helpers**: booleans, numbers, selects, text, datetime
  - **Calendar**: List calendars, get events
  - **Text-to-Speech**: Send TTS to speakers
  - **Sensors & Binary Sensors**: Temperature, motion, doors/windows
  - **History & Logbook**: State history, events
  - **Area & Floor Discovery**: Query areas, entities by area
  - **Template Evaluation**: Jinja2 templates server-side
  - **Dashboard Overview**: Quick status of all devices

### Node Configuration
- **Node binary location**: /home/bobo/.nvm/versions/node/v24.13.0/bin/node
- **Version**: v24.13.0
- **Usage**: Required for ClawHub CLI commands

### Configuration
- Requires: `curl` (binary), `jq` (binary), `HA_TOKEN` (environment variable)
- Already configured with:
  - `HA_URL`: http://10.10.10.8:8123
  - `HA_TOKEN`: See TOOLS.md

### Safety Rules (from homeassistant-skill)
The skill has built-in safety rules that require user confirmation before:
- **Locks** — locking or unlocking any lock
- **Alarm panels** — arming or disarming
- **Garage doors** — opening or closing (`cover.*` with `device_class: garage`)
- **Security automations** — disabling automations related to security or safety
- **Covers** — opening or closing covers that control physical access (gates, barriers)

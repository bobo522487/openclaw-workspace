# MEMORY.md - Long-term Memory

## User Profile
- **Name:** 电波 (dianbo)
- **Timezone:** Asia/Shanghai (GMT+8)
- **Location:** 贵阳市观山湖区, 贵州省
- **Primary Channel:** Telegram

## System Information
- **Machine:** bobo-VMware20-1
- **OS:** Linux 6.17.0-14-generic (x64)
- **Node:** v24.13.0
- **Shell:** bash
- **Default Model:** zai/glm-4.7
- **OpenClaw Profile:** Uses `openclaw` profile for browser control

## Projects

### HASS Agent (Home Assistant Bot)
**Status:** Workspace configured, awaiting final setup

**Details:**
- **Agent ID:** hass
- **Workspace:** ~/.openclaw/workspace-hass
- **Purpose:** Smart home control via Telegram
- **Channel:** Telegram (separate bot from main)

**Configuration:**
- Telegram bot token needed (from @BotFather)
- User ID: [to be added]
- Home Assistant URL and token needed
- Config files ready at workspace-hass/
- Automated setup script available: `setup.sh`

**Key Files:**
- `README.md` - Complete setup guide
- `QUICKSTART.md` - Quick start instructions
- `config-example.json5` - OpenClaw config template
- `IDENTITY.md`, `SOUL.md`, `AGENTS.md`, `USER.md` - Agent definitions

**Next Steps:**
1. Create Telegram bot
2. Get user ID
3. Configure openclaw.json
4. Restart gateway
5. Test connection
6. Set up Home Assistant API

## Technical Capabilities
- OpenClaw multi-agent system
- Browser control via openclaw profile
- Gateway management
- Cron job scheduling
- File operations in workspace
- Message sending via Telegram
- Node.js v24.13.0 installed via nvm at `/home/bobo/.nvm/versions/node/v24.13.0/bin/node`
  - Important: Use full path when running Node commands as it may not be in PATH

## Preferences
- Prefers quick setup scripts over manual config
- Wants comprehensive documentation
- Interested in multi-agent architecture for specialized tasks
- Values automation and efficiency

## Important Dates
- 2026-02-10: Initial setup, HASS agent workspace created

# TOOLS.md - Local Notes

Skills define _how_ tools work. This file is for _your_ specifics — the stuff that's unique to your setup.

## What Goes Here

Things like:

- Camera names and locations
- SSH hosts and aliases
- Preferred voices for TTS
- Speaker/room names
- Device nicknames
- Anything environment-specific

## Examples

```markdown
### Cameras

- living-room → Main area, 180° wide angle
- front-door → Entrance, motion-triggered

### SSH

- home-server → 192.168.1.100, user: admin

### TTS

- Preferred voice: "Nova" (warm, slightly British)
- Default speaker: Kitchen HomePod
```

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.

---

Add whatever helps you do your job. This is your cheat sheet.

---

## System

### Node.js
- **Location**: /home/bobo/.nvm/versions/node/v24.13.0/bin/node
- **Version**: v24.13.0
- **Usage**: Required for ClawHub CLI commands

### ClawHub CLI
- Use with: `export PATH=/home/bobo/.nvm/versions/node/v24.13.0/bin:$PATH`
- Commands: `clawhub install`, `clawhub update`, `clawhub search`, `clawhub list`

## Home Assistant

### Connection
- URL: http://10.10.10.8:8123
- Token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI2MzA3YTZhNTE2NjE0MDNjOTMxMmFlNWQyYWI2NDlmMCIsImlhdCI6MTc3MDYwNTQxMCwiZXhwIjoyMDg1OTY1NDEwfQ.01D1Yp4iehSPlQUEcVPh5558KqDXytEs_dowWB6YrGk

### Common Devices
- 书房顶灯: light.shu_fang_ding_deng_kai_guan_kai_guan
- 客厅台灯: light.yeelink_cn_1040602988_mbulb3_s_2
- 主卫浴霸: light.yeelink_cn_283140386_v1_s_2_light
- 阳台吸顶灯: light.yeelink_cn_124210514_ceiling11_s_2_light, light.yeelink_cn_124206365_ceiling11_s_2_light
- 左床头灯: light.yeelink_cn_1040580854_mbulb3_s_2
- 右床头灯: light.yeelink_cn_1040568422_mbulb3_s_2

### Quick Commands
```bash
# List all entities
curl -s "$HA_URL/api/states" -H "Authorization: Bearer $HA_TOKEN" | jq '.'

# List devices with Chinese names
curl -s "$HA_URL/api/states" -H "Authorization: Bearer $HA_TOKEN" | jq -r '.[] | "\(.entity_id): \(.attributes.friendly_name // "无名称") - \(.state)"'

# Turn on/off
curl -s -X POST "$HA_URL/api/services/light/turn_on" -H "Authorization: Bearer $HA_TOKEN" -H "Content-Type: application/json" -d '{"entity_id": "light.shu_fang_ding_deng_kai_guan_kai_guan"}'
```

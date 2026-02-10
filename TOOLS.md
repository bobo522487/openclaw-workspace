# TOOLS.md - Local Notes

Skills define _how_ tools work. This file is for _your_ specifics_ — stuff that's unique to your setup.

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

### TTS (Text-to-Speech)

**推荐方案：Hume AI TTS (ntts)**
- **Skill 名称：** ntts
- **Provider：** Hume AI
- **安装命令：** `npx playbooks add skill openclaw/skills --skill ntts`
- **获取 API Key：** 访问 https://humemid.ai 注册（免费额度）
- **配置位置：** `~/.openclaw/workspace/skills/ntts/CONFIG.yml`

**配置示例：**
```yaml
# ~/.openclaw/workspace/skills/ntts/CONFIG.yml
provider: hume
apiKey: ${HUME_API_KEY}  # 从环境变量读取
voice: user-2  # 榴据可用声音选择
outputFormat: ogg  # OGG 格式（Telegram 推荐）
language: zh-CN  # 中文
```

**使用方法：**
露娜在对话中调用 TTS 工具：
```javascript
const ttsResult = await tts.synthesize("主人，早上好！");
await message.sendVoice(ttsResult.audio);
```

**备选方案：pors/openai-tts (Azure)**
- 更稳定，但需要付费 API Key
- 官方支持

**备选方案：tts (ElevenLabs)**
- 语音质量极高
- 专为 AI 对话设计

---

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.

---

Add whatever helps you do your job. This is your cheat sheet.

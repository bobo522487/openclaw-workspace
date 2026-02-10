# 🚀 HASS智能体快速开始

## 一分钟配置

### 自动设置（推荐）

```bash
cd ~/.openclaw/workspace-hass
./setup.sh
```

按照提示输入：
1. Telegram Bot token（从@BotFather获取）
2. 你的Telegram User ID（从@userinfobot获取）
3. Home Assistant URL和Token（可选）

### 手动设置

#### 1. 创建Telegram Bot
- Telegram搜索 @BotFather
- 发送 `/newbot`
- 按照提示设置，复制token

#### 2. 获取User ID
- Telegram搜索 @userinfobot
- 发送 `/start`
- 复制返回的数字ID

#### 3. 修改 ~/.openclaw/openclaw.json

```bash
# 备份配置
cp ~/.openclaw/openclaw.json ~/.openclaw/openclaw.json.backup

# 编辑配置
nano ~/.openclaw/openclaw.json
```

添加以下内容（根据config-example.json5）：

```json5
agents: {
  list: [
    // ... 现有agents ...
    {
      id: "hass",
      name: "HASS Bot",
      workspace: "~/.openclaw/workspace-hass",
    },
  ],
},

bindings: [
  // ... 现有bindings ...
  {
    agentId: "hass",
    match: { channel: "telegram", accountId: "hass-bot" },
  },
],

channels: {
  telegram: {
    dmPolicy: "allowlist",
    allowFrom: ["YOUR_USER_ID"],
    accounts: {
      "hass-bot": {
        botToken: "YOUR_BOT_TOKEN",
      },
    },
  },
}
```

#### 4. 重启Gateway

```bash
openclaw gateway restart
```

#### 5. 测试

在Telegram给你的HASS bot发送消息：
```
你好，你是谁？
```

应该收到类似回复：
```
我是HASS Bot，专注于Home Assistant智能家居控制！🏠
```

#### 6. 验证配置

```bash
# 查看所有agents
openclaw agents list

# 查看bindings
openclaw agents list --bindings

# 查看gateway状态
openclaw gateway status
```

## 🎯 常用Telegram命令

```
/状态          - 查询所有设备状态
/设备列表      - 列出所有可用设备
/自动化列表    - 列出所有自动化规则

开客厅灯       - 控制设备
关所有灯       - 批量控制

温度24度       - 设置温度
离家模式       - 执行场景
```

## 🔧 配置Home Assistant（可选）

### 获取API Token

1. Home Assistant Web UI → 左下角头像
2. 滚动到底部 → 长按 "Create Token"
3. 输入名称（如 "OpenClaw HASS Bot"）
4. 复制生成的token

### 配置到AGENTS.md

编辑 `~/.openclaw/workspace-hass/AGENTS.md`：

```markdown
### Home Assistant配置
- HASS URL: http://homeassistant.local:8123
- API Token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

## 📚 详细文档

- 完整设置指南: `README.md`
- OpenClaw多智能体: https://docs.openclaw.ai/concepts/multi-agent
- Home Assistant API: https://developers.home-assistant.io/docs/api/rest

## 🐛 故障排查

### Bot无响应
```bash
# 检查日志
journalctl -u openclaw -f

# 检查配置
openclaw gateway status
```

### 消息路由错误
```bash
# 检查bindings
openclaw agents list --bindings
```

### HASS连接失败
```bash
# 测试API
curl -H "Authorization: Bearer YOUR_TOKEN" \
     http://your-hass-url:8123/api/states
```

## 💡 提示

- 使用`@hass`在群聊中提及此bot
- 可以配置cron定时检查HASS状态
- 建议定期备份配置文件

# HASS智能体设置指南

## 📋 完整配置步骤

### 1. 创建Telegram Bot

```bash
# 在Telegram中与@BotFather对话
/newbot
# 按照提示创建bot，获得token
```

### 2. 配置OpenClaw

编辑 `~/.openclaw/openclaw.json`，添加以下内容：

```json5
{
  agents: {
    list: [
      // ... 其他agents ...
      {
        id: "hass",
        name: "HASS Bot",
        workspace: "~/.openclaw/workspace-hass",
        model: "zai/glm-4.7",
      },
    ],
  },

  bindings: [
    {
      agentId: "hass",
      match: { channel: "telegram", accountId: "hass-bot" },
    },
  ],

  channels: {
    telegram: {
      accounts: {
        "hass-bot": {
          botToken: "YOUR_BOT_TOKEN_HERE",
        },
      },
    },
  },
}
```

### 3. 连接Telegram Bot

```bash
# 获取你的Telegram user_id
# 1. 发送 /start 给 @userinfobot
# 2. 记录返回的数字ID

# 配置允许的用户（可选，安全起见建议设置）
# 在openclaw.json中添加:
channels: {
  telegram: {
    dmPolicy: "allowlist",
    allowFrom: ["YOUR_TELEGRAM_USER_ID"],
    accounts: {
      "hass-bot": {
        botToken: "YOUR_BOT_TOKEN_HERE",
      },
    },
  },
}
```

### 4. 重启OpenClaw Gateway

```bash
openclaw gateway restart
```

### 5. 测试连接

```bash
# 在Telegram中给你的HASS bot发送消息
# 应该能看到来自hass智能体的回复
```

## 🏠 配置Home Assistant连接

### 方式1: API Token

```bash
# 1. 打开Home Assistant Web UI
# 2. 左下角点击你的头像 -> 底部滚动条 -> 长按Token
# 3. 创建长期访问令牌（复制保存）
```

在 `~/.openclaw/workspace-hass/AGENTS.md` 中更新:

```markdown
### 连接信息
- HASS URL: http://homeassistant.local:8123
- API Token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
- WebSocket URL: ws://homeassistant.local:8123/api/websocket
```

### 方式2: 使用HASS CLI工具（推荐）

```bash
# 安装hass-cli
pip install homeassistant-cli

# 配置
hass-cli --server http://homeassistant.local:8123 \
         --token YOUR_API_TOKEN \
         info
```

## 🎯 使用示例

### Telegram控制命令

```
# 查询所有设备状态
/状态

# 打开灯光
开客厅灯

# 设置温度
温度设为24度

# 查看自动化
/自动化列表

# 创建场景
创建回家场景：开灯、开空调、播放音乐
```

## 🔧 工具和技能

建议安装的技能：

```bash
# 如果有HASS相关的ClawHub技能
clawhub install hass-integration
```

## 📝 自定义快捷指令

在Telegram中可以设置快捷按钮或命令别名：

- `/light on` - 打开所有灯
- `/off` - 关闭所有设备
- `/away` - 离家模式

## 🛡️ 安全建议

1. **使用allowlist**: 只允许可信用户访问
2. **Token管理**: 定期更换API Token
3. **操作日志**: 记录所有重要操作
4. **敏感操作**: 二次确认（删除、重置等）

## 📊 监控和通知

可以设置cron任务定期检查HASS状态：

```bash
# 创建cron检查HASS健康状态
openclaw cron add --json '{
  "name": "hass-health-check",
  "schedule": {"kind": "every", "everyMs": 300000},
  "payload": {
    "kind": "agentTurn",
    "message": "检查Home Assistant服务状态"
  },
  "sessionTarget": "isolated",
  "delivery": {
    "mode": "announce",
    "channel": "telegram",
    "to": "YOUR_TELEGRAM_USER_ID"
  }
}'
```

## 🐛 故障排查

### Bot无响应
```bash
# 检查日志
openclaw gateway status
journalctl -u openclaw -f
```

### HASS连接失败
```bash
# 测试API连接
curl http://homeassistant.local:8123/api/ \
  -H "Authorization: Bearer YOUR_TOKEN"
```

### 消息路由错误
```bash
# 查看binding配置
openclaw agents list --bindings
```

## 📚 参考文档

- OpenClaw多智能体: https://docs.openclaw.ai/concepts/multi-agent
- Home Assistant API: https://developers.home-assistant.io/docs/api/rest
- Telegram Bot API: https://core.telegram.org/bots/api

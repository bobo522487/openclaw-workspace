# Telegram Dev Bot 配置文档

## 概述

已成功配置新的 Telegram bot `@bobo522487_dev_bot` 专门用于 dev agent。

## 配置修改内容

### 1. 会话范围配置
```json
"session": {
  "dmScope": "per-account-channel-peer"
}
```
**说明**: 确保每个 Telegram 账户的每个用户都有独立的会话历史。

### 2. Telegram 多账户配置
```json
"channels": {
  "telegram": {
    "enabled": true,
    "dmPolicy": "pairing",
    "botToken": "8632613892:AAHaU69C-rOVb-ds3qvngPCl3Y9Q7Sr391U",
    "groupPolicy": "allowlist",
    "streaming": "off",
    "accounts": {
      "default": {
        "botToken": "8632613892:AAHaU69C-rOVb-ds3qvngPCl3Y9Q7Sr391U",
        "dmPolicy": "pairing",
        "groupPolicy": "allowlist",
        "streaming": "off"
      },
      "dev": {
        "botToken": "8698538957:AAH27vrNftl4-PGtgg_tMcH4JdOMYmYG1Ko",
        "dmPolicy": "pairing",
        "groupPolicy": "allowlist",
        "streaming": "off"
      }
    }
  }
}
```

### 3. Agent 绑定配置
```json
"bindings": [
  {
    "agentId": "main",
    "match": {
      "channel": "telegram",
      "accountId": "default"
    }
  },
  {
    "agentId": "dev",
    "match": {
      "channel": "telegram",
      "accountId": "dev"
    }
  }
]
```

## 两种交互模式

### 模式 1：直接模式（推荐）

**描述**: 用户直接与 `@bobo522487_dev_bot` 对话，bot 直接作为 dev agent 的界面。

**使用方式**:
1. 在 Telegram 中找到 `@bobo522487_dev_bot`
2. 点击 "Start" 按钮开始对话
3. 首次使用会收到配对码（pairing code）
4. 运行以下命令批准配对：
   ```bash
   openclaw pairing approve telegram <配对码>
   ```
5. 批准后，所有发给该 bot 的消息都会直接路由到 dev agent

**优点**:
- 简单直接
- 与 main agent 的会话完全隔离
- 适合专注于开发任务的场景

### 模式 2：转发模式（通过 main 编排）

**描述**: 在 main agent 的 chat 中，由 main 编排器将任务委派给 dev agent。

**使用方式**:
在 main agent 的聊天中直接发送消息，main agent 会自动识别是否需要委派给 dev agent。

**说明**:
- main agent 的 bot 是 `@bobo522487_bot`（default 账户）
- main agent 可以通过 subagent 机制委派任务给 dev agent
- 不需要直接与 dev bot 对话

**优点**:
- 统一入口
- main agent 可以协调多个 subagent（dev, qa, ops 等）
- 适合需要多个 agent 协作的复杂任务

## 会话隔离

配置确保了两种会话隔离：

1. **Account 级隔离**: `@bobo522487_dev_bot` (dev 账户) 和 `@bobo522487_bot` (default 账户) 使用不同的 bot token

2. **Peer 级隔离**: 每个 Telegram 用户在 dev bot 中有独立的会话历史，存储在：
   ```
   ~/.openclaw/agents/dev/sessions/sessions.json
   ```

3. **Agent 级隔离**: dev agent 和 main agent 有各自独立的会话历史

## 启动/重启命令

### 检查状态
```bash
openclaw gateway status
```

### 重启 Gateway
```bash
openclaw gateway restart
```

### 查看日志
```bash
openclaw logs --follow
```

### 检查配对状态
```bash
openclaw pairing list telegram
```

## 验证配置

### 1. 验证配置文件语法
```bash
openclaw doctor
```

### 2. 检查通道状态
```bash
openclaw channels status
```

### 3. 测试 dev bot
1. 在 Telegram 中发送消息给 `@bobo522487_dev_bot`
2. 检查是否收到配对码
3. 批配配对后，测试 dev agent 是否正确响应

## 配置文件位置

- 主配置: `~/.openclaw/openclaw.json`
- 配置备份: `~/.openclaw/openclaw.json.backup.20260228`
- Dev 会话历史: `~/.openclaw/agents/dev/sessions/sessions.json`
- 主会话历史: `~/.openclaw/agents/main/sessions/sessions.json`

## 注意事项

1. **配对模式**: 两个 bot 都使用 `pairing` 模式，首次使用需要批准配对码
2. **热重载**: OpenClaw 支持配置热重载，修改配置后通常无需重启
3. **安全**: Bot token 已添加到配置文件，请勿公开分享
4. **备份**: 已创建配置文件备份，如需回滚可恢复备份

## 故障排查

### Dev bot 不响应
```bash
# 检查 Gateway 是否运行
openclaw gateway status

# 查看日志
openclaw logs --follow

# 检查配对状态
openclaw pairing list telegram
```

### 消息路由到错误的 agent
```bash
# 检查 bindings 配置
openclaw config get bindings

# 验证配置
openclaw doctor
```

### 配置修改不生效
```bash
# 重启 Gateway
openclaw gateway restart
```

## 技术细节

- **Bot Token**: `8698538957:AAH27vrNftl4-PGtgg_tMcH4JdOMYmYG1Ko`
- **Bot 用户名**: `@bobo522487_dev_bot`
- **绑定 Agent**: `dev`
- **会话范围**: `per-account-channel-peer`
- **配对模式**: `pairing`
- **群组策略**: `allowlist`

## 下一步

1. 测试 `@bobo522487_dev_bot` 是否正常工作
2. 根据需要调整群组策略（`groupPolicy`）
3. 根据需要调整配对策略（`dmPolicy`）
4. 监控 Gateway 日志确保 bot 正常运行

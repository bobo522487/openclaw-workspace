---
name: medication-reminder
description: 发送带按钮的吃药提醒消息
tools: ["read", "write", "message"]
---

# 吃药提醒技能

## 使用方法

当收到 Cron 任务触发的消息（如"发送早间吃药提醒给主人"）时，执行以下操作：

### 1. 读取历史记录

```javascript
const fs = require('fs');
const statePath = '/home/node/.openclaw/workspace/medication-state.json';

let state;
try {
  const data = fs.readFileSync(statePath, 'utf8');
  state = JSON.parse(data);
} catch (error) {
  state = { history: [], lastUpdate: null };
}
```

### 2. 生成提醒消息

根据当前时间和历史记录生成消息：

```
💊 该吃药啦！（早上9点的药）

📌 上次记录：[从历史中获取]

请点击按钮记录状态～
```

### 3. 发送消息

使用 message 工具发送带按钮的消息：

```json
{
  "action": "send",
  "channel": "telegram",
  "to": "8098317871",
  "message": "💊 该吃药啦！（早上9点的药）\n\n📌 上次记录：无\n\n请点击按钮记录状态～",
  "buttons": "[[{\"text\": \"✅ 已吃\", \"callback_data\": \"med_taken_09:00\"}, {\"text\": \"❌ 还没吃\", \"callback_data\": \"med_skipped_09:00\"}]]"
}
```

### 4. 记录状态

当主人点击按钮后，更新状态：

```javascript
// 更新状态
const newRecord = {
  time: "09:00",
  status: "taken", // 或 "skipped"
  timestamp: new Date().toISOString(),
  displayTime: new Date().toLocaleString('zh-CN', { timeZone: 'Asia/Shanghai' })
};

state.history.push(newRecord);
state.lastUpdate = new Date().toISOString();

fs.writeFileSync(statePath, JSON.stringify(state, null, 2));
```

---

## Cron 任务配置

三个吃药提醒任务已配置：

### 早间提醒（09:00）
- Cron: `0 9 * * *`
- 时区: `Asia/Shanghai`
- 任务ID: `fdc293a1-59cd-4d9e-8203-da6b7758f2cb`
- Delivery: 直接发送到 Telegram

### 午间提醒（15:00）
- Cron: `0 15 * * *`
- 时区: `Asia/Shanghai`
- 任务ID: `a9b1b50a-bce0-4721-8258-66197b102cd8`
- Delivery: 直接发送到 Telegram

### 晚间提醒（23:00）
- Cron: `0 23 * * *`
- 时区: `Asia/Shanghai`
- 任务ID: `d8462ed6-bfaf-4145-aa35-698e641426cf`
- Delivery: 直接发送到 Telegram

---

## 问题说明

### 为什么之前没有提醒？

1. **原始设计问题**
   - 使用 `sessionTarget: "main"` → 发送系统事件
   - 依赖 heartbeat 轮询识别事件
   - HEARTBEAT.md 未配置检查逻辑
   - 导致即使触发也不会执行提醒

2. **修复方案**
   - 改为 `sessionTarget: "isolated"` → 独立 agent 执行
   - 添加 `delivery` 配置 → 直接发送到 Telegram
   - 任务会立即执行并发送提醒
   - 不依赖 heartbeat 轮询

---

## 状态文件

### medication-state.json 结构

```json
{
  "history": [
    {
      "time": "15:00",
      "status": "skipped",
      "timestamp": "2026-02-08T07:22:00.000Z",
      "displayTime": "2026-02-08 15:22"
    }
  ],
  "lastUpdate": "2026-02-08T07:22:00.000Z"
}
```

---

**制作：** 露娜数码使魔 🐱
**日期：** 2026-02-08
**版本：** v2.0 (修复版）

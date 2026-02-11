# HEARTBEAT.md

## 吃药提醒逻辑

如果收到以下系统事件消息：
- `[MEDICATION:09:00]` - 早间吃药提醒
- `[MEDICATION:15:00]` - 午间吃药提醒  
- `[MEDICATION:23:00]` - 晚间吃药提醒

执行操作：
1. 读取 `/home/node/.openclaw/workspace/medication-state.json`
2. 发送带按钮的吃药提醒消息
3. 等待主人点击按钮后更新状态

---

## 每日早报逻辑

如果收到以下系统事件消息：
- `[DAILY_MORNING_REPORT]` - 每日早报

执行操作：
1. 获取贵阳天气信息
2. 搜索科技新闻（3条）
3. 搜索AI新闻（3条）
4. 生成并发送早报消息

---

## 修改记录

### 2026-02-10 00:40 UTC
- ✅ 早报任务 cron 表达式已更新为 `15 0 * * *` (北京时间 08:15)
- ✅ payload 已更新为使用 `[DAILY_MORNING_REPORT]` 事件
- ✅ 系统将在每天 08:15 (北京时间) 发送 `[DAILY_MORNING_REPORT]` 事件
- ✅ 确认 HEARTBEAT.md 包含早报逻辑

---

## 注意
此文件仅用于指导心跳轮询时的行为。

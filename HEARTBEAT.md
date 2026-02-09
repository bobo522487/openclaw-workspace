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

如果收到系统事件消息：
- `[DAILY_MORNING_REPORT]` - 每日早报

执行操作：
1. 获取天气信息
2. 搜索科技新闻（3条）
3. 搜索AI新闻（3条）
4. 生成并发送早报消息

---

注意：此文件仅用于指导心跳轮询时的行为，不包含其他定期检查。

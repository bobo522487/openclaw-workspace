# AGENTS.md - HASS智能体的家

这是HASS智能体的工作空间。

## Home Assistant配置

### 连接信息
- HASS URL: http://10.10.10.8:8123
- API Token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI2MzA3YTZhNTE2NjE0MDNjOTMxMmFlNWQyYWI2NDlmMCIsImlhdCI6MTc3MDYwNTQxMCwiZXhwIjoyMDg1OTY1NDEwfQ.01D1Yp4iehSPlQUEcVPh5558KqDXytEs_dowWB6YrGk
- WebSocket URL: [待配置]

## 设备清单

[根据实际HASS实例填写]

## 自动化规则

[记录重要的自动化规则和触发条件]

## 常用命令

### 查询设备状态
```bash
# 示例
curl -H "Authorization: Bearer <TOKEN>" \
     http://<HASS_URL>/api/states
```

### 控制设备
```bash
curl -H "Authorization: Bearer <TOKEN>" \
     -H "Content-Type: application/json" \
     -d '{"entity_id": "switch.example", "state": "on"}' \
     http://<HASS_URL>/api/services/switch/turn_on
```

## 工作流

1. 收到用户请求
2. 解析设备/自动化需求
3. 调用HASS API执行操作
4. 返回结果和状态确认
5. 记录操作日志

## 记忆

重要的配置变更、设备调整、用户偏好请记录在 `memory/` 目录。

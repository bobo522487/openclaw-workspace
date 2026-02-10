# Home Assistant Skill 配置和使用指南

**最后更新：** 2026-02-10 03:19 UTC (北京时间 11:19)

---

## 📋 Skill 信息

**名称：** homeassistant-skill
**描述：** 通过 Home Assistant REST API 控制设备和自动化
**支持设备数：** 25+ 实体类型
**兼容性：** 所有使用 Home Assistant 的版本
**依赖：** curl、jq（用于 JSON 解析）

---

## 🎯 核心功能

### 1. 📟 完整的设备控制
- **灯光：** 开关、调亮度、调颜色
- **开关：** 智能插头、电器开关
- **气候：** 温度调节、模式切换
- **窗帘：** 开关、控制位置
- **锁：** 锁定/解锁
- **风扇：** 开关、风速控制
- **媒体播放器：** 播放/暂停、音量控制
- **传感器：** 读取温度、湿度、电力等
- **场景：** 执行预设场景
- **脚本：** 运行复杂脚本

### 2. 🏠 区域和房间管理
- **发现所有区域：** 厨房、卧室、客厅等
- **查找区域中的设备：** 查找某个房间的所有灯光
- **区域状态：** 哪个区域有设备开启
- **楼层管理：** 楼层和区域的映射关系

### 3. 🔄 自动化管理
- **列表：** 查看所有自动化
- **触发：** 手动触发自动化
- **启用/禁用：** 开启或关闭自动化

### 4. 🛡️ 安全规则（重要）
**必须确认的操作：**
- 🔒 锁定/解锁
- 🔒 报警系统布防/撤防
- 🔒 车库门控制
- 🔒 涉及物理访问的门窗

**原因：** 这些操作影响安全，必须得到主人明确授权

---

## 🚀 快速开始

### 步骤 1：准备环境变量

在 OpenClaw 的环境变量或配置文件中设置：

```bash
# Home Assistant URL
export HA_URL="http://10.10.10.8:8123"

# Long-lived Access Token
export HA_TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."

# （可选）区域别名
export HA_AREA_KITCHEN="kitchen"
export HA_AREA_LIVING="living_room"
```

### 步骤 2：测试连接

```bash
# 测试 API 连接
curl -s -o /dev/null -w "%{http_code}" \
  "$HA_URL/api/" \
  -H "Authorization: Bearer $HA_TOKEN"

# 应该返回 200
```

### 步骤 3：测试基本功能

**查询所有设备：**
```bash
curl -s "$HA_URL/api/states" \
  -H "Authorization: Bearer $HA_TOKEN" \
  | jq '.[] | select(.entity_id | startswith("light.")) | [.entity_id, .state]' \
  | head -5
```

**查询设备状态：**
```bash
curl -s "$HA_URL/api/states/light.kitchen" \
  -H "Authorization: Bearer $HA_TOKEN"
```

---

## 🎮 设备控制示例

### 灯光控制

**开灯（支持亮度和颜色）：**
```bash
# 基础开灯
curl -s -X POST "$HA_URL/api/services/light/turn_on" \
  -H "Authorization: Bearer $HA_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"entity_id": "light.living_room"}'

# 开灯并设置亮度
curl -s -X POST "$HA_URL/api/services/light/turn_on" \
  -H "Authorization: Bearer $HA_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"entity_id": "light.living_room", "brightness_pct": 80}'

# 开灯并设置颜色（RGB）
curl -s -X POST "$HA_URL/api/services/light/turn_on" \
  -H "Authorization: Bearer $HA_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"entity_id": "light.living_room", "rgb_color": [255, 150, 50]}'

# 关灯
curl -s -X POST "$HA_URL/api/services/light/turn_off" \
  -H "Authorization: Bearer $HA_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"entity_id": "light.living_room"}'
```

---

### 开关控制

**开/关智能插头：**
```bash
# 打开
curl -s -X POST "$HA_URL/api/services/switch/turn_on" \
  -H "Authorization: Bearer $HA_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"entity_id": "switch.plug_fan"}'

# 关闭
curl -s -X POST "$HA_URL/api/services/switch/turn_off" \
  -H "Authorization: Bearer $HA_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"entity_id": "switch.plug_fan"}'

# 切换（开→关 或 关→开）
curl -s -X POST "$HA_URL/api/services/switch/toggle" \
  -H "Authorization: Bearer $HA_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"entity_id": "switch.plug_fan"}'
```

---

### 气候控制

**设置温度：**
```bash
# 设置目标温度
curl -s -X POST "$HA_URL/api/services/climate/set_temperature" \
  -H "Authorization: Bearer $HA_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"entity_id": "climate.thermostat", "temperature": 24}'

# 设置 HVAC 模式
curl -s -X POST "$HA_URL/api/services/climate/set_hvac_mode" \
  -H "Authorization: Bearer $HA_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"entity_id": "climate.thermostat", "hvac_mode": "heat"}'
```

---

### 场景控制

**执行场景：**
```bash
# 执行预设场景
curl -s -X POST "$HA_URL/api/services/scene/turn_on" \
  -H "Authorization: Bearer $HA_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"entity_id": "scene.movie_time"}'
```

---

### 脚本控制

**运行脚本：**
```bash
# 运行脚本
curl -s -X POST "$HA_URL/api/services/script/turn_on" \
  -H "Authorization: Bearer $HA_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"entity_id": "script.bedtime_routine"}'

# 运行脚本并传递变量
curl -s -X POST "$HA_URL/api/services/script/turn_on" \
  -H "Authorization: Bearer $HA_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"entity_id": "script.bedtime_routine", "variables": {"brightness": 20, "delay_minutes": 5}}'
```

---

## 🔍 发现和查询

### 列出所有实体

```bash
# 列出所有灯光
curl -s "$HA_URL/api/states" \
  -H "Authorization: Bearer $HA_TOKEN" \
  | jq -r '.[] | select(.entity_id | startswith("light.")) | [.entity_id, .state]'

# 列出所有开关
curl -s "$HA_URL/api/states" \
  -H "Authorization: Bearer $HA_TOKEN" \
  | jq -r '.[] | select(.entity_id | startswith("switch.")) | [.entity_id, .state]'

# 列出所有传感器
curl -s "$HA_URL/api/states" \
  -H "Authorization: Bearer $HA_TOKEN" \
  | jq -r '.[] | select(.entity_id | startswith("sensor.")) | [.entity_id, .state, .attributes.unit_of_measurement // ""]'
```

---

### 区域和房间查询

```bash
# 列出所有区域
curl -s -X POST "$HA_URL/api/template" \
  -H "Authorization: Bearer $HA_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"template": "{{ areas() }}"}'

# 列出某个区域中的所有实体
curl -s -X POST "$HA_URL/api/template" \
  -H "Authorization: Bearer $HA_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"template": "{{ area_entities(\\"kitchen\") }}"}'

# 查找某个实体属于哪个区域
curl -s -X POST "$HA_URL/api/template" \
  -H "Authorization: Bearer $HA_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"template": "{{ area_name(\"light.kitchen\") }}"}'
```

---

### 模板查询

```bash
# 统计开启的灯光数量
curl -s -X POST "$HA_URL/api/template" \
  -H "Authorization: Bearer $HA_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"template": "{{ states.light | select(\"match\", \"on\") | list | count }}"}'

# 获取所有"在家"的人员
curl -s -X POST "$HA_URL/api/template" \
  -H "Authorization: Bearer $HA_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"template": "{{ states.person | select(\"match\", \"home\") | map(attribute=\"entity_id\") | list }}"}'
```

---

## 🛡️ 安全规则和最佳实践

### ⚠️ 必须确认的操作

**安全相关：**
- 🔒 **锁：** 锁定/解锁（`lock.lock` / `lock.unlock`）
- 🔒 **报警：** 布防/撤防（`alarm_control_panel.alarm_arm_home` / `alarm_disarm`）
- 🔒 **车库：** 开关门（`cover.garage`）
- 🔒 **门窗：** 开/关物理访问（`cover` 类，`device_class: garage`/`gate`/`door`）

**确认流程：**
1. 露娜明确告知用户将要执行的操作
2. 用户确认（"是的，执行"或类似的明确指令）
3. 露娜执行操作
4. 露娜报告执行结果

**拒绝示例：**
```
用户："锁门"
露娜："抱歉主人，露娜需要明确确认才能执行这个安全操作。
       这会影响您的家庭安全，请确认是否要锁门。"
```

---

### ✅ 不需要确认的操作

**日常操作：**
- 💡 **灯光：** 开/关/调亮度
- 💨 **风扇：** 开/关
- 🌡️ **温控：** 调节温度
- 📺 **媒体：** 播放/暂停、调音量
- 📺 **脚本：** 执行日常脚本（如"晚安模式"）
- 📺 **场景：** 执行安全场景（如"观影模式"）

---

## 🎯 与露娜智能集成的建议

### 1. 🔄 替代现有的 REST API 调用

**当前方式：**
```bash
curl -X POST "$HA_URL/api/services/switch/turn_on" \
  -H "Authorization: Bearer $HA_TOKEN" \
  -d '{"entity_id": "switch.plug_fan"}'
```

**建议方式：**
将 HA_TOKEN 和 HA_URL 存储在环境变量中，露娜可以直接使用：

```javascript
// 露娜可以直接调用，无需每次写完整的 curl 命令
const haToken = process.env.HA_TOKEN;
const haUrl = process.env.HA_URL;

// 执行设备控制
const result = await haService.callService('switch', 'turn_on', {
  entity_id: 'switch.plug_fan'
});
```

---

### 2. 📋 创建常用命令别名

**在 workspace 中创建脚本：**
```bash
# ~/.openclaw/workspace/scripts/ha-control.sh
#!/bin/bash

# 常用的 Home Assistant 控制命令
source ~/.openclaw/workspace/scripts/ha-config.sh

# 快捷命令
alias ha-lights-on='curl -s -X POST "$HA_URL/api/services/homeassistant/turn_on" -H "Authorization: Bearer $HA_TOKEN" -d '\''{"entity_id": "group.all_lights"}'\'''
alias ha-lights-off='curl -s -X POST "$HA_URL/api/services/homeassistant/turn_off" -H "Authorization: Bearer $HA_TOKEN" -d '\''{"entity_id": "group.all_lights"}'\''
alias ha-fan-on='curl -s -X POST "$HA_URL/api/services/fan/turn_on" -H "Authorization: Bearer $HA_TOKEN" -d '\''{"entity_id": "fan.bedroom"}'\'''
alias ha-fan-off='curl -s -X POST "$HA_URL/api/services/fan/turn_off" -H "Authorization: Bearer $HA_TOKEN" -d '\''{"entity_id": "fan.bedroom"}'\'''
alias ha-movie='curl -s -X POST "$HA_URL/api/services/scene/turn_on" -H "Authorization: Bearer $HA_TOKEN" -d '\''{"entity_id": "scene.movie_time"}'\'''
alias ha-night='curl -s -X POST "$HA_URL/api/services/scene/turn_on" -H "Authorization: Bearer $HA_TOKEN" -d '\''{"entity_id": "scene.good_night"}'\'''
```

---

### 3. 🤖 智能场景识别

**根据主人的习惯：**

**场景 1：离家模式**
```javascript
// 主人说："我要出门了"
// 露娜自动执行：
1. 关闭所有灯光
2. 关闭所有风扇
3. 锁门（需确认）
4. 开启安防系统（需确认）
5. 检查所有门窗是否关闭
```

**场景 2：回家模式**
```javascript
// 主人说："我回来了"
// 露娜自动执行：
1. 打开客厅灯光
2. 调节温度到舒适值
3. 播放欢迎音乐
4. 关闭安防系统（需确认）
```

**场景 3：看电影**
```javascript
// 主人说："看电影"
// 露娜自动执行：
1. 关闭主灯
2. 打开氛围灯（调整颜色和亮度）
3. 关闭窗帘
4. 调节温度
```

---

### 4. 📊 主动状态监控

**定期检查：**
```javascript
// 每 5 分钟检查一次
setInterval(async () => {
  // 检查所有灯光状态
  const lights = await haService.getStates('light.*');
  
  // 检查所有传感器
  const sensors = await haService.getStates('sensor.*');
  
  // 分析异常
  const anomalies = detectAnomalies(lights, sensors);
  
  // 如有异常，报告给主人
  if (anomalies.length > 0) {
    await message.send({
      text: `⚠️ 检测到 ${anomalies.length} 个异常：\n` +
            anomalies.map(a => `- ${a.message}`).join('\n')
    });
  }
}, 300000); // 5 分钟
```

---

## 📝 集成到现有工作流

### 更新 TOOLS.md

在 `TOOLS.md` 中添加 Home Assistant 相关配置：

```markdown
## Home Assistant

### 设备别名
- living_room_lights: light.living_room_main, light.living_room_lamp
- bedroom_lights: light.bedroom_main, light.bedroom_bedside
- office_lights: light.office_desk, light.office_ceiling
- main_fan: fan.living_room
- bedroom_ac: climate.bedroom

### 场景别名
- night_mode: scene.good_night
- movie_mode: scene.movie_time
- away_mode: scene.all_off
- home_mode: scene.welcome_home

### 安全设备（需确认）
- front_door_lock: lock.front_door
- garage_door: cover.garage
- alarm_system: alarm_control_panel.home

### API 配置
- URL: http://10.10.10.8:8123
- Token: [见环境变量 $HA_TOKEN]
- Skill: homeassistant-skill (已安装)
```

---

### 更新 HEARTBEAT.md（可选）

添加 Home Assistant 相关的心跳任务：

```markdown
## 智能家居监控逻辑

如果收到以下系统事件消息：
- `[HOME_ASSISTANT:CHECK_ANOMALIES]` - 检查设备异常

执行操作：
1. 查询所有灯光状态（异常开启）
2. 查询所有门窗状态（异常打开）
3. 检查温度传感器（异常温度）
4. 如发现异常，发送警告消息
```

---

## 🚨 错误处理和调试

### 常见错误

**401 Unauthorized:**
- 原因：Token 无效或过期
- 解决：重新生成 Long-lived Access Token

**404 Not Found:**
- 原因：Entity ID 不存在
- 解决：先通过 `/api/states` 列出所有实体，确认正确的 ID

**400 Bad Request:**
- 原因：请求格式错误
- 解决：检查 JSON 格式和必需字段

**405 Method Not Allowed:**
- 原因：服务不支持当前方法
- 解决：检查服务和操作是否匹配

---

### 调试技巧

**1. 使用 jq 格式化输出**
```bash
curl -s "$HA_URL/api/states/light.kitchen" \
  -H "Authorization: Bearer $HA_TOKEN" \
  | jq '.'
```

**2. 检查 API 响应头**
```bash
curl -sI "$HA_URL/api/" \
  -H "Authorization: Bearer $HA_TOKEN"
```

**3. 验证 JSON 语法**
```bash
# 在发送前验证 JSON
echo '{"entity_id": "light.kitchen", "brightness_pct": 80}' | jq '.'
```

---

## 🎉 总结

### ✅ homeassistant-skill 的优势

1. **功能完整** - 支持 25+ 实体类型和完整 API
2. **安全可靠** - 明确的安全规则，防止误操作
3. **文档齐全** - SKILL.md 包含详细的 API 文档
4. **灵活扩展** - 可以轻松添加自定义命令和脚本
5. **免费开源** - MIT 许可证，无使用限制

### 🎯 与露娜的集成建议

1. **配置环境变量** - 存储 HA_URL 和 HA_TOKEN
2. **创建常用命令别名** - 提高日常操作效率
3. **实现智能场景** - 根据主人习惯自动执行
4. **主动监控** - 定期检查设备状态和异常
5. **遵循安全规则** - 对安全操作必须明确确认

### 📋 下一步行动

1. ✅ **测试连接** - 使用 curl 测试 API 是否可用
2. ✅ **列出设备** - 获取所有实体 ID 和状态
3. ✅ **测试基本控制** - 尝试控制几个常用设备
4. ✅ **创建场景** - 配置常用场景（回家、离家、看电影等）
5. ✅ **优化工作流** - 将常用操作集成到露娜的日常对话中

---

*制作：露娜 - 数码使魔*
*最后更新：2026-02-10 03:19 UTC*

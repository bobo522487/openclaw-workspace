# 智能家居场景配置

## 💡 常用场景

### 回家模式 (Welcome Home)
- **触发条件：** 手动触发 或 地理围栏（待配置）
- **执行动作：**
  - 打开客厅灯
  - 打开书房灯
  - 开启空调（温度26度）
  - 打开网关（激活其他设备）

### 离家模式 (Away)
- **触发条件：** 手动触发 或 地理围栏（待配置）
- **执行动作：**
  - 关闭所有灯光
  - 关闭空调
  - 开启安防模式（待配置）

### 睡眠模式 (Sleep)
- **触发条件：** 晚上23:00自动触发 或 手动触发
- **执行动作：**
  - 关闭所有主灯
  - 保留走廊小夜灯（10%亮度）
  - 关闭空调
  - 开启夜间静音模式

### 起床模式 (Wake Up)
- **触发条件：** 早上07:00自动触发 或 手动触发
- **执行动作：**
  - 逐渐亮起卧室灯（10分钟从0到100%）
  - 打开窗帘（待配置）
  - 开启咖啡机（待配置）

## 🔄 自动化规则模板

### 时间触发
```yaml
trigger:
  - platform: time
    at: "23:00:00"
condition: []
action:
  - service: homeassistant.turn_off
    entity_id: group.all_lights
```

### 温度触发
```yaml
trigger:
  - platform: numeric_state
    entity_id: sensor.temperature
    above: 30
condition: []
action:
  - service: climate.set_temperature
    data:
      temperature: 26
    target:
      entity_id: climate.ac
```

## 📝 场景待开发

- [ ] 工作模式（专注氛围灯）
- [ ] 电影模式（关闭主灯，氛围灯蓝色）
- [ ] 派对模式（灯光律动）
- [ ] 阅读模式（暖色调灯光）
- [ ] 运动模式（强光、风扇）

---

*维护者：露娜*

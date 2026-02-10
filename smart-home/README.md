# 🏠 露娜的智能家居控制中心

> "主人，这里是露娜为您打造的智能家园控制台喵！"

## 📋 初始化状态

✅ **已完成：**
- Home Assistant服务器在线检测（http://10.10.10.8:8123）
- 创建设备配置文件 `smart-home/devices.md`
- 创建每日记录 `memory/2026-02-09.md`
- **配置ha-mcp MCP服务器集成** (2026-02-09)

## 🔧 技术架构

- **Home Assistant MCP (ha-mcp)** - 通过MCP协议的80+工具控制
- **MCP服务器配置** - 已集成到OpenClaw的agents.defaults.mcp
- **Xiaomi Home 集成** - 小米设备管理
- **自动化引擎** - 场景和规则执行

## 📝 迁移历史

### 2026-02-09: 从REST API迁移到MCP

**问题：** 直接使用Home Assistant REST API需要手动管理entity_id和构造API请求，开发效率低

**解决方案：** 配置ha-mcp MCP服务器，提供80+标准化工具

**配置：**
```json5
{
  "agents.defaults.mcp.servers": [
    {
      "name": "homeassistant",
      "command": "npx",
      "args": ["-y", "@homeassistant-ai/ha-mcp"],
      "env": {
        "HA_URL": "http://10.10.10.8:8123",
        "HA_TOKEN": "eyJhbGc..."
      }
    }
  ]
}
```

**优势：**
- ✅ 无需手动管理entity_id
- ✅ 80+预置工具 vs 之前的1-2个API调用
- ✅ 智能设备发现
- ✅ 语义化接口，AI更易理解
- ✅ 支持自动化、日历、待办等高级功能

## 🎮 使用方式

### 简单控制
```
"打开书房灯"
"关闭空调"
```

### 查询状态
```
"查看所有设备状态"
"检查空调温度"
"列出所有灯光"
```

### 创建场景
```
"创建'回家模式'场景（打开所有灯，空调26度）"
```

### 自动化
```
"设置：晚上11点自动关闭所有灯"
"设置：温度超过30度自动开空调"
```

## 📊 当前已知设备

- 米家多功能网关1 ✅ 已连接
- 米家空调伴侣 ✅ 已连接
- 书房顶灯 ✅ 可控制（entity: switch.isa_cn_1045790671_kg01hl_on_p_2_1）

## 🔑 MCP工具示例

通过MCP，露娜可以调用以下工具类别：

### 设备控制
- `homeassistant.call_service` - 调用任何服务（开灯、关灯、调节温度等）
- `homeassistant.get_state` - 查询设备状态

### 自动化
- `homeassistant.list_automations` - 列出所有自动化
- `homeassistant.create_automation` - 创建新自动化

### 其他功能
- `homeassistant.list_entities` - 列出所有设备
- `homeassistant.call_script` - 执行脚本
- `homeassistant.get_calendar_events` - 获取日历事件
- `homeassistant.get_todo_items` - 获取待办事项
- 以及更多...

---

*维护者：露娜 💜*
*最后更新：2026-02-09 11:15*

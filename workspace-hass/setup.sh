#!/bin/bash
# HASS智能体快速设置脚本

set -e

echo "🏠 OpenClaw HASS智能体设置向导"
echo "================================"
echo ""

# 1. 创建Telegram Bot
echo "📱 步骤1: 创建Telegram Bot"
echo "---------------------------"
echo "1. 在Telegram中搜索 @BotFather"
echo "2. 发送 /newbot"
echo "3. 按照提示设置bot名称和用户名"
echo "4. 复制返回的token"
echo ""
read -p "请输入你的HASS bot token: " HASS_BOT_TOKEN

# 2. 获取Telegram User ID
echo ""
echo "👤 步骤2: 获取你的Telegram User ID"
echo "-----------------------------------"
echo "1. 在Telegram中搜索 @userinfobot"
echo "2. 发送 /start"
echo "3. 复制返回的数字ID"
echo ""
read -p "请输入你的Telegram User ID: " TELEGRAM_USER_ID

# 3. Home Assistant配置（可选）
echo ""
echo "🏡 步骤3: Home Assistant配置（可选，稍后也可以配置）"
echo "-----------------------------------------------------"
echo "你需要Home Assistant的API Token才能让bot控制设备"
echo ""
read -p "是否现在配置Home Assistant连接？ (y/n): " CONFIG_HASS

HASS_URL=""
HASS_TOKEN=""

if [ "$CONFIG_HASS" = "y" ]; then
    echo ""
    read -p "请输入Home Assistant URL (例如: http://homeassistant.local:8123): " HASS_URL
    read -p "请输入Home Assistant API Token: " HASS_TOKEN
fi

# 4. 备份现有配置
CONFIG_FILE="$HOME/.openclaw/openclaw.json"
BACKUP_FILE="$HOME/.openclaw/openclaw.json.backup.$(date +%Y%m%d_%H%M%S)"

if [ -f "$CONFIG_FILE" ]; then
    echo ""
    echo "💾 备份现有配置文件到: $BACKUP_FILE"
    cp "$CONFIG_FILE" "$BACKUP_FILE"
fi

# 5. 生成配置
echo ""
echo "📝 生成OpenClaw配置..."
echo ""

# 这里应该生成JSON配置，但为了简化，我们提供配置模板
cat > "$HOME/.openclaw/workspace-hass/config-generated.json5" <<EOF
// 生成的HASS智能体配置
// 需要手动合并到 ~/.openclaw/openclaw.json

{
  agents: {
    list: [
      // 在你的现有agents.list中添加:
      {
        id: "hass",
        name: "HASS Bot",
        workspace: "~/.openclaw/workspace-hass",
        model: "zai/glm-4.7",
        groupChat: {
          mentionPatterns: ["@hass", "@hassbot", "@home"],
        },
      },
    ],
  },

  bindings: [
    // 在bindings数组中添加:
    {
      agentId: "hass",
      match: {
        channel: "telegram",
        accountId: "hass-bot",
      },
    },
  ],

  channels: {
    telegram: {
      dmPolicy: "allowlist",
      allowFrom: ["$TELEGRAM_USER_ID"],

      accounts: {
        // 在accounts中添加:
        "hass-bot": {
          botToken: "$HASS_BOT_TOKEN",
        },
      },
    },
  },
}
EOF

echo "✅ 配置文件已生成: $HOME/.openclaw/workspace-hass/config-generated.json5"

# 6. 更新AGENTS.md
if [ -n "$HASS_URL" ] && [ -n "$HASS_TOKEN" ]; then
    sed -i "s|HASS URL: \[待配置\]|HASS URL: $HASS_URL|g" "$HOME/.openclaw/workspace-hass/AGENTS.md"
    sed -i "s|API Token: \[待配置\]|API Token: $HASS_TOKEN|g" "$HOME/.openclaw/workspace-hass/AGENTS.md"
    echo "✅ Home Assistant配置已更新到AGENTS.md"
fi

# 7. 完成提示
echo ""
echo "🎉 设置步骤完成！"
echo "================================"
echo ""
echo "接下来需要手动完成以下步骤:"
echo ""
echo "1️⃣  合并配置文件:"
echo "   $ cat $HOME/.openclaw/workspace-hass/config-generated.json5"
echo "   将内容添加到 ~/.openclaw/openclaw.json 的相应位置"
echo ""
echo "2️⃣  重启OpenClaw Gateway:"
echo "   $ openclaw gateway restart"
echo ""
echo "3️⃣  测试连接:"
echo "   在Telegram中给你的HASS bot发送消息"
echo ""
echo "4️⃣  验证路由:"
echo "   $ openclaw agents list --bindings"
echo ""
echo "📚 查看完整文档: $HOME/.openclaw/workspace-hass/README.md"
echo ""

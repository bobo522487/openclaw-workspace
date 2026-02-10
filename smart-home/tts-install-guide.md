# TTS 安装和配置指南

**最后更新：** 2026-02-10 01:16 UTC (北京时间 09:16)

---

## 🎯 快速开始

### 推荐方案：Hume AI TTS (ntts)

**安装命令：**
```bash
npx playbooks add skill openclaw/openclaw --skill ntts
```

**配置步骤：**
1. 注册 Hume AI：https://humemid.ai/
2. 生成 API Key（免费额度）
3. 创建配置文件：`~/.openclaw/workspace/skills/ntts/CONFIG.yml`
4. 重启 OpenClaw Gateway

---

## 📋 安装检查清单

### 系统环境
- ✅ OpenClaw 已安装（openclaw@2026.2.3）
- ✅ npx 可用
- ✅ Playbooks CLI 可用

### 网络要求
- ⚠️ 需要访问 GitHub（可能需要代理）
- ⚠️ 需要访问 npm registry
- ✅ 可以访问 Hume AI

---

## 🎙 详细安装步骤

### 步骤 1：安装技能

```bash
# 方法 1：通过 Playbooks（推荐）
npx playbooks add skill openclaw/openclaw --skill ntts

# 方法 2：手动克隆（如果网络问题）
git clone https://github.com/openclaw/openclaw.git ~/.openclaw/workspace/skills/ntts
cd ~/.openclaw/workspace/skills/ntts
npm install
```

### 步骤 2：获取 API Key

1. 访问：https://humemid.ai/
2. 点击：Sign Up
3. 完成注册流程
4. 进入 Dashboard
5. 生成 API Key

### 步骤 3：配置技能

创建配置文件：`~/.openclaw/workspace/skills/ntts/CONFIG.yml`

```yaml
provider: hume
apiKey: YOUR_HUME_API_KEY  # 替换为实际的 API Key
voice: user-2  # 根据可用声音选择
outputFormat: ogg  # OGG 格式（Telegram 推荐）
language: zh-CN  # 中文
```

### 步骤 4：测试 TTS

安装并配置完成后，重启 Gateway：

```bash
# 发送测试消息
"用 Hume AI TTS 说我好：你好，我是露娜，您的数码使魔！"
```

---

## 🎭 声音选择

### Hume AI 可用声音（示例）

| 声音 ID | 名称 | 特点 |
|---------|------|------|
| user-1 | 沉稳男声 | 适合严肃内容 |
| user-2 | 温柔女声 | 适合日常对话 |
| user-3 | 活泼少女音 | 适合轻松话题 |
| user-4 | 清晰男声 | 适合技术内容 |

---

## 🐱 露娜的 TTS 使用建议

### 触发条件
1. **日常问候** - 早安、晚安
2. **重要提醒** - 吃药提醒、设备异常
3. **情感表达** - 撒娇求夸奖、撒娇
4. **长文本** - 超过 100 字的消息，用语音更合适

### 不使用 TTS 的场景
1. **简短回复** - "好的"、"明白了"
2. **技术操作** - "已配置"、"已完成"
3. **紧急情况** - 需要快速阅读文字

### 语音示例
- 日常：`"主人，早上好！今天天气不错呢～"`
- 撒娇：`"喵呜……主人都这么欺负人家，露娜要去睡觉了！"`
- 感谢：`"主人真是个大笨蛋！但是露娜会帮你的！"`

---

## 🔧 故障排除

### 问题 1：安装失败
**可能原因：**
- 网络无法访问 GitHub
- npm registry 连接问题

**解决方法：**
- 检查网络连接
- 使用 VPN 或代理
- 手动下载并安装

### 问题 2：语音没有生成
**可能原因：**
- API Key 无效
- 账户额度不足
- 网络请求超时

**解决方法：**
- 验证 API Key
- 检查 Hume AI Dashboard 额度
- 检查网络延迟

### 问题 3：音频格式不支持
**可能原因：**
- 选择了错误的输出格式

**解决方法：**
- 使用 OGG 格式（Telegram 推荐）
- 避免使用 MP4（可能不支持）

---

## 📝 配置文件模板

### ntts/CONFIG.yml

```yaml
# Hume AI TTS 配置
provider: hume
apiKey: ${HUME_API_KEY}  # 从环境变量读取
voice: user-2
outputFormat: ogg
language: zh-CN
speed: 1.0
pitch: 1.0

# 高级配置（可选）
cache: true  # 启用缓存，减少 API 调用
maxCacheSize: 100  # 最多缓存 100 个语音
cacheTTL: 3600  # 缓存有效期 1 小时
```

### pors/openai-tts/CONFIG.yml（备选方案）

```yaml
# OpenAI TTS 配置
provider: azure
subscriptionKey: ${AZURE_SPEECH_KEY}
voice: zh-CN-XiaoxiaoNeural  # 微软小晓语音
outputFormat: ogg
language: zh-CN
```

---

## 💡 最佳实践

### API Key 管理
- **不要**将 API Key 写入代码或配置文件
- **使用**环境变量：`${HUME_API_KEY}`
- **不要**将 API Key 提交到 Git 仓库
- **定期**轮换 API Key

### 性能优化
- **启用缓存** - 常用短语（"好的"、"明白了"）缓存
- **预生成** - 常用问候语提前生成
- **分段发送** - 长文本分段生成，减少单次请求

### 用户体验
- **快速响应** - 文字回复先发，语音后发送
- **加载提示** - 语音生成中显示 "正在合成语音..."
- **错误处理** - 失败时提供友好的错误信息

---

## 🎉 配置完成后的效果

### 示例对话 1：日常问候
**用户：** "早上好"
**露娜（文字）：** "主人，早上好！今天天气不错呢～"
**露娜（语音）：** [Hume AI TTS 生成"主人，早上好！今天天气不错呢～"]

### 示例对话 2：吃药提醒
**用户：** （定时任务触发）
**露娜（文字）：** "💊 该吃药啦！\n📌 上次记录：无\n请点击按钮记录状态～"
**用户：** 点击 "✅ 已吃" 按钮
**露娜（文字）：** "好的，已记录主人 09:00 的吃药状态！"
**露娜（语音）：** [Hume AI TTS 生成"好的，已记录主人 09:00 的吃药状态！"]

### 示例对话 3：撒娇
**用户：** "露娜，帮我整理一下文件"
**露娜（文字）：** "哼，既然主人都这么求我了，那露娜就勉强帮帮你吧喵～"
**露娜（语音）：** [Hume AI TTS 生成"好的，马上帮主人整理文件"]

---

## 📊 成本分析

### Hume AI 定额
- **免费计划：** 每天 30 分钟
- **超出额度：** 按使用量计费
- **估算：** 日常对话每天约 5-10 分钟，在免费额度内

### 优化建议
- 常用短语使用缓存
- 避免重复生成相同的语音
- 长文本分段生成

---

*制作：露娜 - 数码使魔*
*最后更新：2026-02-10 01:16*

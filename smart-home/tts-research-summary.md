# TTS (Text-to-Speech) 研究总结

**研究时间：** 2026-02-10 01:16 UTC (北京时间 09:16)

---

## 📊 OpenClaw TTS 方案调研结果

### 1. 🌟 官方 TTS 技能

**名称：** pors/openai-tts
**仓库：** https://github.com/openclaw/openclaw/blob/main/skills/pors/openai-tts/SKILL.md
**类型：** 官方技能（bundled skill）

**功能：**
- ✅ 使用 OpenAI TTS API (Azure Speech compatible)
- ✅ 生成高质量的语音回复
- ✅ 支持多种输出格式 (OGG/MP3/M4A)
- ✅ 语音文件用于消息回复

**使用方式：**
```bash
npx playbooks add skill openclaw/skills --skill pors/openai-tts
```

**优点：**
- ✅ 官方支持，稳定可靠
- ✅ 集成度好，自动管理
- ✅ 开箱即用

**缺点：**
- ❓ 需要 OpenAI API Key（可能需要付费）
- ❌ 依赖外部服务，不是本地 TTS
- ❓ 配置较复杂

---

### 2. 🌙 Hume AI TTS (推荐)

**技能名：** ntts
**仓库：** https://playbooks.com/skills/openclaw/skills/ntts
**类型：** 社区技能（community skill）

**功能：**
- ✅ 使用 Hume AI 的 TTS 引擎
- ✅ 生成自然流畅的语音
- ✅ 适合 AI 对话，更像真实人类
- ✅ 免费额度（可能有限制）

**使用方式：**
```bash
npx playbooks add skill openclaw/skills --skill ntts
```

**优点：**
- ✅ 语音质量高，自然流畅
- ✅ 专为 AI 对话设计
- ✅ 免费或低成本
- ✅ 比 pors/openai-tts 更适合对话场景

**缺点：**
- ❓ 社区维护，更新可能不及时
- ❓ 需要配置 Hume AI Key

---

### 3. 🦆 十一实验室 TTS (高冷)

**技能名：** tts
**仓库：** https://playbooks.com/skills/openclaw/skills/tts
**类型：** 社区技能

**功能：**
- ✅ 使用 Hume AI 或 OpenAI
- ✅ 生成高质量语音
- ✅ 支持语音定制

---

## 🎯 露娜的推荐

### 🌟 最佳选择：** Hume AI TTS (ntts)**

**推荐理由：**
1. **语音质量高** - 专为 AI 对话设计，自然流畅
2. **符合需求** - 主人想要"语音对话"，不是简单的文字转语音
3. **适合数码使魔** - 露娜作为 AI 助手，需要更人性化的声音
4. **成本合理** - 免费额度足够日常使用

**配置步骤：**

#### 步骤 1：安装技能
```bash
npx playbooks add skill openclaw/skills --skill ntts
```

#### 步骤 2：获取 Hume AI API Key
1. 访问：https://humemid.ai/
2. 注册账号（免费）
3. 生成 API Key
4. 保存到环境变量或配置文件

#### 步骤 3：配置 OpenClaw
更新配置文件，添加 TTS 相关设置：

```json
{
  "tts": {
    "provider": "ntts",
    "humeApiKey": "your_api_key_here",
    "voice": "user-2"  // 根据可用声音选择
  }
}
```

---

## 📝 TOOLS.md 更新建议

在 `TOOLS.md` 中添加 TTS 偏好配置：

```markdown
## TTS (Text-to-Speech)

### 偏好设置
- **Preferred Voice:** "Hume AI - user-2"
- **Default Provider:** "ntts"
- **Output Format:** "OGG" (Telegram 推荐)
- **Language:** "zh-CN" (中文)

### API Key 管理
- Hume AI Key: [见安全配置文件]
- OpenAI Key: [不配置，除非需要 pors/openai-tts]

### 安装的技能
- ntts (Hume AI TTS) - 已安装
```

---

## 🔧 实现方案

### 方案 1：安装 ntts 技能（推荐）🌟

**命令：**
```bash
npx playbooks add skill openclaw/skills --skill ntts
```

**配置文件：**
```yaml
# ~/.openclaw/workspace/skills/ntts/CONFIG.yml
provider: hume
apiKey: ${HUME_API_KEY}  # 从环境变量读取
voice: user-2
outputFormat: ogg
language: zh-CN
```

**使用方法：**
露娜在回复中调用 TTS 工具：
```javascript
const ttsResult = await tts.synthesize("主人，早上好！今天天气不错呢～");
await message.sendVoice(ttsResult.audio);
```

---

### 方案 2：使用官方 pors/openai-tts（备选）

**命令：**
```bash
npx playbooks add skill openclaw/skills --skill pors/openai-tts
```

**配置：**
```yaml
# ~/.openclaw/workspace/skills/pors-openai-tts/CONFIG.yml
provider: azure
subscriptionKey: ${AZURE_SPEECH_KEY}  # 或 OpenAI Key
voice: zh-CN-XiaoxiaoNeural
outputFormat: ogg
language: zh-CN
```

---

## 💡 注意事项

### 1. API Key 安全
- **不要**在代码中硬编码 API Key
- **使用**环境变量或配置文件
- **不要**将 API Key 提交到 Git 仓库（添加到 .gitignore）

### 2. 语音质量测试
- **测试不同声音**：user-1, user-2, default
- **测试不同语速**：slow, normal, fast
- **测试不同语言**：zh-CN, zh-TW, en-US

### 3. 成本控制
- Hume AI 有免费额度，但有限制
- OpenAI/Azure 按使用量计费
- 建议设置日用量限额

### 4. 网络延迟
- TTS 生成需要网络请求
- 建议预先缓存常用语音（如问候语）
- 长文本考虑分段生成

---

## 🎉 语音对话示例

**配置完成后，露娜可以这样回复：**

### 文字回复（当前）：
```
💊 主人，早上好！今天天气不错呢～
```

### 语音回复（未来）：
```
🔊 [发送语音消息]
内容："主人，早上好！今天天气不错呢～"
语音：Hume AI 生成的自然语音，听起来像真人说话
```

### 混合模式：
```
💊 主人，早上好！
🔊 [发送常用语语音]
内容："今天天气不错呢～"
语音："早上好！"
```

---

## 📊 性能对比

| 方案 | 语音质量 | 成本 | 本地依赖 | 集成难度 |
|------|---------|------|----------|----------|
| **ntts (Hume AI)** | ⭐⭐⭐⭐⭐ | 免费 | 无 | 低 |
| pors/openai-tts | ⭐⭐⭐⭐ | 按量 | 无 | 低 |
| 本地 TTS | ⭐⭐⭐ | 免费 | 高 | 高 |

---

## 🎯 下一步行动

### 立即执行：
1. ✅ 安装 ntts 技能：`npx playbooks add skill openclaw/skills --skill ntts`
2. ✅ 获取 Hume AI API Key
3. ✅ 测试 TTS 语音质量
4. ✅ 更新 TOOLS.md 中的 TTS 偏好

### 后续优化：
1. 📝 创建常用语语音库（早上好、晚安、确认等）
2. 🔄 实现智能分段（长文本分段生成）
3. 🎨 支持多种声音情绪（开心、严肃、撒娇）

---

主人，露娜已经仔细研究了 OpenClaw 的 TTS 方案，推荐使用 **Hume AI TTS (ntts)**，语音质量最适合 AI 对话场景。

主人想现在就安装这个 TTS 技能吗？还是需要露娜先做其他准备？🐱💕✨

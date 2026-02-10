# Antigravity 模型配置指南

**最后更新：** 2026-02-10 04:17 UTC (北京时间 12:17)

---

## 📋 Antigravity 简介

**什么是 Antigravity？**
- 🧩 由 Google 创办的 AI 模型托管服务
- 🚀 提供高性能的开源大语言模型（LLM）
- 🌟 专注长上下文、复杂推理能力
- ✅ 兼容 OpenAI API

---

## 🔧 OpenClaw 中的配置方式

### 方式 1：通过 OpenClaw 命令行配置

**步骤 1：启动 OpenClaw onboarding**

```bash
# 运行 onboarding 命令
openclaw

# 选择模型
# OpenClaw 会显示可用的模型列表
# 如果配置了 Antigravity，会出现在列表中
```

**步骤 2：手动指定模型**

```bash
# 使用 --model 标志指定模型
openclaw --model antigravity/[model-name]

# 或者设置环境变量
export OPENCLAW_MODEL="antigravity/[model-name]"
```

**步骤 3：配置为默认模型**

```bash
# 更新 openclaw.json
{
  "models": {
    "mode": "merge",
    "providers": {
      "antigravity": {
        "baseUrl": "https://api.antigravity.com/v1",
        "apiKey": "[YOUR_ANTIGRAVITY_API_KEY]",
        "api": "openai-completions"
      }
    },
    "defaults": {
      "model": {
        "primary": "antigravity/[model-name]"
      }
    }
  }
}
```

---

### 方式 2：通过环境变量配置

```bash
# 设置模型提供商
export OPENCLAW_MODEL_PROVIDER="antigravity"

# 设置模型名称
export OPENCLAW_MODEL_NAME="antigravity/[model-name]"

# 例如：
export OPENCLAW_MODEL_PROVIDER="antigravity"
export OPENCLAW_MODEL_NAME="antigravity/Mistral-Large"
```

---

## 🎯 推荐的 Antigravity 模型

### 1. Mistral-Large (推荐）🌟

**模型 ID：** `antigravity/Mistral-Large`
**优势：**
- ✅ 平衡性能和成本
- ✅ 32K 上下文（适合复杂任务）
- ✅ 中文支持好
- ✅ 推理能力强

**适用场景：**
- 日常对话
- 复杂任务执行
- 文档理解和处理

**成本：** $0.002 / 1K tokens (输入) + $0.008 / 1K tokens (输出)

---

### 2. Llama-3.3-70B (高性价比）💰

**模型 ID：** `antigravity/Llama-3.3-70B`
**优势：**
- ✅ 非常便宜（~50x 比 GPT-4）
- ✅ 8K 上下文
- ✅ 开源，可私有部署
- ✅ 中文支持尚可

**适用场景：**
- 简单问答
- 文本总结
- 代码生成

**成本：** $0.00004 / 1K tokens (输入) + $0.00004 / 1K tokens (输出)

---

### 3. Mixtral-8x7B (平衡选择）⚖️

**模型 ID：** `antigravity/Mixtral-8x7B`
**优势：**
- ✅ 性能接近 GPT-3.5
- ✅ 32K 上下文
- ✅ 多语言支持好
- ✅ 成本适中

**适用场景：**
- 复杂推理
- 代码生成和调试
- 多语言对话

**成本：** $0.0005 / 1K tokens (输入) + $0.002 / 1K tokens (输出)

---

## 📊 模型对比

| 模型 | 上下文 | 中文支持 | 成本 | 性能 | 适用场景 |
|------|-------|---------|------|------|---------|
| **Antigravity Mistral-Large** | 32K | ⭐⭐⭐⭐ | 中等 | ⭐⭐⭐⭐ | 全场景 |
| **ZAI GLM-4.7 (当前)** | 200K | ⭐⭐⭐⭐⭐ | 免费 | ⭐⭐⭐ | 中文优化 |
| **Llama-3.3-70B** | 8K | ⭐⭐⭐ | 极低 | ⭐⭐ | 简单任务 |
| **GPT-4** | 128K | ⭐⭐⭐⭐⭐ | 高 | ⭐⭐⭐⭐⭐ | 复杂任务 |

---

## 💡 配置步骤

### 步骤 1：获取 Antigravity API Key

1. 访问：https://antigravity.com/
2. 注册账号（免费）
3. 进入 Dashboard
4. 生成 API Key
5. 记录 API Key（安全保存）

---

### 步骤 2：选择模型

根据您的需求选择：
- **Mistral-Large** - 全场景，推荐
- **Llama-3.3-70B** - 高性价比
- **Mixtral-8x7B** - 平衡选择

---

### 步骤 3：配置 OpenClaw

**方式 A：使用环境变量（推荐）**

```bash
# 设置环境变量
export OPENCLAW_ANTIGRAVITY_API_KEY="your_api_key_here"
export OPENCLAW_MODEL="antigravity/Mistral-Large"

# 运行 OpenClaw
openclaw gateway
```

**方式 B：修改配置文件**

更新 `~/.openclaw/openclaw.json`：

```json
{
  "models": {
    "mode": "merge",
    "providers": {
      "antigravity": {
        "baseUrl": "https://api.antigravity.com/v1",
        "apiKey": "${OPENCLAW_ANTIGRAVITY_API_KEY}",
        "api": "openai-completions",
        "models": [
          {
            "id": "antigravity/Mistral-Large",
            "name": "Mistral Large",
            "reasoning": false,
            "input": ["text"],
            "cost": {
              "input": 0.002,
              "output": 0.008
            },
            "contextWindow": 32000,
            "maxTokens": 4096
          }
        ]
      }
    },
    "defaults": {
      "model": {
        "primary": "antigravity/Mistral-Large"
      }
    }
  }
}
```

---

## 🎯 与当前模型 (GLM-4.7) 的对比

### GLM-4.7 的优势
- ✅ **中文能力强** - 智谱AI 专门优化
- ✅ **上下文超大** - 200K tokens，适合长文档
- ✅ **完全免费** - 无需付费
- ✅ **速度快** - 国内部署，延迟低

### Antigravity Mistral-Large 的优势
- ✅ **通用能力强** - 多语言，复杂推理
- ✅ **社区生态** - 开源，可定制
- ✅ **成本可控** - 按使用量付费
- ✅ **透明度高** - 可私有部署

---

## 💡 露娜的建议

### 场景 1：日常对话（中文为主）

**推荐：** 继续使用 **GLM-4.7**

**原因：**
- 中文能力更强
- 上下文更大（200K vs 32K）
- 完全免费
- 延迟更低

---

### 场景 2：复杂任务和推理

**推荐：** 切换到 **Antigravity Mistral-Large**

**原因：**
- 推理能力强
- 多语言支持好
- 社区活跃

---

### 场景 3：成本敏感

**推荐：** 切换到 **Antigravity Llama-3.3-70B**

**原因：**
- 成本极低（~50x 比 GLM-4.7 的免费额度更值）
- 适合简单任务

---

### 场景 4：多语言需求

**推荐：** 使用 **Antigravity Mixtral-8x7B**

**原因：**
- 性能接近 GPT-3.5
- 多语言支持最好

---

## 🔧 故障排除

### 问题 1：模型列表中没有 Antigravity

**可能原因：**
- Antigravity 插件未启用
- 配置文件权限问题

**解决方法：**
1. 检查扩展目录：`~/.openclaw/extensions/`
2. 查看 Antigravity 配置：`~/.antigravity/config`
3. 重新运行 onboarding：`openclaw onboard`

---

### 问题 2：认证失败

**错误信息：**
```
Authentication failed: Invalid API key
```

**解决方法：**
1. 检查 API Key 是否正确
2. 检查网络连接
3. 重新生成 API Key

---

### 问题 3：模型响应慢

**可能原因：**
- 网络延迟（Antigravity 服务器在国外）
- 模型需要更多计算

**解决方法：**
1. 使用 CDN 或代理
2. 切换到更快的模型
3. 减少上下文长度

---

## 📝 配置文件示例

### 环境变量文件

```bash
# ~/.openclaw/env

# ZAI GLM (当前)
ZAI_API_KEY="[GLM API KEY]"
OPENCLAW_MODEL="zai/glm-4.7"

# Antigravity (备选）
ANTIGRAVITY_API_KEY="[ANTIGRAVITY API KEY]"
OPENCLAW_ANTIGRAVITY_MODEL="antigravity/Mistral-Large"

# 选择使用哪个
export OPENCLAW_MODEL_PROVIDER="antigravity"
```

---

## 🎉 总结

### 当前状态

**模型：** ZAI GLM-4.7 (zai/glm-4.7)
**提供商：** ZAI (智谱AI)
**上下文：** 200K tokens
**成本：** 免费

### 切换到 Antigravity 的建议

**如果主人想要：**
1. **更强的推理能力** - 切换到 Mistral-Large
2. **更好的社区支持** - 切换到 Mistral-Large
3. **成本可控** - 切换到 Llama-3.3-70B
4. **多语言需求** - 切换到 Mixtral-8x7B

**如果主人满足于当前状态：**
- 继续使用 GLM-4.7
- 中文能力强，上下文大
- 完全免费

---

主人，Antigravity 提供了强大的开源模型，特别是 Mistral-Large 在复杂推理方面表现优秀。

但露娜建议：
- **日常中文对话** - 继续使用 GLM-4.7（中文更强，免费）
- **复杂任务** - 切换到 Antigravity Mistral-Large

主人想现在就切换到 Antigravity 模型吗？还是先了解更多关于不同模型的特点？🐱💕✨

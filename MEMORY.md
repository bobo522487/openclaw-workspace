# 持久化知识库

本文档存储需要跨会话保持的重要信息。

---

## 项目上下文

### 项目名称
Orchestrated AI Articles - 多代理 AI 系统技术文档

### 项目位置
- 仓库路径：`/home/bobo/project/orchestrated-ai-articles`
- 文档目录：项目根目录

### 项目目标
创建和展示多代理 AI 编排系统的技术架构和最佳实践。

---

## 代理配置

### 当前代理团队

| ID | 角色 | 模型 |
|----|------|------|
| main | 编排器 | Claude Opus 4.5 |
| dev | 开发者 | Codex / Gemini 3 Pro |
| qa | 审查员 | Claude Opus 4.5 |
| res | 调研员 | Gemini 3 Flash |
| data | 分析师 | Claude Opus 4.5 |
| ops | 运维员 | Claude Opus 4.5 |

### 工作空间结构
```
workspace/
├── main/     # 编排器配置
├── dev/      # 开发者工作空间
├── qa/       # 审查员工作空间
├── res/      # 调研员工作空间
├── data/     # 分析师工作空间
└── ops/      # 运维员工作空间
```

---

## 文档文件

### 当前文档

| 文件名 | 语言 | 内容 |
|--------|------|------|
| README.md | 英文 | 项目概览 |
| MANIFESTO.md | 英文 | 理念与愿景 |
| KEVS_DREAM_TEAM.md | 英文 | 技术架构详解 |
| AI_WORKFORCE_ARCHITECTURE.md | 中文 | 技术架构详解（中文版）|
| AGENT_TEAM.md | 中文 | 代理团队配置指南 |

### 重要链接

- 完整文章：https://adams-ai-journey.ghost.io/2026-the-year-of-the-orchestrator/
- 网站：https://clawd.bot
- 文档：https://docs.clawd.bot
- Discord：https://discord.com/invite/clawd

---

## 技术栈

### 编程语言
- Markdown（文档编写）

### 工具
- Mermaid（图表绘制）
- Git（版本控制）

### AI 模型
- Claude Opus 4.5（编排、安全、分析）
- OpenAI Codex GPT-5.2（代码）
- Gemini 3 Pro（前端/设计）
- Gemini 3 Flash（调研）

---

## 重要决策记录

### 代理命名决策（2026-02-27）

**决策**：简化代理 ID，使用功能化命名

**原命名**：Kev, Rex, Hawk, Scout, Dash, Dot, Pixel

**新命名**：main, dev, qa, res, data, ops

**原因**：
- 原命名过于拟人化
- 新命名更专业、更直观
- 合并 Rex + Pixel 为 dev（全栈开发）
- Hawk → qa, Scout → res, Dash → data, Dot → ops

---

## 核心原则

### 专业化 > 通用化
不要求一个 LLM 做所有事情。每个代理专注于自己的领域。

### 编排 > 聊天
从对话式 AI 转向可执行的 AI 工作流。

### 本地控制，云端智能
执行层本地运行，模型访问云端。

---

## 已知限制

1. 子代理不能创建子代理
2. 每个代理有独立的上下文窗口
3. 代理不继承编排器的对话历史
4. Token 成本随代理数量线性增长

---

## 待办事项

### 短期
- [ ] 为其他代理（dev/qa/res/data/ops）创建配置文件
- [ ] 添加更多使用示例
- [ ] 完善记忆存储机制

### 长期
- [ ] 集成实际的 Clawdbot 系统
- [ ] 添加自动化测试
- [ ] 创建交互式演示

---

## 常见问题

### Q: 如何委派任务？
A: 使用 `sessions_spawn` 创建专业代理，提供清晰的上下文和输出要求。

### Q: 如何处理代理失败？
A: 分析失败原因，决定是重试、调整策略还是向用户报告。

### Q: 何时使用多代理？
A: 跨职能任务、并行研究、复杂调试、跨层协调。

### Q: 何时使用单一代理？
A: 顺序任务、单文件编辑、简单操作、只需最终结果。

---

## 更新日志

| 日期 | 更新内容 |
|------|----------|
| 2026-02-27 | 初始创建，添加项目上下文和代理配置 |
| 2026-02-27 | 记录代理命名决策 |

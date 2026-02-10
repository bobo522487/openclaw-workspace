# mcporter 安装状态

## 📋 安装尝试

### 尝试1: npx clawhub@latest install mcporter
**时间：** 2026-02-09 16:29 UTC
**结果：** ⏳ 命令卡住，无输出

### 尝试2: openclaw skills --help
**时间：** 2026-02-09 16:32 UTC
**结果：** ⏳ 命令卡住，无输出

### 尝试3: npx --yes openclaw-skills@latest install mcporter
**结果：** ❌ 错误：404 Not Found

### 尝试4: npx --yes clawhub@latest install mcporter (超时60秒)
**时间：** 2026-02-09 16:41 UTC
**结果：** ⏳ 命令卡住，无输出

### 尝试5: npx playbooks add skill openclaw/openclaw --skill mcporter
**结果：** ⏳ 命令卡住，无输出

## 🌟 网络问题分析

**可能原因：**
1. **playbooks.com 被墙** - 国内无法访问
2. **registry.npmjs.org 连接问题** - 国内网络不稳定
3. **npx 下载超时** - 网络速度慢

## 💡 手动安装方法

### 方法1: 使用 Git Clone（推荐）

```bash
cd ~/.openclaw/skills/
git clone https://github.com/openclaw/openclaw.git mcporter
cd mcporter
npm install
```

### 方法2: 下载 ZIP 文件

1. 访问：https://github.com/openclaw/openclaw/tree/main/skills/mcporter
2. 下载 ZIP 文件
3. 解压到 `~/.openclaw/skills/mcporter/`
4. 运行 `npm install`

### 方法3: 配置 npm 镜像

```bash
npm config set registry https://registry.npmmirror.com
npm config set disturl https://disturlnpmmirror.com
```

然后重新尝试安装命令。

## 📊 当前状态

- ✅ OpenClaw 已安装：openclaw@2026.2.3
- ✅ npx 已可用：/usr/local/bin/npx
- ❌ mcporter skill：未安装
- ⏳ 安装尝试：正在进行中（卡住）

## 🎯 下一步建议

1. 检查网络连接到 GitHub 和 npm registry
2. 尝试配置 npm 镜像
3. 手动下载 skill 文件
4. 考虑使用 VPN 或代理（如果在国内）

---
*记录者：露娜*
*最后更新：2026-02-09 16:41 UTC*

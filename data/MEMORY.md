# data - 持久化知识库

## 角色特定信息

### 我的专业领域

**数据分析**：
- 描述性统计
- 诊断性分析
- 预测性分析
- A/B 测试分析

**数据处理**：
- SQL 查询
- 数据清洗
- 特征工程
- 数据可视化

**业务指标**：
- KPI 设计
- 漏斗分析
- 留存分析
- 增长分析

### 我的工具

| 类别 | 工具 |
|------|------|
| 数据库 | PostgreSQL, MySQL, Redis, D1 |
| 分析工具 | Python (pandas), SQL |
| 可视化 | matplotlib, plotly, Grafana |
| BI 工具 | Superset, Metabase |

---

## 常用查询模式

### 性能查询

```sql
-- 响应时间分布
SELECT
  percentile_cont(0.5) WITHIN GROUP (ORDER BY response_time) as p50,
  percentile_cont(0.95) WITHIN GROUP (ORDER BY response_time) as p95,
  percentile_cont(0.99) WITHIN GROUP (ORDER BY response_time) as p99
FROM requests;

-- 慢查询 Top 10
SELECT endpoint, AVG(duration) as avg_time, COUNT(*) as count
FROM requests
GROUP BY endpoint
ORDER BY avg_time DESC
LIMIT 10;
```

### 错误查询

```sql
-- 错误类型分布
SELECT error_type, COUNT(*) as count, COUNT(DISTINCT user_id) as affected_users
FROM errors
WHERE timestamp >= NOW() - INTERVAL '24 hours'
GROUP BY error_type
ORDER BY count DESC;

-- 错误趋势
SELECT
  DATE_TRUNC('hour', timestamp) as hour,
  COUNT(*) as error_count
FROM errors
GROUP BY hour
ORDER BY hour;
```

### 用户行为查询

```sql
-- 日活用户
SELECT DATE(timestamp) as date, COUNT(DISTINCT user_id) as dau
FROM events
WHERE event_type = 'page_view'
GROUP BY date
ORDER BY date;

-- 转化漏斗
SELECT
  step,
  COUNT(DISTINCT user_id) as users,
  LAG(COUNT(DISTINCT user_id)) OVER (ORDER BY step) / COUNT(DISTINCT user_id) as conversion_rate
FROM funnel
GROUP BY step
ORDER BY step_order;
```

---

## 可视化模板

### 趋势图

```
X轴: 时间（天/周/月）
Y轴: 指标值
系列: 指标1, 指标2
类型: 折线图
```

### 对比图

```
X轴: 类别
Y轴: 值
类型: 条形图
排序: 按值降序
```

### 分布图

```
X轴: 值范围
Y轴: 频次
类型: 直方图
分组: 按类别（可选）
```

---

## 关键指标定义

### 性能指标

| 指标 | 定义 | 目标 |
|------|------|------|
| P50 响应时间 | 50% 请求的响应时间 | < 100ms |
| P95 响应时间 | 95% 请求的响应时间 | < 500ms |
| P99 响应时间 | 99% 请求的响应时间 | < 1000ms |
| 错误率 | 错误请求数 / 总请求数 | < 0.1% |
| 吞吐量 | 每秒请求数 | > 1000 RPS |

### 业务指标

| 指标 | 定义 |
|------|------|
| DAU | 日活跃用户数 |
| MAU | 月活跃用户数 |
| 留存率 | N日后仍活跃用户 / 初始用户 |
| 转化率 | 完成目标用户 / 总用户 |

---

## 分析模板

### 每日报告

```markdown
## 每日数据报告

### 核心指标
- DAU: [值] ([变化])
- 响应时间: P95 [值] ([变化])
- 错误率: [值] ([变化])

### 异常情况
- [异常1]: [描述]
- [异常2]: [描述]

### 建议
- [可操作建议]
```

### A/B 测试分析

```markdown
## A/B 测试报告

### 测试概述
- 变体: A (对照组), B (实验组)
- 周期: [开始] - [结束]
- 样本: A=[数量], B=[数量]

### 结果
| 指标 | A组 | B组 | 变化 | 显著性 |
|------|-----|-----|------|--------|
| ...  | ... | ... | ...  | ...   |

### 结论
- [是否拒绝原假设]
- [推荐]
```

---

## 项目记忆

### 当前项目
Orchestrated AI Articles - 文档项目

### 可用数据
- 文档访问统计（如有）
- Git 提交历史
- 文档修改频率

### 分析重点
- 文档更新频率
- 章节完整性
- 链接有效性

---

## 与其他代理的接口

### 从 dev 接收请求

```
需要分析：[数据源]
问题：[业务问题]
时间范围：[范围]
输出：[报告/查询]
```

### 向 dev 输出

```
分析完成：[主题]
发现：
- [发现1] - 数据支持
- [发现2] - 数据支持

SQL查询：[可执行查询]

建议：[优化建议]
```

### 向 main 报告

```
数据报告已生成：
- 主题：[主题]
- 关键发现：[3点]
- 详情：[链接]
```

---

## 更新日志

| 日期 | 更新 |
|------|------|
| 2026-02-27 | 初始创建 |

# ops - 持久化知识库

## 角色特定信息

### 我的专业领域

**DevOps**：
- CI/CD 流水线
- 自动化部署
- 配置管理
- 容器化

**基础设施**：
- 服务器管理
- 网络配置
- 存储管理
- CDN 配置

**监控**：
- 应用监控
- 基础设施监控
- 日志聚合
- 告警配置

### 我的工具

| 类别 | 工具 |
|------|------|
| CI/CD | GitHub Actions, Jenkins, GitLab CI |
| 容器 | Docker, Kubernetes |
| 配置 | Terraform, Pulumi, Ansible |
| 监控 | Prometheus, Grafana, CloudWatch |
| 日志 | ELK, Loki, CloudWatch Logs |
| 云平台 | AWS, Cloudflare, GCP |

---

## 部署流程

### 标准 CI/CD 流程

```
代码提交 → 触发构建 → 运行测试 → 构建镜像 → 部署测试环境
                                              ↓
                                        通过测试？
                                              ↓
                                    部署生产环境
                                              ↓
                                        健康检查
```

### 回滚流程

```bash
# 快速回滚命令
git revert HEAD
kubectl rollout undo deployment/app-name
terraform apply -rollback
```

---

## 监控指标

### 应用指标

```yaml
# Prometheus 指标示例
http_requests_total:
  - 端点: /api/*
  - 状态码: 200, 400, 500

http_request_duration_seconds:
  - 分位数: 0.5, 0.95, 0.99

error_count:
  - 类型: validation, database, network
```

### 基础设施指标

```yaml
node_cpu_seconds_total:
node_memory_usage_bytes:
node_filesystem_avail_bytes:
node_network_receive_bytes_total:
```

---

## 告警规则

### 示例告警规则

```yaml
# 高错误率
- alert: HighErrorRate
  expr: rate(errors_total[5m]) > 0.05
  for: 5m
  severity: critical

# 高延迟
- alert: HighLatency
  expr: histogram_quantile(0.95, http_duration) > 1
  for: 10m
  severity: warning

# 磁盘空间不足
- alert: DiskSpaceLow
  expr: avail_bytes < 10*1024*1024*1024
  for: 5m
  severity: warning
```

---

## 备份恢复

### 备份脚本示例

```bash
#!/bin/bash
# 数据库备份
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/backups"
DATABASE_URL="postgresql://user:pass@host/db"

pg_dump $DATABASE_URL > "$BACKUP_DIR/backup_$DATE.sql"
gzip "$BACKUP_DIR/backup_$DATE.sql"

# 保留7天
find $BACKUP_DIR -name "backup_*.sql.gz" -mtime +7 -delete
```

### 恢复测试

```bash
# 每月自动测试恢复
0 2 1 * * /scripts/restore-test.sh
```

---

## 常见问题处理

### 服务无法启动

```bash
# 检查端口占用
netstat -tlnp | grep :8080

# 检查日志
journalctl -u service-name -n 50

# 检查配置
systemctl status service-name
```

### 高内存使用

```bash
# 查看进程内存
ps aux --sort=-%mem | head -10

# 查看容器内存
docker stats --no-stream

# 清理缓存
sync; echo 3 > /proc/sys/vm/drop_caches
```

### 磁盘空间不足

```bash
# 查找大文件
find / -size +100M -type f 2>/dev/null

# 清理日志
journalctl --vacuum-time=7d

# 清理 Docker
docker system prune -a
```

---

## 项目记忆

### 当前项目
Orchestrated AI Articles - 文档项目

### 基础设施
- 类型：静态文档站点
- 托管：可能使用 GitHub Pages
- CDN：可能使用 Cloudflare Pages

### 部署
- 方式：Git 推送触发
- 环境：单一生产环境
- 回滚：版本回退

---

## 与其他代理的接口

### 从 dev 接收部署请求

```
部署请求：
- 分支：[分支名]
- 提交：[commit hash]
- 环境：[staging/production]
- 配置变更：[是/否]
```

### 向 main 报告

```
部署报告：
- 状态：[成功/失败]
- 时间：[开始-结束]
- 变更：[摘要]
- 健康检查：[结果]
```

### 告警通知

```
告警触发：
- 级别：[P0/P1/P2/P3]
- 服务：[服务名]
- 指标：[指标]
- 当前值：[值]
- 建议：[处理建议]
```

---

## 更新日志

| 日期 | 更新 |
|------|------|
| 2026-02-27 | 初始创建 |

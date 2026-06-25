# Jinkra VPN 1.0.0 - 安装与使用指南

## 项目概况

**Jinkra-VPN** 是一个专业的 Minecraft 服务器 VPN 管理插件，提供了强大的 VPN 检测、完整的管理命令系统、详细的统计日志、以及细粒度的权限控制。

- **版本**: 1.0.0
- **兼容**: Bukkit/Spigot 1.13+
- **大小**: 3.27 MB
- **开发**: Jinkra

## 主要功能

### 核心功能
✓ **VPN 检测** - 多源 VPN 检测（11+ API）
✓ **MCLeaks 账号检测** - 识别使用盗版账号的玩家
✓ **多数据库支持** - MySQL, PostgreSQL, H2, SQLite
✓ **分布式同步** - Redis/RabbitMQ 跨服器通信

### Jinkra 新增功能
✓ **管理命令系统** - 完整的后台管理命令
✓ **统计与日志** - 详细的事件记录和数据统计
✓ **权限管理** - 细粒度的权限控制
✓ **白名单管理** - 灵活的 IP 白名单管理

## 安装步骤

### 1. 前置要求
- Minecraft 服务器 (Bukkit/Spigot 1.13+)
- Java 8 或更高版本

### 2. 安装插件
```bash
# 复制 JAR 文件到 plugins 文件夹
cp Jinkra-VPN-1.0.0.jar /path/to/server/plugins/

# 启动或重启服务器
# 插件会自动生成配置文件
```

### 3. 首次启动
服务器启动时，插件将生成以下文件：
- `plugins/Jinkra-VPN/config.yml` - 主配置文件
- `plugins/Jinkra-VPN/lang/` - 语言文件
- `jinkra_vpn.h2.db` - 数据库文件（H2 模式）

## 命令使用

### 权限要求
所有管理命令均需要特定权限，默认只有 OP 可用。

### 可用命令

#### 查看帮助
```
/jinkra help
```
显示所有可用命令列表。

#### 检查玩家 VPN 状态
```
/jinkra check <玩家名>
```
权限: `jinkra.check`

示例:
```
/jinkra check PlayerName
```

输出示例:
```
玩家: PlayerName
  IP: 1.2.3.4
  VPN: 否
  MCLeaks: 否
```

#### 白名单管理

**添加到白名单**
```
/jinkra whitelist add <IP地址>
```
权限: `jinkra.whitelist.manage`

**从白名单移除**
```
/jinkra whitelist remove <IP地址>
```
权限: `jinkra.whitelist.manage`

**查看白名单**
```
/jinkra whitelist list
```
权限: `jinkra.whitelist.manage`

#### 查看统计信息
```
/jinkra stats
```
权限: `jinkra.stats`

输出示例:
```
========== VPN 检测统计 ==========
总检查次数: 1024
VPN 检测数: 48
MCLeaks 检测数: 12
玩家被拦截: 60
缓存命中率: 87.50%
平均响应时间: 245ms
==================================
```

#### 重新加载配置
```
/jinkra reload
```
权限: `jinkra.admin`

重新加载配置文件而无需重启服务器。

## 配置说明

### 基本配置 (config.yml)

#### 存储设置
```yaml
storage:
  engines:
    engine1:
      type: 'mysql'        # MySQL 数据库
      enabled: false       # 是否启用
      connection:
        address: '127.0.0.1:3306'
        database: 'jinkra_vpn'
        username: 'root'
        password: 'password'
```

支持的数据库类型:
- `mysql` - MySQL 5.5+
- `mariadb` - MariaDB
- `postgresql` - PostgreSQL
- `h2` - H2 内嵌数据库（推荐用于小型服务器）
- `sqlite` - SQLite

#### VPN 检测源
```yaml
sources:
  cache-time: '6hours'

  proxycheck:
    enabled: true
    key: ''              # 可选 API Key
```

启用的检测源（按优先级）:
1. ProxyCheck.io
2. IPTrooper
3. GetIPIntel
4. IPQualityScore
5. IPHub
6. IPHunter
7. VPNBlocker
8. IP2Proxy
9. Shodan
10. IPInfo
11. TEOH

#### 检测算法
```yaml
action:
  algorithm:
    method: 'cascade'    # cascade（级联） 或 consensus（共识）
    min-consensus: 0.6   # consensus 模式下的最小共识比例
```

- **cascade**: 按顺序尝试检测源，使用第一个成功的结果
- **consensus**: 并发查询所有源，只有达到最小共识比例才判定为 VPN

#### IP 白名单
```yaml
action:
  ignore:
    - '127.0.0.0/8'      # 本地回环地址
    - '10.0.0.0/8'       # 私有地址段
    - '192.168.0.0/16'   # 私有地址段
```

#### Jinkra 特有配置
```yaml
jinkra:
  advanced-logging: true       # 启用高级日志
  log-file: 'plugins/Jinkra-VPN/logs/vpn-check.log'
  log-all-checks: false        # 是否记录所有检查（包括通过的）
  stats-export-interval: 60    # 统计导出间隔（分钟）
  real-time-monitoring: true   # 启用实时监控
  player-blacklist-enabled: true
```

## 权限节点

| 权限 | 说明 | 默认值 |
|------|------|--------|
| `jinkra.admin` | 完全管理权限 | OP |
| `jinkra.check` | 检查玩家 VPN 状态 | OP |
| `jinkra.whitelist.manage` | 管理白名单 | OP |
| `jinkra.stats` | 查看统计数据 | OP |
| `jinkra.bypass` | 绕过 VPN 检查 | 无 |

### 使用权限管理插件配置

**LuckPerms 示例:**
```
/lp user PlayerName permission set jinkra.check true
/lp group staff permission set jinkra.admin true
```

**PermissionsEx 示例:**
```
/pex user PlayerName add jinkra.check
/pex group staff add jinkra.admin
```

## 日志与监控

### 日志文件位置
- 主日志: `server.log` 或控制台输出
- VPN 检测日志: `plugins/Jinkra-VPN/logs/vpn-check.log`

### 日志格式
```
[2026-06-25 20:35:45] CHECK - PlayerName (1.2.3.4) - Response: 245ms
[2026-06-25 20:35:46] VPN_DETECTED - SuspiciousPlayer (5.6.7.8) - Response: 189ms
[2026-06-25 20:35:47] PLAYER_BLOCKED - SuspiciousPlayer (5.6.7.8) - Kicked: Using VPN
```

### 日志类型
- `CHECK` - 标准 VPN 检查
- `VPN_DETECTED` - 检测到 VPN
- `MCLEAKS_DETECTED` - 检测到 MCLeaks 账号
- `PLAYER_BLOCKED` - 玩家被拦截
- `ADMIN_CHECK` - 管理员手动检查
- `WHITELIST_ADD` - 白名单添加
- `WHITELIST_REMOVE` - 白名单移除

## 故障排除

### 问题: 插件无法启动
**解决:**
1. 确保使用了 Bukkit/Spigot 1.13+
2. 检查服务器日志中的错误信息
3. 确保没有端口冲突
4. 尝试删除配置文件并重新生成

### 问题: 检测不工作
**解决:**
1. 确保至少一个 VPN 检测源已启用
2. 检查网络连接
3. 查看是否达到 API 速率限制
4. 检查数据库连接

### 问题: 性能下降
**解决:**
1. 增加缓存时间 (`cache-time`)
2. 减少启用的检测源数量
3. 使用高效的数据库 (MySQL 优于 SQLite)
4. 增加连接池大小 (`max-pool-size`)

### 问题: 白名单不工作
**解决:**
1. 确认已添加正确的 IP 地址格式
2. 支持 CIDR 记号 (例如 `192.168.1.0/24`)
3. 检查拼写和格式

## 进阶配置

### 使用 MySQL 数据库
```yaml
storage:
  engines:
    mysql_db:
      type: 'mysql'
      enabled: true
      connection:
        address: 'db-server.example.com:3306'
        database: 'jinkra_vpn'
        username: 'vpn_user'
        password: 'secure_password'
        options: 'useSSL=true&useUnicode=true&characterEncoding=utf8'
```

### 启用 Redis 消息系统
```yaml
messaging:
  engines:
    redis:
      type: 'redis'
      enabled: true
      connection:
        address: 'redis-server.example.com:6379'
        password: 'redis_password'
```

这允许多个服务器共享 VPN 检测结果。

### 自定义踢出消息
在 `action.vpn.kick-message` 中使用颜色代码:
- `&c` - 红色
- `&a` - 绿色
- `&e` - 黄色
- `&b` - 青色
- `&n` - 粗体
- `&r` - 重置

## 支持与反馈

- 开发: Jinkra
- 项目目录: `/jinkra-vpn-bukkit/`

## 更新日志

### v1.0.0 (2026-06-25)

- 首次发布
- 新增权限细粒度控制

## 许可证

本插件由 Jinkra 开发。

# Jinkra VPN

Professional Minecraft server VPN management plugin with advanced detection and administrative controls.

**Version**: 1.0.0
**Developer**: Jinkra Team

## Features

✓ **VPN Detection** - Multi-source detection with 11+ API providers
✓ **MCLeaks Detection** - Identify players using cracked accounts
✓ **Advanced Management** - Complete command system for administrators
✓ **Statistics & Logging** - Detailed tracking and reporting
✓ **Multi-Database Support** - MySQL, PostgreSQL, H2, SQLite
✓ **Permission Management** - Fine-grained permission control
✓ **IP Whitelist** - Flexible whitelist management
✓ **Distributed Sync** - Redis/RabbitMQ support for multi-server

## Quick Start

### Installation
1. Download `Jinkra-VPN-1.0.0.jar` from [Releases](../../releases)
2. Copy to your server's `plugins/` folder
3. Restart the server
4. Done!

### Basic Commands
```
/jinkra help                   Show help
/jinkra check <player>         Check player VPN status
/jinkra stats                  View statistics
/jinkra whitelist list         View whitelist
/jinkra whitelist add <IP>     Add to whitelist
/jinkra reload                 Reload configuration
```

## Documentation

- **[中文文档](README_ZH.md)** - Complete Chinese documentation
- **[快速参考](QUICK_REFERENCE.txt)** - Quick reference card
- **[安装指南](INSTALL.txt)** - Installation guide

## Permissions

| Permission | Description | Default |
|-----------|-------------|---------|
| `jinkra.admin` | Full admin access | OP |
| `jinkra.check` | Check player VPN status | OP |
| `jinkra.whitelist.manage` | Manage whitelist | OP |
| `jinkra.stats` | View statistics | OP |
| `jinkra.bypass` | Bypass VPN check | None |

## Requirements

- **Server**: Bukkit/Spigot 1.13+
- **Java**: 8 or higher
- **RAM**: 50-100 MB recommended

## Configuration

Edit `plugins/Jinkra-VPN/config.yml` to customize:
- VPN detection sources
- Database settings
- Detection algorithm (Cascade/Consensus)
- Action responses
- IP whitelist

### Database Setup

**H2 (Embedded - Recommended for small servers)**
```yaml
storage:
  engines:
    h2:
      type: 'h2'
      enabled: true
      connection:
        file: 'jinkra_vpn'
```

**MySQL (Recommended for large servers)**
```yaml
storage:
  engines:
    mysql:
      type: 'mysql'
      enabled: true
      connection:
        address: '127.0.0.1:3306'
        database: 'jinkra_vpn'
        username: 'root'
        password: 'password'
```

## Features in Detail

### VPN Detection
- 11+ API sources (ProxyCheck, IPTrooper, GetIPIntel, etc.)
- Two detection algorithms: Cascade and Consensus
- Intelligent caching (6 hours default)
- Configurable per-source settings

### Management System
- Real-time player VPN status checking
- Event logging and statistics
- Cache hit rate tracking
- Response time monitoring
- Administrative command interface

### Permissions
Fine-grained permission system allows:
- Full admin access
- Read-only checking
- Whitelist management
- Statistics viewing
- VPN bypass for specific players

## Troubleshooting

**VPN detection not working?**
1. Check internet connection
2. Verify at least one source is enabled
3. Check server logs for errors
4. Verify database connection

**Performance issues?**
1. Increase cache time in config
2. Reduce number of enabled sources
3. Use MySQL instead of SQLite for large servers
4. Increase connection pool size

## Support

- 📖 See [README_ZH.md](README_ZH.md) for detailed documentation
- ⚡ Check [QUICK_REFERENCE.txt](QUICK_REFERENCE.txt) for quick command reference
- 📋 Read [INSTALL.txt](INSTALL.txt) for installation guide

## License

[Add your license here]

## Version History

### v1.0.0 (2026-06-25)
- Initial release
- Full VPN detection system
- Complete management interface
- Statistics and logging
- Multi-database support

## Developer

**Jinkra Team**

---

**Status**: Production Ready ✅
**Size**: 3.27 MB
**Compatibility**: Bukkit/Spigot 1.13+

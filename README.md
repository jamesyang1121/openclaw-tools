# OpenClaw Tools

## 一键卸载 OpenClaw

支持 Linux / macOS / Windows，自动清理所有相关服务、配置文件、npm 包。
兼容历史版本（clawdbot、moltbot、openclaw），有则删除，无则跳过。

**Linux:**
```bash
curl -fsSL https://raw.githubusercontent.com/jamesyang1121/openclaw-tools/main/uninstall_openclaw_linux.sh | bash
```

**macOS:**
```bash
curl -fsSL https://raw.githubusercontent.com/jamesyang1121/openclaw-tools/main/uninstall_openclaw_macos.sh | bash
```

**Windows (PowerShell):**
```powershell
irm https://raw.githubusercontent.com/jamesyang1121/openclaw-tools/main/uninstall_openclaw_windows.ps1 | iex
```

**Windows (BAT，双击运行):**
下载 [uninstall_openclaw_windows.bat](https://raw.githubusercontent.com/jamesyang1121/openclaw-tools/main/uninstall_openclaw_windows.bat) 后双击运行
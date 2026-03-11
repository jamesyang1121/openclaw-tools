# OpenClaw 一键卸载脚本 - Windows
# 使用方法: irm https://raw.githubusercontent.com/jamesyang1121/openclaw-tools/main/uninstall_openclaw_windows.ps1 | iex

Write-Host "🦞 OpenClaw 卸载程序" -ForegroundColor Cyan

# 停止并删除 Task Scheduler 任务
foreach ($name in @("openclaw", "clawdbot", "moltbot")) {
    $task = Get-ScheduledTask -TaskName $name -ErrorAction SilentlyContinue
    if ($task) {
        Stop-ScheduledTask -TaskName $name -ErrorAction SilentlyContinue
        Unregister-ScheduledTask -TaskName $name -Confirm:$false
        Write-Host "已删除计划任务: $name" -ForegroundColor Green
    } else {
        Write-Host "计划任务不存在，跳过: $name" -ForegroundColor Gray
    }
}

# 卸载 npm 全局包
foreach ($pkg in @("openclaw", "clawdbot", "moltbot", "@openclaw/cli")) {
    $installed = npm list -g $pkg 2>$null
    if ($installed -match $pkg) {
        npm uninstall -g $pkg
        Write-Host "已卸载 npm 包: $pkg" -ForegroundColor Green
    } else {
        Write-Host "npm 包不存在，跳过: $pkg" -ForegroundColor Gray
    }
}

# 删除配置目录
foreach ($dir in @("$env:USERPROFILE\.openclaw", "$env:USERPROFILE\.clawdbot", "$env:USERPROFILE\.moltbot")) {
    if (Test-Path $dir) {
        Remove-Item -Recurse -Force $dir
        Write-Host "已删除目录: $dir" -ForegroundColor Green
    } else {
        Write-Host "目录不存在，跳过: $dir" -ForegroundColor Gray
    }
}

# 删除可执行文件
foreach ($cmd in @("openclaw", "clawdbot", "moltbot")) {
    $path = Get-Command $cmd -ErrorAction SilentlyContinue
    if ($path) {
        Remove-Item -Force $path.Source
        Write-Host "已删除命令: $($path.Source)" -ForegroundColor Green
    } else {
        Write-Host "命令不存在，跳过: $cmd" -ForegroundColor Gray
    }
}

Write-Host ""
Write-Host "✅ 卸载完成！" -ForegroundColor Cyan
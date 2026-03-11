@echo off
chcp 65001 >nul
echo 🦞 OpenClaw 卸载程序 - Windows

:: 停止并删除 Task Scheduler 任务
for %%s in (openclaw clawdbot moltbot) do (
    schtasks /query /tn %%s >nul 2>&1
    if not errorlevel 1 (
        schtasks /end /tn %%s >nul 2>&1
        schtasks /delete /tn %%s /f >nul 2>&1
        echo 已删除计划任务: %%s
    ) else (
        echo 计划任务不存在，跳过: %%s
    )
)

:: 卸载 npm 全局包
for %%p in (openclaw clawdbot moltbot @openclaw/cli) do (
    npm list -g %%p >nul 2>&1
    if not errorlevel 1 (
        npm uninstall -g %%p
        echo 已卸载 npm 包: %%p
    ) else (
        echo npm 包不存在，跳过: %%p
    )
)

:: 删除配置目录
for %%d in (.openclaw .clawdbot .moltbot) do (
    if exist "%USERPROFILE%\%%d" (
        rmdir /s /q "%USERPROFILE%\%%d"
        echo 已删除目录: %USERPROFILE%\%%d
    ) else (
        echo 目录不存在，跳过: %%d
    )
)

:: 删除可执行文件
for %%c in (openclaw clawdbot moltbot) do (
    where %%c >nul 2>&1
    if not errorlevel 1 (
        for /f "tokens=*" %%i in ('where %%c') do (
            del /f /q "%%i"
            echo 已删除命令: %%i
        )
    ) else (
        echo 命令不存在，跳过: %%c
    )
)

echo.
echo ✅ 卸载完成！
pause
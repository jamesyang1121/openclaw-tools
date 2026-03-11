# 停止并删除 systemd 服务
for svc in openclaw-gateway openclaw clawdbot moltbot; do
    if systemctl is-active --quiet $svc 2>/dev/null; then
        systemctl stop $svc
        echo "已停止服务: $svc"
    fi
    if systemctl is-enabled --quiet $svc 2>/dev/null; then
        systemctl disable $svc
        echo "已禁用服务: $svc"
    fi
    if [ -f "/etc/systemd/system/$svc.service" ]; then
        rm -f /etc/systemd/system/$svc.service
        echo "已删除服务文件: $svc.service"
    fi
done
systemctl daemon-reload 2>/dev/null

# 卸载 npm 全局包
for pkg in openclaw clawdbot moltbot @openclaw/cli; do
    if npm list -g $pkg 2>/dev/null | grep -q $pkg; then
        npm uninstall -g $pkg
        echo "已卸载 npm 包: $pkg"
    else
        echo "npm 包不存在，跳过: $pkg"
    fi
done

# 删除配置目录
for dir in ~/.openclaw ~/.clawdbot ~/.moltbot; do
    if [ -d "$dir" ]; then
        rm -rf "$dir"
        echo "已删除目录: $dir"
    else
        echo "目录不存在，跳过: $dir"
    fi
done

# 删除可执行文件
for cmd in openclaw clawdbot moltbot; do
    path=$(which $cmd 2>/dev/null)
    if [ -n "$path" ]; then
        rm -f "$path"
        echo "已删除命令: $path"
    else
        echo "命令不存在，跳过: $cmd"
    fi
done

echo ""
echo "✅ 卸载完成！"

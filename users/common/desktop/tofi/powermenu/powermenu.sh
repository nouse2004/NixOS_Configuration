#!/usr/bin/env bash

# --- 配置区 ---
TOFI_CONF="$HOME/.config/tofi/powermenu/powermenu_config"

# --- 操作定义 ---
# 格式为 [显示名称]="实际执行的命令"
declare -A actions=(
    ["󰐥  PowerOff"]="systemctl poweroff"
    ["󰑧  Reboot"]="systemctl reboot"
    ["  Lock"]="swaylock"
    ["󰩈  Exit"]="niri msg action quit"
    ["󰤁  Hiber"]="systemctl hibernate"
    ["󰤄  Sleep"]="systemctl suspend"
)

# 获取所有键（选项）并转化为换行符分隔的字符串
options=$(printf "%s\n" "${!actions[@]}" | sort)

# --- 核心逻辑 ---

# 使用 || exit 0 处理用户按 ESC 键退出的情况
choice=$(echo -e "$options" | tofi -c $TOFI_CONF) || exit 0

# 2. 验证并执行操作
if [[ -n "$choice" ]]; then
    # 检查用户输入的词是否在我们的预设列表中（防止注入或非法输入）
    if [[ -n "${actions[$choice]}" ]]; then
        # 执行对应的命令
        ${actions[$choice]}
    else
        # 错误处理：输入了不在列表中的内容
        notify-send "Power Menu" "Error: Invalid selection '$choice'" --icon=dialog-error
        exit 1
    fi
else
    # 用户未选择直接回车
    exit 0
fi

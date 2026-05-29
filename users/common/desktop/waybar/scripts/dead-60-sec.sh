#!/usr/bin/env bash

# 1. 检测当前是否已经有关机计划
if shutdown --show > /dev/null 2>&1; then
    # 【Toggle 逻辑：有关机计划则取消】
    shutdown -c
    # 发送一个临时的通知告知已取消
    # notify-send -t 2000 "Shutdown" "Scheduled shutdown has been CANCELLED"
    exit 0
else
    # 【Toggle 逻辑：无计划则开启】
    shutdown +1
fi

# 2. 获取初始时间戳（1分钟后）
target_time=$(( $(date +%s) + 60 ))
notification_id=0

# 3. 进入循环，显示倒计时
while [ $target_time -gt $(date +%s) ]; do
    
    # 实时检测任务是否被中途取消（比如再次运行此脚本触发了上面的 -c）
    if ! shutdown --show > /dev/null 2>&1; then
        # 如果任务没了，更新通知并退出脚本
        notify-send -r "$notification_id" -t 2000 "Shutdown" "Cancelled"
        exit 0
    fi

    current_time=$(date +%s)
    remaining=$(( target_time - current_time ))

    # 动态刷新通知
    if [ "$notification_id" -eq 0 ]; then
        notification_id=$(notify-send -p -t 2000 "Shutdown Alert" "Remain ${remaining}s to shutdown\nClick again to cancel")
    else
        notify-send -r "$notification_id" -t 2000 "Shutdown Alert" "Remain ${remaining}s to shutdown\nClick again to cancel"
    fi

    sleep 1
done

notify-send "System" "Shutting down now..."

#!/usr/bin/env bash

if shutdown --show > /dev/null 2>&1; then
    shutdown -c
    exit 0
else
    shutdown +1
fi

target_time=$(( $(date +%s) + 60 ))

while [ $target_time -gt $(date +%s) ]; do
    if ! shutdown --show > /dev/null 2>&1; then
        notify-send -a "shutdown" -h string:x-dunst-stack-tag:shutdown -t 2000 "Shutdown" "Shutdown cancelled"
        exit 0
    fi

    current_time=$(date +%s)
    remaining=$(( target_time - current_time ))

    notify-send -a "shutdown" -h string:x-dunst-stack-tag:shutdown -t 2000 "Shutdown" "Remain ${remaining}s to shutdown\nClick again to cancel"

    sleep 1
done

notify-send -a "shutdown" -h string:x-dunst-stack-tag:shutdown "Shutdown" "Shutting down now..."

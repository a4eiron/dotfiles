#!/usr/bin/env bash

BAT=$(cat /sys/class/power_supply/BAT*/capacity)
STATUS=$(cat /sys/class/power_supply/BAT*/status)

if [[ "$STATUS" != "Discharging" ]]; then
    exit 0
fi

STATE_FILE="/tmp/battery20-notified"

if (( BAT <= 20 )); then
    if [[ ! -f "$STATE_FILE" ]]; then
        notify-send \
            -u critical \
            "Low Battery" \
            "Battery is at ${BAT}%"

        touch "$STATE_FILE"
    fi
else
    rm -f "$STATE_FILE"
fi

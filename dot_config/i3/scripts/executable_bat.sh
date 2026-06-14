#!/usr/bin/env bash

battery=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null)
status=$(cat /sys/class/power_supply/BAT*/status 2>/dev/null)

if [[ "$status" == "Charging" ]]; then
    bg="#4CAF50"
    icon=""
elif (( battery <= 15 )); then
    bg="#F44336"
    icon=""
elif (( battery <= 30 )); then
    bg="#FF9800"
    icon=""
elif (( battery <= 60 )); then
    bg="#FFC107"
    icon=""
else
    bg="#4CAF50"
    icon=""
fi

printf '<span foreground="#ffffff"> <span size="xx-large">%s</span><span rise="2600"> %s%% </span></span>\n' \
    "$icon" "$battery"

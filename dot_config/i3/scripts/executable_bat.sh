#!/usr/bin/env bash

shopt -s nullglob
battery_dirs=(/sys/class/power_supply/BAT*)
shopt -u nullglob

if [[ ${#battery_dirs[@]} -eq 0 ]]; then
    echo "No battery found"
    exit 1
fi

for bat_dir in "${battery_dirs[@]}"; do
    bat_name=$(basename "$bat_dir")
    
    if [[ -f "$bat_dir/capacity" && -f "$bat_dir/status" ]]; then
        capacity=$(< "$bat_dir/capacity")
        status=$(< "$bat_dir/status")
    else
        echo "$bat_name: Error reading status"
        continue
    fi

    case "$status" in
        "Charging")
            printf '%s: Charging...%s%%\n' "$bat_name" "$capacity"
            ;;
        "Full")
            printf '%s: Full (%s%%)\n' "$bat_name" "$capacity"
            ;;
        *)
            printf '%s: %s (%s%%)\n' "$bat_name" "$status" "$capacity"
            ;;
    esac
done

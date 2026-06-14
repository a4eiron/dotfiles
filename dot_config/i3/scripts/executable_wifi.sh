#!/usr/bin/env bash

if [[ -n "$BLOCK_BUTTON" ]]; then
    case "$BLOCK_BUTTON" in
        1) nm-connection-editor & ;;
        3) nmcli device wifi rescan & ;;
    esac
    exit 0
fi

ssid=$(iwgetid -r)

if [[ -z "$ssid" ]]; then
    printf 'WIFI: Disconnected\n'
    exit 0
fi

signal=$(awk '
/wlan|wlp/ {
    print int($3 * 100 / 70)
    exit
}' /proc/net/wireless)


printf 'WIFI: %s(%s%%)\n' "$ssid" "$signal"

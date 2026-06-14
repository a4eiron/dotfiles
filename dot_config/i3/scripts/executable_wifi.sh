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
    printf '<span background="#F44336" foreground="#ffffff"> <span size="xx-large">󰖪</span> <span rise="2600">Disconnected</span> </span>\n'
    exit 0
fi

signal=$(awk '
/wlan|wlp/ {
    print int($3 * 100 / 70)
    exit
}' /proc/net/wireless)

if (( signal >= 75 )); then
    bg="#4CAF50"
elif (( signal >= 40 )); then
    bg="#FFC107"
else
    bg="#F44336"
fi

printf '<span background="%s" foreground="#ffffff"> <span size="xx-large"></span> <span rise="2600">%s (%s%%)</span> </span>\n' \
    "$bg" "$ssid" "$signal"

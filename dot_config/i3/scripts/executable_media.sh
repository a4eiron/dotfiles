#!/usr/bin/env bash

case "$BLOCK_BUTTON" in
    1) playerctl play-pause >/dev/null 2>&1 ;;
    3) playerctl next >/dev/null 2>&1 ;;
    2) playerctl previous >/dev/null 2>&1 ;;
esac

status=$(playerctl status 2>/dev/null)

if [[ $? -ne 0 ]]; then
    exit 0
fi

title=$(playerctl metadata title 2>/dev/null)
artist=$(playerctl metadata artist 2>/dev/null)

text="${artist:+$artist - }$title"
maxlen=40

if (( ${#text} > maxlen )); then
    text="${text:0:maxlen-3}..."
fi

case "$status" in
    Playing)
        icon=""
        bg="#5F7A61"
        ;;
    Paused)
        icon=""
        bg="#5B6C8F"
        ;;
    *)
        icon=""
        bg="#4C566A"
        ;;
esac

printf '<span background="%s" foreground="#ECEFF4"> %s %s </span>\n' \
    "$bg" "$icon" "$text"

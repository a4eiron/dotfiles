#!/usr/bin/env bash

if [[ -n "$BLOCK_BUTTON" ]]; then
    case "$BLOCK_BUTTON" in
        1) pavucontrol & ;;
        4) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ ;;
        5) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- ;;
        3) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
    esac
fi

vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

if grep -q MUTED <<< "$vol"; then
    printf '<span foreground="#ffffff"><span size="xx-large">󰝟</span><span rise="2600"> Muted </span></span>\n'
    exit 0
fi

percent=$(awk '{printf("%d",$2*100)}' <<< "$vol")

# if (( percent >= 70 )); then
#     bg="#4CAF50"
# elif (( percent >= 30 )); then
#     bg="#FFC107"
# else
#     bg="#FF9800"
# fi

printf '<span foreground="#ffffff"><span size="xx-large"></span><span rise="2600"> %s%% </span></span>\n' \
    "$percent"

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
    printf 'MUTED\n'
    exit 0
fi

percent=$(awk '{printf("%d",$2*100)}' <<< "$vol")

printf 'VOL: %s%%\n' "$percent"

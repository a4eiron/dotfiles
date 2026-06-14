#!/usr/bin/env bash

get_volume() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf("%d", $2 * 100)}'
}

get_brightness() {
    brightnessctl -m | awk -F',' '{gsub("%","",$4); print $4}'
}

show_volume_notification() {
    local volume
    volume=$(get_volume)

    notify-send \
		-r 9991 \
        -h int:value:"$volume" \
        -t 1000 \
        "Volume" \
        "${volume}%"
}

show_brightness_notification() {
    local brightness
    brightness=$(get_brightness)

    notify-send \
		-r 9992 \
        -h int:value:"$brightness" \
        -t 1000 \
        "Brightness" \
        "${brightness}%"
}

update_blocks() {
    pkill -RTMIN+1 i3blocks
}

case "$1" in
    volume_up)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
        show_volume_notification
        update_blocks
        ;;
    volume_down)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        show_volume_notification
        update_blocks
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        update_blocks

        if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED; then
            notify-send -t 1000 "Volume" "Muted"
        else
            show_volume_notification
        fi
        ;;
    brightness_up)
        brightnessctl set +2%
        show_brightness_notification
        ;;
    brightness_down)
        brightnessctl set 2%-
        show_brightness_notification
        ;;
    *)
        echo "Usage: $0 {volume_up|volume_down|mute|brightness_up|brightness_down}"
        exit 1
        ;;
esac

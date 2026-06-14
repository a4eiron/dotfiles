#!/usr/bin/env bash

LOCK="Lock"
LOGOUT="Logout"
REBOOT="Reboot"
SHUTDOWN="Power Off"

OPTIONS="$LOCK\n$LOGOUT\n$REBOOT\n$SHUTDOWN"

confirm() {
	echo -e "No\nYes" | rofi -dmenu -p "$1" \
		-theme-str '
			window {
				width: 450px;
				border: 0;
			}

			mainbox {
				padding: 16px;
			}

			inputbar {
				padding: 12px 2px;
			}

			entry {
				enabled: false;
			}

			listview {
				lines: 1;
				columns: 2;
				scrollbar: false;
			}

			element {
				padding: 10px;
			}
		'
}

CHOSEN=$(echo -e "$OPTIONS" | rofi -dmenu \
	-p "Power" \
	-theme-str '
		window {
			width: 400px;
			border: 0;
		}
		
		inputbar {
			padding: 12px 2px;
		}

		mainbox {
			padding: 16px;
		}

		inputbar {
			padding: 12px 2px;
		}
		
		entry {
			enabled: false;
		}

		listview { 
			lines: 4; 
			scrollbar: false; 
		} 
		
		element {
			padding: 12px;
		}
		
	'
)

case "$CHOSEN" in
	"$LOCK")
		i3lock --nofork -i /usr/share/endeavouros/backgrounds/endeavouros-wallpaper.png
		;;
	"$LOGOUT")
		i3-msg exit
		;;
	"$REBOOT")
		[[ "$(confirm 'Reboot?')" == "Yes" ]] && systemctl reboot
		;;
	"$SHUTDOWN")
		[[ "$(confirm 'Power Off?')" == "Yes" ]] && systemctl poweroff
		;;
esac

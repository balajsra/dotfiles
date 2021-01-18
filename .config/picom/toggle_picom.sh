#!/bin/bash

if pgrep picom &>/dev/null; then
    notify-send "Turning Picom OFF"
    pkill picom &
else
    notify-send "Turning Picom ON"
    picom --experimental-backend --config /home/sravan/.config/picom/picom.conf &
fi

exit 0

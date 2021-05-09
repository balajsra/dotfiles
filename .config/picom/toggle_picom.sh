#!/bin/bash
#!/bin/bash

helpmenu() {
    echo "Script to toggle picom ON/OFF. Use only one argument at a time."
    echo "Usage: toggle_picom.sh [--toggle | -t] [--on] [--off] [--help | -h]"
    echo "  - Toggle:   toggle_picom.sh OR toggle_picom.sh --toggle OR toggle_picom.sh -t"
    echo "  - Turn On:  toggle_picom.sh --on"
    echo "  - Turn Off: toggle_picom.sh --off"
    echo "  - Help:     toggle_picom.sh --help OR toggle_picom.sh -h"
}

check_running() {
    if pgrep -x picom >/dev/null; then
        echo 1
    else
        echo 0
    fi
}

turn_on() {
    notify-send "Turning Picom ON"

    if [ $(check_running) -eq '0' ]; then
        picom --config /home/sravan/.config/picom/picom.conf &
    fi
}

turn_off() {
    notify-send "Turning Picom OFF"

    if [ $(check_running) -eq '1' ]; then
        killall picom
    fi
}

toggle() {
    if [ $(check_running) -eq '1' ]; then
        turn_off
    else
        turn_on
    fi
}

main() {
    if [ $# -eq 0 ]; then
        # No arguments
        toggle
    else
        case $1 in
        --help | -h)
            helpmenu
            ;;
        --toggle | -t)
            toggle
            ;;
        --on)
            turn_on
            ;;
        --off)
            turn_off
            ;;
        esac
    fi
}

main $@

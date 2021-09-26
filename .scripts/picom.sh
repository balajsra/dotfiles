#!/bin/bash
help_menu() {
    echo "Script to interact with picom. Use only one argument at a time."
    echo "  - Toggle On/Off:   picom.sh OR picom.sh --toggle OR picom.sh -t"
    echo "  - Turn On:  picom.sh --on"
    echo "  - Turn Off: picom.sh --off"
    echo "  - Help:     picom.sh --help OR picom.sh -h"
}

is_running() {
    if pgrep -x picom >/dev/null; then
        echo 1
    else
        echo 0
    fi
}

rofi_menu() {
    declare -a options=(
        "⏼ Toggle - toggle"
        " Turn On - on"
        " Turn Off - off"
        " Back - back"
        " Quit - quit"
    )

    choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i)
    option=$(printf '%s\n' "${choice}" | awk '{print $NF}')

    if [[ "$option" == "quit" ]]; then
        kilall rofi
    elif [[ "$option" != "back" ]]; then
        main "--$option" && main "--rofi"
    fi
}

main() {
    if [ $# -eq 0 ]; then
        # No arguments
        help_menu
    else
        case $1 in
        --help | -h)
            help_menu
            ;;
        --toggle)
            if [ $(is_running) -eq '1' ]; then
                main --off
            else
                main --on
            fi
            ;;
        --on)
            if [ $(is_running) -eq '1' ]; then
                killall picom
            fi

            picom --config /home/sravan/.config/picom/picom.conf -b

            notify-send "Turning Picom ON"
            ;;
        --off)
            if [ $(is_running) -eq '1' ]; then
                killall picom
            fi

            notify-send "Turning Picom OFF"
            ;;
        --rofi)
            rofi_menu
            ;;
        esac
    fi
}

main $@

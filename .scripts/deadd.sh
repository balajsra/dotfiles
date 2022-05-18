#!/bin/bash
help_menu() {
    echo "Script to interact with deadd. Use only one argument at a time."
    echo "  - Toggle On/Off:               deadd.sh OR deadd.sh --toggle OR deadd.sh -t"
    echo "  - Turn On:                     deadd.sh --on"
    echo "  - Turn Off:                    deadd.sh --off"
    echo "  - Toggle Notification Center:  deadd.sh --toggle-center"
    echo "  - Pause Popup Notifications:   deadd.sh --pause"
    echo "  - Unpause Popup Notifications: deadd.sh --unpause"
    echo "  - Rofi Menu:                   deadd.sh --rofi"
    echo "  - Help:                        deadd.sh --help OR deadd.sh -h"
}

is_running() {
    if pgrep -x deadd-notificat >/dev/null; then
        echo 1
    else
        echo 0
    fi
}

rofi_menu() {
    declare -a options=(
        "⏼ Toggle - toggle"
        " Turn On - on"
        " Turn Off - off"
        " Toggle Notification Center - toggle-center"
        " Pause Popup Notifications - pause"
        " Unpause Popup Notifications - unpause"
        " Back - back"
        " Quit - quit"
    )

    choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i)
    option=$(printf '%s\n' "${choice}" | awk '{print $NF}')

    if [[ "$option" == "quit" ]]; then
        killall rofi
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
                killall deadd-notificat
            fi

            /usr/bin/notify-send.py a --hint \
                boolean:deadd-notification-center:true \
                string:type:reloadStyle

            notify-send "Turning Deadd ON"
            ;;
        --off)
            notify-send "Turning Deadd OFF"

            if [ $(is_running) -eq '1' ]; then
                killall deadd-notificat
            fi
            ;;
        --toggle-center)
            kill -s USR1 $(pidof deadd-notification-center)
            ;;
        --pause)
            notify-send "Pausing Notifications"

            /usr/bin/notify-send.py a --hint \
                boolean:deadd-notification-center:true \
                string:type:pausePopups > /dev/null 2>&1
            ;;
        --unpause)
            /usr/bin/notify-send.py a --hint \
                boolean:deadd-notification-center:true \
                string:type:unpausePopups > /dev/null 2>&1

            notify-send "Unpausing Notifications"
            ;;
        --rofi)
            rofi_menu
            ;;
        esac
    fi
}

main $@

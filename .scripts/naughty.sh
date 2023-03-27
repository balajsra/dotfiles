#!/bin/bash
help_menu() {
    echo "Script to interact with AwesomeWM's naughty. Use only one argument at a time."
    echo "  - Toggle Pause/Unpause:        naughty.sh OR naughty.sh --toggle OR naughty.sh -t"
    echo "  - Pause Popup Notifications:   naughty.sh --pause"
    echo "  - Unpause Popup Notifications: naughty.sh --unpause"
    echo "  - Rofi Menu:                   naughty.sh --rofi"
    echo "  - Help:                        naughty.sh --help OR naughty.sh -h"
}

rofi_menu() {
    declare -a options=(
        "⏼ Toggle - toggle"
        " Pause Popup Notifications - pause"
        " Unpause Popup Notifications - unpause"
        " Back - back"
        " Quit - quit"
    )

    choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i)
    option=$(printf '%s\n' "${choice}" | awk '{print $NF}')

    if [[ "$option" == "quit" ]]; then
        pkill rofi
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
            /usr/bin/awesome-client '
            local naughty = require("naughty")
            naughty.toggle()
            '
            ;;
        --pause)
            notify-send "Pausing Notifications"

            /usr/bin/awesome-client '
            local naughty = require("naughty")
            naughty.suspend()
            '
            ;;
        --unpause)
            /usr/bin/awesome-client '
            local naughty = require("naughty")
            naughty.resume()
            '

            notify-send "Unpausing Notifications"
            ;;
        --rofi)
            rofi_menu
            ;;
        esac
    fi
}

main $@

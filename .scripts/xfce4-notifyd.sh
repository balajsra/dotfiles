#!/usr/bin/env bash
help_menu() {
    echo "Script to interact with xfce4-notifyd. Use only one argument at a time."
    echo "  - Toggle Notification Center:  xfce4-notifyd.sh --toggle-center"
    echo "  - Pause Popup Notifications:   xfce4-notifyd.sh --pause"
    echo "  - Unpause Popup Notifications: xfce4-notifyd.sh --unpause"
    echo "  - Rofi Menu:                   xfce4-notifyd.sh --rofi"
    echo "  - Help:                        xfce4-notifyd.sh --help OR xfce4-notifyd.sh -h"
}

rofi_menu() {
    declare -a options=(
        "󱨩 Toggle Notification Center - toggle-center"
        " Pause Popup Notifications - pause"
        " Unpause Popup Notifications - unpause"
        "󰌍 Back - back"
        "󰗼 Quit - quit"
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
        --toggle-center)
            xfce4-notifyd-config
            ;;
        --pause)
            notify-send "Pausing Notifications"

            xfconf-query -c xfce4-notifyd -p /do-not-disturb -s true
            ;;
        --unpause)
            xfconf-query -c xfce4-notifyd -p /do-not-disturb -s false

            notify-send "Unpausing Notifications"
            ;;
        --rofi)
            rofi_menu
            ;;
        esac
    fi
}

main $@

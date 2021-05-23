#!/bin/bash
help_menu() {
    echo "Script to interact with desktop session. Use only one argument at a time."
    # echo "  - Play / Pause:  playerctl.sh --play-pause"
    # echo "  - Next:          playerctl.sh --next"
    # echo "  - Previous:      playerctl.sh --prev"
    # echo "  - Change Player: playerctl.sh --change"
    # echo "  - Rofi Menu:     playerctl.sh --rofi"
    # echo "  - Help:          playerctl.sh --help OR playerctl.sh -h"
}

rofi_menu() {
    declare -a options=(
        " Recompile & Restart Xmonad - restart"
        " Logout - logout"
        " Lock - lock"
        "⏾ Sleep - sleep"
        " Reboot - reboot"
        " Shutdown - shutdown"
        "鈴 Hibernate - hibernate"
        " Quit - quit"
    )

    choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i)
    option=$(printf '%s\n' "${choice}" | awk '{print $NF}')

    if [[ "$option" != "quit" ]]; then
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
        --logout)
            notify-send -t 0 "Session Control" "Press M-S-q to exit xmonad"
            ;;
        --lock)
            light-locker-command --lock
            ;;
        --sleep)
            systemctl suspend
            ;;
        --reboot)
            reboot
            ;;
        --shutdown)
            shutdown now
            ;;
        --hibernate)
            systemctl hibernate
            ;;
        --restart)
            xmonad --recompile
            xmonad --restart
            ;;
        --rofi)
            rofi_menu
            ;;
        esac
    fi
}

main $@

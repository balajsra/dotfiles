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
        "勒 Restart Dwm - restart"
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
        main "--$option" && killall rofi
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
            notify-send "Session Control" "Logging Out of Dwm"
            xdotool key Super+Shift_L+q
            ;;
        --lock)
            notify-send "Session Control" "Locking Session"
            loginctl lock-session
            ;;
        --sleep)
            notify-send "Session Control" "Going to Sleep"
            systemctl suspend
            ;;
        --reboot)
            notify-send "Session Control" "Rebooting System"
            reboot
            ;;
        --shutdown)
            notify-send "Session Control" "Shutting Down System"
            shutdown now
            ;;
        --hibernate)
            notify-send "Session Control" "Hibernating System"
            systemctl hibernate
            ;;
        --restart)
            notify-send "Session Control" "Restarting Dwm"
            xdotool key Super+Control_L+Shift_L+q
            ;;
        --rofi)
            rofi_menu
            ;;
        esac
    fi
}

main $@

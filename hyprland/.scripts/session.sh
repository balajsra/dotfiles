#!/usr/bin/env bash
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
        " Logout - logout"
        " Lock - lock"
        "⏾ Sleep - sleep"
        " Reboot - reboot"
        " Shutdown - shutdown"
        "󰌍 Back - back"
        "󰗼 Quit - quit"
    )

    choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i)
    option=$(printf '%s\n' "${choice}" | awk '{print $NF}')

    if [[ "$option" == "quit" ]]; then
        pkill rofi
    elif [[ "$option" != "back" ]]; then
        main "--$option" && pkill rofi
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
            notify-send "Session Control" "Logging Out of Hyprland" &
            loginctl terminate-user ""
            ;;
        --lock)
            notify-send "Session Control" "Locking Session" &
            loginctl lock-session
            ;;
        --sleep)
            notify-send "Session Control" "Going to Sleep" &
            systemctl suspend
            ;;
        --reboot)
            notify-send "Session Control" "Rebooting System" &
            systemctl reboot
            ;;
        --shutdown)
            notify-send "Session Control" "Shutting Down System" &
            systemctl poweroff
            ;;
        --rofi)
            rofi_menu
            ;;
        esac
    fi
}

main $@

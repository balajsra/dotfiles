#!/usr/bin/env bash
help_menu() {
    echo "Script to interact with playerctl. Use only one argument at a time."
    echo "  - Play / Pause:  playerctl.sh --play-pause"
    echo "  - Next:          playerctl.sh --next"
    echo "  - Previous:      playerctl.sh --prev"
    echo "  - Change Player: playerctl.sh --change"
    echo "  - Rofi Menu:     playerctl.sh --rofi"
    echo "  - Help:          playerctl.sh --help OR playerctl.sh -h"
}

rofi_menu() {
    declare -a options=(
        "󰐎 Play / Pause - play-pause"
        "󰒭 Next - next"
        "󰒮 Previous - prev"
        "󰡀 Change Source - change"
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
        --play-pause)
            playerctl --player=playerctld play-pause
            ;;
        --next)
            playerctl --player=playerctld next
            ;;
        --prev)
            playerctl --player=playerctld previous
            ;;
        --change)
            playerctld shift
            ;;
        --rofi)
            rofi_menu
            ;;
        esac
    fi
}

main $@

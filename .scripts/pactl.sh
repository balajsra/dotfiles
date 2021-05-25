#!/bin/bash
help_menu() {
    echo "Script to interact with pactl. Use only one argument at a time."
    # echo "  - Play / Pause:  playerctl.sh --play-pause"
    # echo "  - Next:          playerctl.sh --next"
    # echo "  - Previous:      playerctl.sh --prev"
    # echo "  - Change Player: playerctl.sh --change"
    # echo "  - Rofi Menu:     playerctl.sh --rofi"
    # echo "  - Help:          playerctl.sh --help OR playerctl.sh -h"
}

rofi_menu() {
    declare -a options=(
        " Raise Volume - raise"
        " Lower Volume - lower"
        " Mute - mute"
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
        --raise)
            pactl set-sink-volume @DEFAULT_SINK@ +5%
            ;;
        --lower)
            pactl set-sink-volume @DEFAULT_SINK@ -5%
            ;;
        --mute)
            pactl set-sink-mute @DEFAULT_SINK@ toggle
            ;;
        --rofi)
            rofi_menu
            ;;
        esac
    fi
}

main $@

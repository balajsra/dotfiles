#!/bin/bash
help_menu() {
    echo "Main script to launch sub-menu scripts. Use only one argument at a time."
    # echo "  - Play / Pause:  playerctl.sh --play-pause"
    # echo "  - Next:          playerctl.sh --next"
    # echo "  - Previous:      playerctl.sh --prev"
    # echo "  - Change Player: playerctl.sh --change"
    # echo "  - Rofi Menu:     playerctl.sh --rofi"
    # echo "  - Help:          playerctl.sh --help OR playerctl.sh -h"
}

rofi_menu() {
    declare -a options=(
        " Compositor - picom"
        " Notifications - deadd"
        " Media - playerctl"
        "墳Volume - pactl"
        " Startup Processes - startup"
        " Hardware - system76-power"
        " Power Menu - session"
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
        --picom)
            /home/sravan/.scripts/picom.sh --rofi
            ;;
        --deadd)
            /home/sravan/.scripts/deadd.sh --rofi
            ;;
        --playerctl)
            /home/sravan/.scripts/playerctl.sh --rofi
            ;;
        --pactl)
            /home/sravan/.scripts/pactl.sh --rofi
            ;;
        --startup)
            /home/sravan/.scripts/startup.sh --rofi
            ;;
        --system76-power)
            /home/sravan/.scripts/system76-power.sh --rofi
            ;;
        --session)
            /home/sravan/.scripts/session.sh --rofi
            ;;
        --rofi)
            rofi_menu
            ;;
        esac
    fi
}

main $@

#!/bin/bash
help_menu() {
    echo "Script to control gaming related things. Use only one argument at a time."
    # echo "  - Play / Pause:  playerctl.sh --play-pause"
    # echo "  - Next:          playerctl.sh --next"
    # echo "  - Previous:      playerctl.sh --prev"
    # echo "  - Change Player: playerctl.sh --change"
    # echo "  - Rofi Menu:     playerctl.sh --rofi"
    # echo "  - Help:          playerctl.sh --help OR playerctl.sh -h"
}

rofi_menu() {
    declare -a options=(
        "調 DualSense to Xbox 360 Mapping - dualsense-to-xbox-360"
        " Game Launch Settings - game-launch"
        " Game Exit Settings - game-exit"
        " Back - back"
        " Quit - quit"
    )

    choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i)
    option=$(printf '%s\n' "${choice}" | awk '{print $NF}')

    if [[ "$option" == "quit" ]]; then
        killall rofi
    elif [[ "$option" != "back" ]]; then
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
        --dualsense-to-xbox-360)
            kitty --hold /home/sravan/.scripts/dualsense_to_xbox_360_controller.sh
            ;;
        --game-launch)
            /home/sravan/.scripts/game_launch.sh
            ;;
        --game-exit)
            /home/sravan/.scripts/game_exit.sh
            ;;
        --rofi)
            rofi_menu
            ;;
        esac
    fi
}

main $@

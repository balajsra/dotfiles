#!/bin/bash
help_menu() {
    echo "Main menu to launch run rsync scripts. Use only one argument at a time."
    # echo "  - Play / Pause:  playerctl.sh --play-pause"
    # echo "  - Next:          playerctl.sh --next"
    # echo "  - Previous:      playerctl.sh --prev"
    # echo "  - Change Player: playerctl.sh --change"
    # echo "  - Rofi Menu:     playerctl.sh --rofi"
    # echo "  - Help:          playerctl.sh --help OR playerctl.sh -h"
}

rofi_menu() {
    declare -a options=(
        "   - rsync-laptop-to-cloud"
        "   - rsync-laptop-to-external-hdd"
        "   - rsync-laptop-to-phone"
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
        --rsync-laptop-to-cloud)
            kitty --hold /home/sravan/.scripts/rsync_laptop_to_cloud.sh
            ;;
        --rsync-laptop-to-external-hdd)
            kitty --hold /home/sravan/.scripts/rsync_laptop_to_external_hdd.sh
            ;;
        --rsync-laptop-to-phone)
            kitty --hold /home/sravan/.scripts/rsync_laptop_to_phone.sh
            ;;
        --rofi)
            rofi_menu
            ;;
        esac
    fi
}

main $@

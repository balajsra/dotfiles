#!/bin/bash
help_menu() {
    echo "Main menu to launch run rsync scripts. Use only one argument at a time."
}

rofi_menu() {
    declare -a options=(
        "   - rsync-laptop-to-cloud"
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
        --rofi)
            rofi_menu
            ;;
        esac
    fi
}

main $@

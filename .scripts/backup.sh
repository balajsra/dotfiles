#!/bin/bash
help_menu() {
    echo "Main menu to launch backup scripts. Use only one argument at a time."
}

rofi_menu() {
    declare -a options=(
        "󰋊 - backup-root-to-hdd"
        "󰋊 - backup-home-to-hdd"
        "󰒍 - backup-root-to-fileserver"
        "󰒍 - backup-home-to-fileserver"
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
        --backup-root-to-hdd)
            kitty --hold /home/sravan/.scripts/backup_root_to_hdd.sh
            ;;
        --backup-home-to-hdd)
            kitty --hold /home/sravan/.scripts/backup_home_to_hdd.sh
            ;;
        --backup-root-to-fileserver)
            kitty --hold /home/sravan/.scripts/backup_root_to_fileserver.sh
            ;;
        --backup-home-to-fileserver)
            kitty --hold /home/sravan/.scripts/backup_home_to_fileserver.sh
            ;;
        --rofi)
            rofi_menu
            ;;
        esac
    fi
}

main $@

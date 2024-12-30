#!/usr/bin/env bash
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
            ghostty -e "sudo systemctl start snapborg-backup-hdd@root.service && journalctl -f -u snapborg-backup-hdd@root.service"
            ;;
        --backup-home-to-hdd)
            ghostty -e "sudo systemctl start snapborg-backup-hdd@home.service && journalctl -f -u snapborg-backup-hdd@home.service"
            ;;
        --backup-root-to-fileserver)
            ghostty -e "sudo systemctl start snapborg-backup-fileserver@root.service && journalctl -f -u snapborg-backup-fileserver@root.service"
            ;;
        --backup-home-to-fileserver)
            ghostty -e "sudo systemctl start snapborg-backup-fileserver@home.service && journalctl -f -u snapborg-backup-fileserver@home.service"
            ;;
        --rofi)
            rofi_menu
            ;;
        esac
    fi
}

main $@

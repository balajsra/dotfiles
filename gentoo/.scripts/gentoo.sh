#!/usr/bin/env bash
help_menu() {
    echo "Script to run common gentoo specific actions."
    # echo "  - Play / Pause:  playerctl.sh --play-pause"
    # echo "  - Next:          playerctl.sh --next"
    # echo "  - Previous:      playerctl.sh --prev"
    # echo "  - Change Player: playerctl.sh --change"
    # echo "  - Rofi Menu:     playerctl.sh --rofi"
    # echo "  - Help:          playerctl.sh --help OR playerctl.sh -h"
}

rofi_menu() {
    declare -a options=(
        "󰚰 Sync and Update Packages - sync-update"
        " Spice Up Spotify - spicetify"
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
        --sync-update)
            notify-send "Gentoo" "Syncing repos" &
            uwsm app -- foot -H sudo eix-sync -a
            notify-send "Gentoo" "Updating Live Packages" &
            uwsm app -- foot -H sudo emerge @smart-live-rebuild
            notify-send "Gentoo" "Updating Versioned Packages" &
            uwsm app -- foot -H sudo emerge --update --deep --newuse --with-bdeps=y --verbose-conflicts @world
            ;;
        --spicetify)
            notify-send "Gentoo" "Spicing Up Spotify" &
            uwsm app -- foot -H sudo emerge media-sound/spotify app-misc/spicetify-cli-bin::sravan-overlay && sudo chmod a+wr -R /opt/spotify && spicetify backup apply
            ;;
        --rofi)
            rofi_menu
            ;;
        esac
    fi
}

main $@

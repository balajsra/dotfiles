#!/usr/bin/env bash
declare -a startup_array=(\
    # Status Bar
    "$HOME/.config/dwl/waybar/launch.sh" \  # Waybar (dwl configuration)
    # Background Processes
    "/usr/bin/swayidle" \                                      # Swayidle Idle Manager
    "/usr/libexec/polkit-gnome-authentication-agent-1" \       # GNOME Polkit Authentication Agent
    "/usr/bin/kdeconnectd --replace" \                         # KDE Connect Daemon
    "$HOME/.scripts/dunst.sh --on" \                           # Dunst Notification Daemon
    "/usr/bin/wl-paste --type text --watch cliphist store" \   # Clipboard for Text
    "/usr/bin/wl-paste --type image --watch cliphist store" \  # Clipboard for Images
    "/usr/bin/swhks" \                                         # Simple Wayland HotKey Server
    "sudo /usr/bin/swhkd" \                                    # Simple Wayland HotKey Daemon
    # Display / Compositor Setup
    "/usr/bin/shikane" \             # Display Setup
    "/usr/bin/hyprwall --restore" \  # Wallpaper
    "/usr/bin/gammastep -x" \        # Reset gammastep night light
    # Tray Applications
    "/usr/bin/gammastep-indicator" \   # Gamamstep Night Light Indicator
    "/usr/bin/blueman-applet" \        # Bluetooth Manager Applet
    "/usr/bin/nm-applet" \             # Network Manager Applet
    "/usr/bin/kdeconnect-indicator" \  # KDE Connect Indicator
    "/usr/bin/udiskie -a -n -s" \      # Udiskie
    # GUI Applications
    "/usr/bin/nextcloud" \      # NextCloud Client
    "/usr/bin/syncthing-gtk" \  # Syncthing GUI
    "/usr/bin/openrgb" \        # OpenRGB
)

declare -a kill_startup_array=(\
    # Status Bar
    "pkill waybar" \
    # Background Processes
    "pkill swayidle" \
    "pkill polkit-gnome-au" \
    "pkill kdeconnectd" \
    "$HOME/.scripts/dunst.sh --off" \
    "pkill wl-paste" \
    "pkill swhks" \
    "pkill swhkd" \
    # Display / Compositor Setup
    "pkill shikane" \
    "pkill gammastep" \
    # Tray Applications
    "pkill gammastep-indic" \
    "pkill blueman-applet" \
    "pkill nm-applet" \
    "pkill kdeconnect-indi" \
    "pkill udiskie" \
    # GUI Applications
    "pkill nextcloud" \
    "pkill syncthing-gtk" \
    "pkill openrgb" \
)

help_menu() {
    echo "Main script to launch and kill startup processes. Use only one argument at a time."
    # echo "  - Play / Pause:  playerctl.sh --play-pause"
    # echo "  - Next:          playerctl.sh --next"
    # echo "  - Previous:      playerctl.sh --prev"
    # echo "  - Change Player: playerctl.sh --change"
    # echo "  - Rofi Menu:     playerctl.sh --rofi"
    # echo "  - Help:          playerctl.sh --help OR playerctl.sh -h"
}

rofi_menu() {
    declare -a options=(
        " Launch Startup Processes - startup"
        " Kill Startup Processes - kill-startup"
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
        --startup)
            for i in "${startup_array[@]}"
            do
                if ! command -v $i > /dev/null
                then
                    do_nothing() { :; }
                else
                    $i &
                fi
            done
            ;;
        --kill-startup)
            for i in "${kill_startup_array[@]}"
            do
                if ! command -v $i > /dev/null
                then
                    do_nothing() { :; }
                else
                    $i &
                fi
            done
            ;;
        --rofi)
            rofi_menu
            ;;
        esac
    fi
}

main $@

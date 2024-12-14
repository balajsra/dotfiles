#!/usr/bin/env bash
declare -a startup_array=(\
    "/usr/bin/greenclip daemon" \                         # Greenclip Clipboard Manager
    "/usr/libexec/polkit-gnome-authentication-agent-1" \  # GNOME Polkit Authentication Agent
    "/usr/bin/xss-lock -l -- betterlockscreen --lock" \   # Session Lock Utility
    "/usr/lib/kdeconnectd --replace" \                    # KDE Connect Daemon
    "/usr/bin/unclutter" \                                # Hide Mouse Cursor
    "/usr/bin/easyeffects --gapplication-service" \       # Easy Effects PipeWire Plugins
)

declare -a kill_startup_array=(\
    "pkill greenclip" \    # Greenclip Clipboard Manager
    "pkill polkit" \       # GNOME Polkit Authentication Agent
    "pkill xss-lock" \     # Session Lock Utility
    "pkill kdeconnectd" \  # KDE Connect Daemon
    "pkill unclutter" \    # Hide Mouse Cursor
    "pkill easyeffects" \  # Easy Effects PipeWire Plugins
)

declare -a delay_array=(\
    "/usr/bin/blueman-applet" \                # Blueman Bluetooth Manager
    "/usr/bin/nm-applet" \                     # Network Manager Applet
    "/usr/bin/kdeconnect-indicator" \          # KDE Connect Indicator
    "/usr/bin/flameshot" \                     # Flameshot Screenshot Tool
    "/usr/bin/xfce4-power-manager" \           # XFCE4 Power Manager
    "/usr/bin/udiskie -a -n -s" \              # Udiskie
    "/usr/bin/openrgb" \                       # OpenRGB
    "/usr/bin/syncthing-gtk" \                 # Syncthing GTK
    "/usr/bin/nextcloud" \                     # NextCloud Client
    "/usr/bin/nyrna" \                         # Nyrna
    "bash $HOME/.scripts/dunst.sh --on" \      # Dunst Notification Daemon
    "bash $HOME/.scripts/picom.sh --on" \      # Picom Compositor
    "/usr/bin/autorandr --change --force" \    # Auto restore screen layout
    "/usr/bin/numlockx on" \                   # Enable numlock
)

declare -a kill_delay_array=(\
    "pkill blueman-applet" \                    # Blueman Bluetooth Manager
    "pkill nm-applet" \                         # Network Manager Applet
    "pkill kdeconnect-indicator" \              # KDE Connect Indicator
    "pkill flameshot" \                         # Flameshot Screenshot Tool
    "pkill xfce4-power-manager" \               # XFCE4 Power Manager
    "pkill udiskie" \                           # Udiskie
    "pkill openrgb" \                           # OpenRGB
    "pkill syncthing-gtk" \                     # Syncthing GTK
    "pkill nextcloud" \                         # NextCloud Client
    "pkill nyrna" \                             # Nyrna
    "bash $HOME/.scripts/dunst.sh --off" \      # Dunst Notification Daemon
    "bash $HOME/.scripts/picom.sh --off" \      # Picom Compositor
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
        "󰔟 Launch Delayed Processes - delay"
        " Kill Startup Processes - kill-startup"
        " Kill Delayed Processes - kill-delay"
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
        --delay)
            for i in "${delay_array[@]}"
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
        --kill-delay)
            for i in "${kill_delay_array[@]}"
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

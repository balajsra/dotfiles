#!/usr/bin/env bash
help_menu() {
    echo "Script to control CPU & GPU modes / performance profiles. Use only one argument at a time."
    # echo "  - Play / Pause:  playerctl.sh --play-pause"
    # echo "  - Next:          playerctl.sh --next"
    # echo "  - Previous:      playerctl.sh --prev"
    # echo "  - Change Player: playerctl.sh --change"
    # echo "  - Rofi Menu:     playerctl.sh --rofi"
    # echo "  - Help:          playerctl.sh --help OR playerctl.sh -h"
}

rofi_menu() {
    declare -a options=(
        " CPU Performance Profile - rofi-cpu-profile"
        " GPU Switching - rofi-graphics"
        " NVIDIA GPU Performance Profile - rofi-gpu-profile"
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

rofi_cpu_profile_menu() {
    declare -a options=(
        " Query Current Profile - cpu-profile-query"
        "󰂃 Switch to Battery Mode - cpu-profile-battery"
        "󰗑 Switch to Balanced Mode - cpu-profile-balanced"
        "󰓅 Switch to Performance Mode - cpu-profile-performance"
        "󰌍 Back - back"
        "󰗼 Quit - quit"
    )

    choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i)
    option=$(printf '%s\n' "${choice}" | awk '{print $NF}')

    if [[ "$option" == "quit" ]]; then
        pkill rofi
    elif [[ "$option" != "back" ]]; then
        main "--$option" && main "--rofi-cpu-profile"
    fi
}

rofi_graphics_menu() {
    declare -a options=(
        " Query Current Graphics - graphics-query"
        "Switch to Compute Mode - graphics-compute"
        "Switch to Hybrid Mode - graphics-hybrid"
        "Switch to Integrated Mode - graphics-integrated"
        "Switch to Nvidia Mode - graphics-nvidia"
        "󰌍 Back - back"
        "󰗼 Quit - quit"
    )

    choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i)
    option=$(printf '%s\n' "${choice}" | awk '{print $NF}')

    if [[ "$option" == "quit" ]]; then
        pkill rofi
    elif [[ "$option" != "back" ]]; then
        main "--$option" && main "--rofi-graphics"
    fi
}

rofi_gpu_profile_menu() {
    declare -a options=(
        " Query Current Profile - gpu-profile-query"
        "󱤎 Switch to Adaptive Mode - gpu-profile-adaptive"
        "󰓅 Switch to Performance Mode - gpu-profile-performance"
        "󱣲 Switch to Auto Mode - gpu-profile-auto"
        "󰌍 Back - back"
        "󰗼 Quit - quit"
    )

    choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i)
    option=$(printf '%s\n' "${choice}" | awk '{print $NF}')

    if [[ "$option" == "quit" ]]; then
        pkill rofi
    elif [[ "$option" != "back" ]]; then
        main "--$option" && main "--rofi-gpu-profile"
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
        --rofi-graphics)
            rofi_graphics_menu
            ;;
        --graphics-query)
            current_graphics=$(sudo system76-power graphics)
            notify-send "System76-Power Graphics" "$current_graphics"
            ;;
        --graphics-compute)
            notify-send "System76-Power Graphics" "Switching to Compute Graphics..."
            sudo system76-power graphics compute
            notify-send -u critical -t 0 "System76-Power Graphics" "Please reboot computer to switch graphics"
            ;;
        --graphics-hybrid)
            notify-send "System76-Power Graphics" "Switching to Hybrid Graphics..."
            sudo system76-power graphics hybrid
            notify-send -u critical -t 0 "System76-Power Graphics" "Please reboot computer to switch graphics"
            ;;
        --graphics-integrated)
            notify-send "System76-Power Graphics" "Switching to Integrated Graphics..."
            sudo system76-power graphics integrated
            notify-send -u critical -t 0 "System76-Power Graphics" "Please reboot computer to switch graphics"
            ;;
        --graphics-nvidia)
            notify-send "System76-Power Graphics" "Switching to Nvidia Graphics..."
            sudo system76-power graphics nvidia
            notify-send -u critical -t 0 "System76-Power Graphics" "Please reboot computer to switch graphics"
            ;;
        --rofi-cpu-profile)
            rofi_cpu_profile_menu
            ;;
        --cpu-profile-query)
            current_profile=$(sudo system76-power profile)
            notify-send "System76-Power CPU Profile" "$current_profile"
            ;;
        --cpu-profile-battery)
            sudo system76-power profile battery
            notify-send "System76-Power CPU Profile" "Switched to Battery Profile"
            ;;
        --cpu-profile-balanced)
            sudo system76-power profile balanced
            notify-send "System76-Power CPU Profile" "Switched to Balanced Profile"
            ;;
        --cpu-profile-performance)
            sudo system76-power profile performance
            notify-send "System76-Power CPU Profile" "Switched to Performance Profile"
            ;;
        --rofi-gpu-profile)
            rofi_gpu_profile_menu
            ;;
        --gpu-profile-query)
            current_profile=$(nvidia-settings -q GpuPowerMizerMode)
            notify-send "NVIDIA GPU Profile" "$current_profile"
            ;;
        --gpu-profile-adaptive)
            nvidia-settings -a "[gpu:0]/GpuPowerMizerMode=0"
            notify-send "NVIDIA GPU Profile" "Switched to Adaptive Profile"
            ;;
        --gpu-profile-performance)
            nvidia-settings -a "[gpu:0]/GpuPowerMizerMode=1"
            notify-send "NVIDIA GPU Profile" "Switched to Performance Profile"
            ;;
        --gpu-profile-auto)
            nvidia-settings -a "[gpu:0]/GpuPowerMizerMode=2"
            notify-send "NVIDIA GPU Profile" "Switched to Auto Profile"
            ;;
        --rofi)
            rofi_menu
            ;;
        esac
    fi
}

main $@

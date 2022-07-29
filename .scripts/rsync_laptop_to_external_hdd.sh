#!/bin/bash
# Define base paths
external_hdd_path="/run/media/sravan/Seagate 5TB"
backup_path="$external_hdd_path/Backups"
home_path="/home/sravan"

# Define arrays
declare -a source_dirs=(
    "$home_path/Calibre_Library/"
    "$home_path/ISOs/"
    "$home_path/Music/"
    "$home_path/Pictures/"
    "$home_path/Videos/"
    "$home_path/Games/"
    "$home_path/.config/lutris/"
    "$home_path/.config/dolphin-emu/"
    "$home_path/.config/retroarch/"
    "$home_path/.config/rpcs3/"
    "$home_path/.config/PCSX2/"
    "$home_path/.cache/lutris/"
)
declare -a target_dirs=(
    "$backup_path/Calibre_Library/"
    "$backup_path/ISOs/"
    "$backup_path/Music/"
    "$backup_path/Pictures/"
    "$backup_path/Videos/"
    "$backup_path/Games/"
    "$backup_path/.config/lutris/"
    "$backup_path/.config/dolphin-emu/"
    "$backup_path/.config/retroarch/"
    "$backup_path/.config/rpcs3/"
    "$backup_path/.config/PCSX2/"
    "$backup_path/.cache/lutris/"
)

# Loop through arrays
for i in ${!source_dirs[@]}; do
    # Create target directories
    mkdir -p "${target_dirs[$i]}"

    # Copy source dirs to target dirs
    rsync -a -v -L --progress --delete \
        --exclude '*/dosdevices/' \
        "${source_dirs[$i]}" \
        "${target_dirs[$i]}"
done

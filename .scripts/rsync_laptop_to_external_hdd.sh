#!/bin/bash
# Define base paths
external_hdd_path="/mnt/5TB External HDD"
backup_path="$external_hdd_path/Backups"
home_path="/home/sravan"

# Define arrays
declare -a source_dirs=(
    "$home_path/Calibre_Library/"
    "$home_path/Documents/"
    "$home_path/ISOs/"
    "$home_path/Music/"
    "$home_path/Videos/"
    "$home_path/Games/PolyMC/"
    "$home_path/Games/Retro/"
    "$home_path/Games/Steam/steamapps/common/"
)
declare -a target_dirs=(
    "$backup_path/Calibre_Library/"
    "$backup_path/Documents/"
    "$backup_path/ISOs/"
    "$backup_path/Music/"
    "$backup_path/Videos/"
    "$backup_path/Games/PolyMC/"
    "$backup_path/Games/Retro/"
    "$backup_path/Games/Steam/"
)

# Loop through arrays
for i in ${!source_dirs[@]}; do
    # Create target directories
    mkdir -p "${target_dirs[$i]}"

    # Copy source dirs to target dirs
    rsync -a -v -L --progress --delete \
        "${source_dirs[$i]}" \
        "${target_dirs[$i]}"
done

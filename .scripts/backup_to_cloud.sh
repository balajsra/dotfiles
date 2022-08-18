#!/bin/bash
# Define base paths
gdrive_path="/mnt/google-drive"
gdrive_personal_path="$gdrive_path/sr98vn@gmail.com"
home_path="/home/sravan"

# Define arrays
declare -a source_dirs=(
    "$home_path/Calibre_Library/"
    "$home_path/Pictures/Wallpapers/"
    "$home_path/Documents/"
)
declare -a target_dirs=(
    "$gdrive_personal_path/Calibre Library/"
    "$gdrive_personal_path/Customization/Wallpapers/Desktop/"
    "$gdrive_personal_path/Documents/"
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

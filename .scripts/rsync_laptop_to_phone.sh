#!/bin/bash
# Define base paths
phone_path="/run/user/1000/b2c922a2358570a6"
home_path="/home/sravan"

# Define arrays
declare -a source_dirs=(
    "$home_path/Videos/"
)
declare -a target_dirs=(
    "$phone_path/Videos/"
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

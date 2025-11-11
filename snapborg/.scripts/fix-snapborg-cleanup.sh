#!/usr/bin/env bash
# Usage: fix-snapborg-cleanup.sh <snapper-config>

set -euo pipefail

if [ $# -ne 1 ]; then
    echo "Usage: $0 <snapper-config>"
    exit 1
fi

CONFIG="$1"

# Check that the config exists
if ! snapper list-configs --columns config | grep -qx "$CONFIG"; then
    echo "Error: snapper config '$CONFIG' not found."
    echo "Available configs:"
    snapper list-configs --columns config
    exit 1
fi

echo "Checking snapshots for config: $CONFIG"

# Find all snapshots where snapborg_backup=true but Cleanup is empty,
# and set the cleanup algorithm to 'timeline' for them.
snapper -c "$CONFIG" list --disable-used-space | awk '/snapborg_backup=true/ {print $1}' | while read -r id; do
    # Query the cleanup field for this snapshot
    cleanup=$(snapper -c "$CONFIG" list --disable-used-space --columns number,cleanup | awk -v id="$id" '$1==id {print $3}')
    if [ -z "$cleanup" ]; then
        echo "Fixing snapshot ID $id (adding Cleanup=timeline)"
        snapper -c "$CONFIG" modify --cleanup-algorithm timeline "$id"
    fi
done

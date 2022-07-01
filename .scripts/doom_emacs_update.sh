#!/bin/bash
# Define some local variables
DOOM_BIN=~/.config/doom-emacs/bin/doom
DOOM_DIR_PATH=~/.config/doom-emacs-config

# Upgrade Doom to the latest version (then update your packages). This is equivalent to
# $ git pull
# $ doom sync
# $ doom update
DOOMDIR=$DOOM_DIR_PATH $DOOM_BIN upgrade

# Delete orphaned packages & repos, and compacts them
DOOMDIR=$DOOM_DIR_PATH $DOOM_BIN purge

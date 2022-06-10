#!/bin/bash
# Define some local variables
DOOM_BIN=~/.config/doom-emacs/bin/doom
DOOM_DIR_PATH=~/.config/doom-emacs-config

# Synchronize personal config
DOOMDIR=$DOOM_DIR_PATH $DOOM_BIN sync

# Upgrade packages
DOOMDIR=$DOOM_DIR_PATH $DOOM_BIN upgrade

# Delete orphaned packages & repos, and compacts them
DOOMDIR=$DOOM_DIR_PATH $DOOM_BIN purge

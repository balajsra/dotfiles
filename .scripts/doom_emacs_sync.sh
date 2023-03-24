#!/bin/bash
# Define some local variables
DOOM_BIN=~/.config/doom-emacs/bin/doom
DOOM_DIR_PATH=~/.config/doom-emacs-config

# Sync Doom with personal configuration
DOOMDIR=$DOOM_DIR_PATH $DOOM_BIN sync

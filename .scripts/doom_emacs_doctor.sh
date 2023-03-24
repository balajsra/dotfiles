#!/bin/bash
# Define some local variables
DOOM_BIN=~/.config/doom-emacs/bin/doom
DOOM_DIR_PATH=~/.config/doom-emacs-config

# Check for errors with installation
DOOMDIR=$DOOM_DIR_PATH $DOOM_BIN doctor

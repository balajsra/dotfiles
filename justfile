set shell := ["bash", "-c"]

DOOM_BIN := "~/.config/doom-emacs/bin/doom"
DOOM_DIR_PATH := "~/.config/doom-emacs-config"

# List just commands by default
default:
    @just --list

# Update doom emacs and sync config
doom-emacs-update: && doom-emacs-sync
    DOOMDIR={{DOOM_DIR_PATH}} {{DOOM_BIN}} upgrade
    DOOMDIR={{DOOM_DIR_PATH}} {{DOOM_BIN}} purge

# Sync doom emacs config
doom-emacs-sync:
    DOOMDIR={{DOOM_DIR_PATH}} {{DOOM_BIN}} sync

# Check doom emacs & config for issues
doom-emacs-doctor:
    DOOMDIR={{DOOM_DIR_PATH}} {{DOOM_BIN}} doctor

# Create softlinks from .dotfiles to home directory
stow-create:
    stow -v -S .

# Remove softlinks from .dotfiles to home directory
stow-delete:
    stow -v -D .

# Remove and re-create softlinks from .dotfiles to home directory
stow-recreate:
    stow -v -R .

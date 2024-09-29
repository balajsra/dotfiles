set shell := ["bash", "-c"]

DOOM_BIN := "~/.config/doom-emacs/bin/doom"
DOOM_DIR_PATH := "~/.config/doom-emacs-config"

# List just commands by default
default:
    @just --list

# Update doom emacs and sync config
doom-emacs-update: && doom-emacs-sync
    DOOMDIR={{DOOM_DIR_PATH}} {{DOOM_BIN}} upgrade

# Sync doom emacs config
doom-emacs-sync:
    DOOMDIR={{DOOM_DIR_PATH}} {{DOOM_BIN}} sync -u

# Check doom emacs & config for issues
doom-emacs-doctor:
    DOOMDIR={{DOOM_DIR_PATH}} {{DOOM_BIN}} doctor

# Create softlinks from .dotfiles to home directory
stow-create:
    stow -v \
        -S alacritty \
        -S autorandr \
        -S awesome \
        -S bash \
        -S betterlockscreen \
        -S blender \
        -S brightness \
        -S calibre \
        -S deadd \
        -S dunst \
        -S dwl \
        -S dwm \
        -S emacs \
        -S eww \
        -S fish \
        -S freecad \
        -S fuzzel \
        -S gaming \
        -S gammastep \
        -S geoclue \
        -S gimp \
        -S git \
        -S gtk \
        -S hyprland \
        -S kitty \
        -S mangal \
        -S mpv \
        -S naughty \
        -S pactl \
        -S picom \
        -S playerctl \
        -S qt5 \
        -S redshift \
        -S rofi \
        -S shikane \
        -S snapborg \
        -S ssh \
        -S starship \
        -S swappy \
        -S swaync \
        -S swhkd \
        -S syncthing \
        -S system76 \
        -S tmux \
        -S trackma \
        -S trackpad \
        -S tty \
        -S vim \
        -S vscode \
        -S x11 \
        -S xfce4-notifyd \
        -S xmonad \
        -S xournalpp \
        -S xrandr \
        -S zathura \
        -S zsh

# Remove softlinks from .dotfiles to home directory
stow-delete:
    stow -v \
        -D alacritty \
        -D autorandr \
        -D awesome \
        -D bash \
        -D betterlockscreen \
        -D blender \
        -D brightness \
        -D calibre \
        -D deadd \
        -D dunst \
        -D dwl \
        -D dwm \
        -D emacs \
        -D eww \
        -D fish \
        -D freecad \
        -D fuzzel \
        -D gaming \
        -D gammastep \
        -D geoclue \
        -D gimp \
        -D git \
        -D gtk \
        -D hyprland \
        -D kitty \
        -D mangal \
        -D mpv \
        -D naughty \
        -D pactl \
        -D picom \
        -D playerctl \
        -D qt5 \
        -D redshift \
        -D rofi \
        -D shikane \
        -D snapborg \
        -D ssh \
        -D starship \
        -D swappy \
        -D swaync \
        -D swhkd \
        -D syncthing \
        -D system76 \
        -D tmux \
        -D trackma \
        -D trackpad \
        -D tty \
        -D vim \
        -D vscode \
        -D x11 \
        -D xfce4-notifyd \
        -D xmonad \
        -D xournalpp \
        -D xrandr \
        -D zathura \
        -D zsh

# Remove and re-create softlinks from .dotfiles to home directory
stow-recreate:
    stow -v \
        -R alacritty \
        -R autorandr \
        -R awesome \
        -R bash \
        -R betterlockscreen \
        -R blender \
        -R brightness \
        -R calibre \
        -R deadd \
        -R dunst \
        -R dwl \
        -R dwm \
        -R emacs \
        -R eww \
        -R fish \
        -R freecad \
        -R fuzzel \
        -R gaming \
        -R gammastep \
        -R geoclue \
        -R gimp \
        -R git \
        -R gtk \
        -R hyprland \
        -R kitty \
        -R mangal \
        -R mpv \
        -R naughty \
        -R pactl \
        -R picom \
        -R playerctl \
        -R qt5 \
        -R redshift \
        -R rofi \
        -R shikane \
        -R snapborg \
        -R ssh \
        -R starship \
        -R swappy \
        -R swaync \
        -R swhkd \
        -R syncthing \
        -R system76 \
        -R tmux \
        -R trackma \
        -R trackpad \
        -R tty \
        -R vim \
        -R vscode \
        -R x11 \
        -R xfce4-notifyd \
        -R xmonad \
        -R xournalpp \
        -R xrandr \
        -R zathura \
        -R zsh

# Update git submodules from remotes
submodule-update:
    git submodule update --init --recursive --remote --progress

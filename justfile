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
        -S bash \
        -S blender \
        -S brightness \
        -S calibre \
        -S dunst \
        -S dwl \
        -S emacs \
        -S fish \
        -S foot \
        -S freecad \
        -S gaming \
        -S gammastep \
        -S geoclue \
        -S ghostty \
        -S gimp \
        -S git \
        -S gtk \
        -S hyprland \
        -S kitty \
        -S mangal \
        -S mpv \
        -S pactl \
        -S pkgdev \
        -S playerctl \
        -S qt5 \
        -S rofi \
        -S shikane \
        -S snapborg \
        -S ssh \
        -S starship \
        -S swappy \
        -S swayidle \
        -S swaylock \
        -S swhkd \
        -S syncthing \
        -S system76 \
        -S tmux \
        -S trackma \
        -S tty \
        -S uwsm \
        -S vim \
        -S vscode \
        -S xournalpp \
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
        -D foot \
        -D freecad \
        -D fuzzel \
        -D gaming \
        -D gammastep \
        -D geoclue \
        -D ghostty \
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
        -D pkgdev \
        -D playerctl \
        -D qt5 \
        -D redshift \
        -D rofi \
        -D shikane \
        -D snapborg \
        -D ssh \
        -D starship \
        -D swappy \
        -D swayidle \
        -D swaylock \
        -D swaync \
        -D swhkd \
        -D syncthing \
        -D system76 \
        -D tmux \
        -D trackma \
        -D trackpad \
        -D tty \
        -D uwsm \
        -D vim \
        -D vscode \
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
        -R bash \
        -R blender \
        -R brightness \
        -R calibre \
        -R dunst \
        -R dwl \
        -R emacs \
        -R fish \
        -R foot \
        -R freecad \
        -R gaming \
        -R gammastep \
        -R geoclue \
        -R ghostty \
        -R gimp \
        -R git \
        -R gtk \
        -R hyprland \
        -R kitty \
        -R mangal \
        -R mpv \
        -R pactl \
        -R pkgdev \
        -R playerctl \
        -R qt5 \
        -R rofi \
        -R shikane \
        -R snapborg \
        -R ssh \
        -R starship \
        -R swappy \
        -R swayidle \
        -R swaylock \
        -R swhkd \
        -R syncthing \
        -R system76 \
        -R tmux \
        -R trackma \
        -R tty \
        -R uwsm \
        -R vim \
        -R vscode \
        -R xournalpp \
        -R zathura \
        -R zsh

# Update git submodules from remotes
submodule-update:
    git submodule update --init --recursive --remote --progress

# Color Scripts
/bin/bash /opt/shell-color-scripts/colorscript.sh -r

# ALIASES
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# EXPORTS
export EDITOR="code -w"
export TERM=xterm-256color
export XDG_CONFIG_HOME=$HOME/.config

# bobthefish Configuration
set -g theme_display_git yes
set -g theme_display_git_dirty yes
set -g theme_display_git_untracked yes
set -g theme_display_git_ahead_verbose yes
set -g theme_display_git_dirty_verbose yes
set -g theme_display_git_stashed_verbose yes
set -g theme_display_git_master_branch yes
set -g theme_nerd_fonts yes
set -g theme_display_user yes
set -g fish_prompt_pwd_dir_length 0
set -g theme_color_scheme dracula
set -g theme_newline_cursor yes
set -g theme_nerd_fonts yes
set -g theme_title_display_process yes
set -g theme_title_display_user yes
set -g theme_display_hostname yes

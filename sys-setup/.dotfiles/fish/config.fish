# https://wiki.archlinux.org/title/fish
set fish_greeting

set fish_command_timer_enabled 0

set SCRIPT_LOCATION (dirname (status --current-filename))
export CSYS_HOME="$SCRIPT_LOCATION/../../.."
bass source $CSYS_HOME/sys-setup/bash/bashrc/.bashcsysrc fish
bass source $CSYS_HOME/sys-setup/bash/bashrc/.bashSourcerc

alias :q="exit"
status --is-interactive; and source (pyenv init -|psub)
status --is-interactive; and source (rbenv init -|psub)
status --is-interactive; and source (nodenv init -|psub)

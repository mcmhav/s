# https://wiki.archlinux.org/title/fish
set fish_greeting

set fish_command_timer_enabled 0

set SCRIPT_LOCATION (dirname (status --current-filename))
export CSYS_HOME="$SCRIPT_LOCATION/../../.."
bass source $CSYS_HOME/bash/bashrc.d/csys.bashrc fish
bass source $CSYS_HOME/bash/bashrc.d/sourcer.bashrc

alias :q="exit"
status --is-interactive; and source (pyenv init -|psub)
status --is-interactive; and source (rbenv init -|psub)
status --is-interactive; and source (nodenv init -|psub)

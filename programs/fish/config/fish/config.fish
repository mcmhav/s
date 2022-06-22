# https://wiki.archlinux.org/title/fish
set fish_greeting

set fish_command_timer_enabled 0

set SCRIPT_LOCATION (readlink (dirname (status --current-filename)))
set --global CSYS_HOME (realpath "$SCRIPT_LOCATION/../../../..")

bass source $CSYS_HOME/programs/bash/bashrc.d/csys.bashrc fish
bass source $CSYS_HOME/programs/bash/bashrc.d/sourcer.bashrc

status --is-interactive; and type -q pyenv; and source (pyenv init -|psub)
status --is-interactive; and type -q rbenv; and source (rbenv init -|psub)
status --is-interactive; and type -q nodenv; and source (nodenv init -|psub)

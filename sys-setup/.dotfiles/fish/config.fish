# https://wiki.archlinux.org/title/fish
set fish_greeting

set fish_command_timer_enabled 0

set SCRIPT_LOCATION (dirname (status --current-filename))

export CSYS_HOME="$SCRIPT_LOCATION/../../.."
export CSYS_BIN="$CSYS_HOME/bin"
export CSYS_PROGRAMS="$CSYS_HOME/programs"
export CSYS_BASH="$CSYS_HOME/bash"
export CSYS_OS_PATH="$CSYS_HOME/os"

bass source $CSYS_HOME/bash/bashrc.d/csys.bashrc fish
bass source $CSYS_HOME/bash/bashrc.d/sourcer.bashrc

alias :q="exit"
status --is-interactive; and type -q pyenv; and source (pyenv init -|psub)
status --is-interactive; and type -q rbenv; and source (rbenv init -|psub)
status --is-interactive; and type -q nodenv; and source (nodenv init -|psub)

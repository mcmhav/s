# https://wiki.archlinux.org/title/fish
set fish_greeting

set fish_command_timer_enabled 0

set SCRIPT_LOCATION (readlink (dirname (status --current-filename)))

export CSYS_HOME="$SCRIPT_LOCATION/../../../.."
export CSYS_BIN="$CSYS_HOME/bin"
export CSYS_PROGRAMS="$CSYS_HOME/programs"
export CSYS_BASH_HOME="$CSYS_PROGRAMS/bash"
export CSYS_OS_PATH="$CSYS_HOME/os"

bass source $CSYS_BASH_HOME/bashrc.d/csys.bashrc fish
bass source $CSYS_BASH_HOME/bashrc.d/sourcer.bashrc

status --is-interactive; and type -q pyenv; and source (pyenv init -|psub)
status --is-interactive; and type -q rbenv; and source (rbenv init -|psub)
status --is-interactive; and type -q nodenv; and source (nodenv init -|psub)

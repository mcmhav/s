# https://wiki.archlinux.org/title/fish
set fish_greeting

set fish_command_timer_enabled 0

if set -q -g csys_fish_up
  echo "we should be up"
  bass source $CSYS_HOME/programs/bash/bashrc.d/aliases.bashrc
  bass source $CSYS_HOME/programs/bash/bashrc.d/git.bashrc
  exit
end

set SCRIPT_LOCATION (readlink (dirname (status --current-filename)))
set --export CSYS_HOME (realpath "$SCRIPT_LOCATION/../../../..")

test -d "$HOME/.bashrc.d"; and for i in "$HOME/.bashrc.d/"*; bass source "$i"; end
bass source $CSYS_HOME/programs/bash/bashrc.d/csys.bashrc fish
bass source $CSYS_HOME/programs/bash/bashrc.d/sourcer.bashrc

# TODO: Should be set earlier for usage in other scripts
set --export SHELL (which fish)

status --is-interactive; and type -q pyenv; and source (pyenv init -|psub)
status --is-interactive; and type -q rbenv; and source (rbenv init -|psub)
status --is-interactive; and type -q nodenv; and source (nodenv init -|psub)

set --global --export csys_fish_up 1

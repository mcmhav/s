#!/usr/bin/env bash

installStuff() {
  # Todo: Find alternative, issues with git-clone
  # - https://github.com/nvm-sh/nvm/issues/1643
  # - https://github.com/coreybutler/nvm-windows
  # - nodenv seems to be a good alternative, have not tested with windows

  # pyenv
  if [ ! -d "$HOME/.pyenv" ]; then
    git clone https://github.com/pyenv-win/pyenv-win.git "$HOME/.pyenv"
  fi
}

CONFIG_HOME=$(dirname "${BASH_SOURCE[0]}")
RETURN_TO=$(pwd)

cd "$CONFIG_HOME" || exit

installStuff

cd "$RETURN_TO" || exit

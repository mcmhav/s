#!/usr/bin/env bash

export PATH="$CSYS_OS_PATH/win/bin:$PATH"

if [ -d "$HOME/.pyenv" ]; then
  export PATH="$HOME/.pyenv/pyenv-win/bin:$HOME/.pyenv/pyenv-win/shims:$PATH"
fi

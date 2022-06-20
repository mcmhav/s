#!/usr/bin/env bash

export PI_OS="pi"
export LIN_OS="lin"
export MAC_OS="mac"
export WIN_OS="win"
export GITPOD_OS="gitpod"

if [ "$(uname -s)" == "Linux" ]; then
  if [[ "$(uname -m)" =~ armv[0-9]l ]] && [[ "$(uname -n)" =~ pi* ]]; then
    export CSYS_OS="$PI_OS"
  else
    export CSYS_OS="$LIN_OS"
  fi
elif [ "$(uname -s)" == "Darwin" ]; then
  export CSYS_OS="$MAC_OS"
elif [[ "$(uname -s)" =~ MINGW64_NT* ]]; then
  export CSYS_OS="$WIN_OS"
fi

export FISH_SHELL="fish"
export BASH_SHELL="bash"

if [ "$1" == "$FISH_SHELL" ]; then
  export CSYS_SHELL="$FISH_SHELL"
else
  export CSYS_SHELL="$BASH_SHELL"
fi

export CSYS_SHALLOW_FLAG="--shallow"
export CSYS_SHALLOW_SETUP="true"
export CSYS_LOG_LEVEL=4

export CSYS_BIN="$CSYS_HOME/bin"
export CSYS_PROGRAMS="$CSYS_HOME/programs"
export CSYS_BASH_HOME="$CSYS_PROGRAMS/bash"
export CSYS_OS_PATH="$CSYS_HOME/os"

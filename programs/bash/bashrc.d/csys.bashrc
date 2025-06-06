#!/usr/bin/env bash

export PI_OS="lin-pi"
export LIN_OS="lin"
export MAC_OS="mac"
export WIN_OS="win"
export GITPOD_OS="lin-gitpod"
export CODER_OS="lin-coder"

if [ "$(uname -s)" == "Linux" ]; then
    if [[ "$(uname -m)" =~ armv[0-9]l ]] && [[ "$(uname -n)" =~ pi* ]]; then
        export CSYS_OS="$PI_OS"
    elif [ "$CODER" == "true" ]; then
        # Probably a coder
        export CSYS_OS="$CODER_OS"
    elif [ -n "$GITPOD_REPO_ROOT" ]; then
        # Probably a gitpod
        export CSYS_OS="$GITPOD_OS"
    else
        export CSYS_OS="$LIN_OS"
    fi
    export IS_LIN="1"
elif [ "$(uname -s)" == "Darwin" ]; then
    export CSYS_OS="$MAC_OS"
elif [[ "$(uname -s)" =~ MINGW64_NT* ]]; then
    export CSYS_OS="$WIN_OS"
fi

export FISH_SHELL="fish"
export BASH_SHELL="bash"
export ZSH_SHELL="zsh"

case "$1" in
"$FISH_SHELL") export CSYS_SHELL="$FISH_SHELL" ;;
"$ZSH_SHELL") export CSYS_SHELL="$ZSH_SHELL" ;;
*) export CSYS_SHELL="$BASH_SHELL" ;;
esac

export SHALLOW_FLAG_CSYS="--shallow"
export CSYS_SHALLOW_SETUP="true"
export CSYS_LOG_LEVEL=4

export CSYS_BIN="$CSYS_HOME/bin"
export CSYS_PROGRAMS="$CSYS_HOME/programs"
export CSYS_BASH_HOME="$CSYS_PROGRAMS/bash"
export CSYS_OS_PATH="$CSYS_HOME/os"
export CSYS_BASHRC_D="$HOME/.csys.bashrc.d"


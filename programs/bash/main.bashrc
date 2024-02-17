#!/usr/bin/env bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[ -f /etc/shrc ] && source /etc/shrc

[ -n "$CSYS_AUTO_FISH" ] && fish

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
LINK_PATH="$(readlink "$SCRIPT_PATH"/"$(basename "${BASH_SOURCE[0]}")")"
CSYS_BASH_HOME="$(cd "$(dirname "$LINK_PATH")" >/dev/null 2>&1 && pwd)"

export CSYS_HOME="$(realpath "$CSYS_BASH_HOME"/../..)"

if [ -f "$SCRIPT_PATH/csys_env" ]; then
  source "$SCRIPT_PATH/csys_env"
fi

source "$CSYS_BASH_HOME/bashrc.d/csys.bashrc"
source "$CSYS_BASH_HOME/bashrc.d/sourcer.bashrc"

#!/usr/bin/env bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[ -f /etc/shrc ] && source /etc/shrc

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
LINK_PATH="$(readlink "$SCRIPT_PATH"/"$(basename "${BASH_SOURCE[0]}")")"
CONFIG_HOME="$(cd "$(dirname "$LINK_PATH")" >/dev/null 2>&1 && pwd)"

export CSYS_BASH_HOME="$CONFIG_HOME"
export CSYS_HOME="$CONFIG_HOME/../.."
export CSYS_BIN="$CSYS_HOME/bin"
export CSYS_PROGRAMS="$CSYS_HOME/programs"
export CSYS_OS_PATH="$CSYS_HOME/os"

source "$CONFIG_HOME/bashrc.d/csys.bashrc"
source "$CONFIG_HOME/bashrc.d/sourcer.bashrc"

#!/usr/bin/env bash
# shellcheck source=/dev/null

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[ -f /etc/shrc ] && source /etc/shrc

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
LINK_PATH="$(readlink "$SCRIPT_PATH"/"$(basename "${BASH_SOURCE[0]}")")"
CONFIG_HOME="$(cd "$(dirname "$LINK_PATH")" >/dev/null 2>&1 && pwd)"

export CSYS_HOME="$CONFIG_HOME/.."

source "$CONFIG_HOME/bashrc.d/csys.bashrc"
source "$CONFIG_HOME/bashrc.d/sourcer.bashrc"

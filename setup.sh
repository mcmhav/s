#!/bin/bash

CONFIG_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
BASHRC_LOCATION="$HOME/.bashrc.d"
CSYS_HOME="$CONFIG_HOME"

if [ ! -d "$BASHRC_LOCATION" ]; then
  mkdir "$BASHRC_LOCATION"
fi

ln -sf "$CSYS_HOME/sys-setup/bash/.bashrc" "$BASHRC_LOCATION"

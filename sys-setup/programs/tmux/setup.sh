#!/usr/bin/env bash

TMUX_CONFIG_PATH="$HOME/.tmux"

if [ ! -d "$TMUX_CONFIG_PATH" ]; then
  mkdir "$TMUX_CONFIG_PATH"
fi

if [ ! -d "$TMUX_CONFIG_PATH/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

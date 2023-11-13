#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_setup() {
  if ! command -v alacritty >/dev/null; then
    cargo install alacritty
    # brew install --cask alacritty
  fi

  ln -sf "$SCRIPT_PATH/config/alacritty" "$HOME/.config"
}

_setup

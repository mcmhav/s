#!/usr/bin/env bash

PACKAGE_NAME="nvim"

_setup() {
  if ! command -v "$PACKAGE_NAME" >/dev/null; then
    brew install "$PACKAGE_NAME"
  fi

  ln -sf "$SCRIPT_PATH/config/nvim" "$HOME/.config"
}

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_setup


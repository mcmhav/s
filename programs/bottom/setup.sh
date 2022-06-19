#!/usr/bin/env bash

PACKAGE_NAME="bottom"
PACKAGE_COMMAND="btm"
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_setup() {
  if ! command -v "$PACKAGE_COMMAND" >/dev/null; then
    brew install "$PACKAGE_NAME"
  fi

  ln -sf "$SCRIPT_PATH/config/bottom" "$HOME/.config"
}

_setup

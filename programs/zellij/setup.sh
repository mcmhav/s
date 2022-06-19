#!/usr/bin/env bash

PACKAGE_NAME="zellij"
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_setup() {
  if ! command -v "$PACKAGE_NAME" >/dev/null; then
    brew install "$PACKAGE_NAME"
  fi

  ln -sf "$SCRIPT_PATH/config/zellij" "$HOME/.config"
}

_setup

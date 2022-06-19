#!/usr/bin/env bash

_setup() {
  if ! command -v hyper >/dev/null; then
    brew install --cask hyper
  fi

  case "$CSYS_OS" in
  "$WIN_OS") ln -sf --hard "$SCRIPT_PATH/config/.hyper.js" "$HOME/AppData/Roaming/Hyper/.hyper.js" ;;
  *) ln -sf "$SCRIPT_PATH/config/.hyper.js" "$HOME/.hyper.js" ;;
  esac
}

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_setup

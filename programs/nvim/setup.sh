#!/usr/bin/env bash

PACKAGE_NAME="nvim"

_setup() {
  case $CSYS_OS in
    "$GITPOD_OS")
      sudo apt-get install -y neovim
      ;;
    "$MAC_OS")
      if ! command -v "$PACKAGE_NAME" >/dev/null; then
        brew install "$PACKAGE_NAME"
      fi
      ;;
    *)
      echo "Unsupported OS: $CSYS_OS"
      exit 1
      ;;
  esac

  ln -sf "$SCRIPT_PATH/config/nvim" "$HOME/.config"
}

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_setup


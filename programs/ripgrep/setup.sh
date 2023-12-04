#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
PACKAGE_NAME="ripgrep"
PACKAGE_COMMAND="rg"

_setup() {
  case $CSYS_OS in
    "$GITPOD_OS")
      if ! command -v "$PACKAGE_COMMAND" >/dev/null; then
        sudo apt-get install -y "$PACKAGE_NAME"
      fi
      ;;
    "$MAC_OS")
      if ! command -v "$PACKAGE_COMMAND" >/dev/null; then
        brew install "$PACKAGE_NAME"
      fi
      ;;
    *)
      echo "Unsupported OS: $CSYS_OS"
      exit 1
      ;;
  esac
}

_setup


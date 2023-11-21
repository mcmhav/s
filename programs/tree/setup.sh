#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
PACKAGE_NAME="tree"

_setup() {
  case $CSYS_OS in
    "$GITPOD_OS")
      sudo apt-get install -y "$PACKAGE_NAME"
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
}

_setup



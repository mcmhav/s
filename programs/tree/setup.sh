#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
PACKAGE_NAME="tree"

_install(){
  case $CSYS_OS in
    "$GITPOD_OS")
      sudo apt-get install -y "$PACKAGE_NAME"
      ;;
    "$MAC_OS")
      brew install "$PACKAGE_NAME"
      ;;
    *)
      echo "Unsupported OS: $CSYS_OS"
      exit 1
      ;;
  esac
}

_setup() {
  if ! command -v "$PACKAGE_NAME" >/dev/null; then
      _install
  fi
}

_setup



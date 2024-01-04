#!/usr/bin/env bash

PACKAGE_NAME="nvm"
DESIRED_NODE_VERSION="20.10.0"

_with_nvm() {
  if ! command -v "$PACKAGE_NAME" >/dev/null; then
    brew install "$PACKAGE_NAME"
    source "$(brew --prefix nvm)/nvm.sh"
  fi
  if ! nvm ls --no-alias | grep -q "$DESIRED_NODE_VERSION"; then
    nvm install --lts "$DESIRED_NODE_VERSION"
    nvm alias default "$DESIRED_NODE_VERSION"
  fi
}

_setup() {
  case "$CSYS_OS" in
  "$LIN_OS"*) _with_nvm ;;
  "$MAC_OS") _with_nvm ;;
  "*")
    loggit "$PACKAGE_NAME install not implemented for OS: $CSYS_OS"
    ;;
  esac
}

_setup

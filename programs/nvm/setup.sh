#!/usr/bin/env bash

PACKAGE_NAME="nvm"
DESIRED_NODE_VERSION="18.16.0"
NVM_VERSION="0.39.3"

_with_nvm() {
  NVM_DIR="$HOME/.nvm"
  if [ ! -d "$NVM_DIR" ] || [ ! -f "$NVM_DIR/nvm.sh" ]; then
    # brew install "$PACKAGE_NAME"
    mkdir -p "$NVM_DIR"
    cd "$NVM_DIR" || exit
    curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/v$NVM_VERSION/install.sh" | PROFILE=/dev/null bash
  fi
  source "$NVM_DIR/nvm.sh"
  if ! nvm ls --no-alias | grep -q "$DESIRED_NODE_VERSION"; then
    nvm install --lts "$DESIRED_NODE_VERSION"
    nvm alias default "$DESIRED_NODE_VERSION"
  fi
}

_setup() {
  case "$CSYS_OS" in
  "$LIN_OS"*) _with_nvm ;;
  "$MAC_OS") _with_nvm ;;
  *)
    loggit warn "$PACKAGE_NAME install not implemented for OS: $CSYS_OS"
    ;;
  esac
}

_setup

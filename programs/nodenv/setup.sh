#!/bin/bash

PACKAGE_NAME="nodenv"
DESIRED_NODE_VERSION="21.1.0"

_with_nodenv() {
  if ! command -v "$PACKAGE_NAME" >/dev/null; then
    brew install "$PACKAGE_NAME"
  fi
  if ! nodenv versions | grep -q "$DESIRED_NODE_VERSION"; then
    nodenv install "$DESIRED_NODE_VERSION"
    nodenv global "$DESIRED_NODE_VERSION"
  fi
}

_setup() {
  case "$CSYS_OS" in
  "$LIN_OS"*) _with_nodenv ;;
  "$MAC_OS") _with_nodenv ;;
  "*")
    loggit "Node install not implemented for OS: $CSYS_OS"
    ;;
  esac
}

_setup

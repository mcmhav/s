#!/bin/bash

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

DESIRED_NODE_VERSION="16.14.2"

with_nodenv() {
  if [ ! -d "$HOME/.nodenv" ]; then
    curl -fsSL https://raw.githubusercontent.com/nodenv/nodenv-installer/master/bin/nodenv-installer | bash
  fi
  if ! nodenv versions | grep -q "$DESIRED_NODE_VERSION"; then
    nodenv install "$DESIRED_NODE_VERSION"
    nodenv global "$DESIRED_NODE_VERSION"
  fi
}

setup() {
  loggit "Setting up node"

  case "$CSYS_OS" in
  "$LIN_OS") with_nodenv ;;
  "$MAC_OS") with_nodenv ;;
  "*")
    loggit "Node install not implemented for OS: $CSYS_OS"
    ;;
  esac
}

ACTION="$1"
shift
case "$ACTION" in
--setup)
  setup
  ;;
*)
  echo "Action not recognised, $ACTION"
  ;;
esac

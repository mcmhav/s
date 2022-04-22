#!/bin/bash

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

DESIRED_NODE_VERSION="18.0.0"
OLD_NODE_VERSION="16.14.2"

with_nodenv() {
  curl -fsSL https://raw.githubusercontent.com/nodenv/nodenv-installer/master/bin/nodenv-installer | bash
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

  # Install if not present
  # done?
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

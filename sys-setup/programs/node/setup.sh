#!/bin/bash

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

setup() {
  loggit "Setting up node"

  case "$CSYS_OS" in
  "$PI_OS") ./os/pi/setup.sh ;;
  "$LIN_OS")
    ./os/lin/setup.sh
    gui_program_setup
    ;;
  "$MAC_OS")
    ./os/mac/setup.sh
    gui_program_setup
    ;;
  "$WIN_OS")
    ./os/win/setup.sh
    gui_program_setup
    ;;
  esac

  # Check os
  # Check for existing node
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

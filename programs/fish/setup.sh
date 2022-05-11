#!/bin/bash

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

install_deps() {
	"$CSYS_HOME/programs/rbenv/setup.sh" --setup
}

setup() {
	loggit "Setting up node"

	case "$CSYS_OS" in
	"$LIN_OS") install_deps ;;
	"$MAC_OS") install_deps ;;
	"*")
		loggit "Fish not set up for os: $CSYS_OS"
		;;
	esac
}

RETURN_TO=$(pwd)

setup

cd "$RETURN_TO" || exit

#!/bin/bash

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

with_rbenv() {
	if [ ! -d "$HOME/.rbenv" ]; then
		curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
	fi
}

setup() {
	loggit "Setting up ruby"

	case "$CSYS_OS" in
	"$LIN_OS") with_rbenv ;;
	"$MAC_OS") with_rbenv ;;
	"*")
		loggit "Ruby install not implemented for OS: $CSYS_OS"
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

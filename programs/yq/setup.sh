#!/usr/bin/env bash

PACKAGE_NAME="yq"
PACKAGE_COMMAND="yq"
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
VERSION="4.53.6"

_install() {
	case $CSYS_OS in
	"$LIN_OS"*)
		curl -fsSL "https://github.com/mikefarah/yq/releases/download/v$VERSION/yq_linux_amd64" -o /tmp/yq
        chmod +x "/tmp/yq"
		sudo mv "/tmp/yq" /usr/local/bin
		;;
	"$MAC_OS")
		brew install "$PACKAGE_NAME"
		;;
	*)
		echo "Unsupported OS: $CSYS_OS, pgk: $PACKAGE_NAME"
		exit 1
		;;
	esac
}
_setup() {
	if ! command -v "$PACKAGE_COMMAND" >/dev/null; then
		_install
	fi
}

_setup

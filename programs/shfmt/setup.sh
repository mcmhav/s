#!/usr/bin/env bash

PACKAGE_NAME="shfmt"
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
VERSION="3.10.0"

_install() {
	case $CSYS_OS in
	"$LIN_OS"*)
		curl -fsSL "https://github.com/mvdan/sh/releases/download/v$VERSION/shfmt_v${VERSION}_linux_amd64" -o /tmp/shfmt
        chmod +x /tmp/shfmt
		sudo mv /tmp/shfmt /usr/local/bin
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
	if ! command -v "$PACKAGE_NAME" >/dev/null; then
		_install
	fi
}

_setup

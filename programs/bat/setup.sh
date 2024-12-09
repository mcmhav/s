#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
PACKAGE_NAME="bat"
_VERSION="0.24.0"

_install() {
	case $CSYS_OS in
	"$GITPOD_OS")
		curl -fsSL "https://github.com/sharkdp/bat/releases/download/v$_VERSION/bat-v$_VERSION-x86_64-unknown-linux-musl.tar.gz" | tar -xz -C /tmp
		cp "/tmp/bat-v$_VERSION-x86_64-unknown-linux-musl/bat" ~/.local/bin
		;;
	"$MAC_OS")
		brew install "$PACKAGE_NAME"
		;;
	*)
		echo "Unsupported OS: $CSYS_OS"
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

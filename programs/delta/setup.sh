#!/usr/bin/env bash

PACKAGE_NAME="git-delta"
PACKAGE_COMMAND="delta"
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
VERSION="0.18.2"

_install() {
	case $CSYS_OS in
	"$LIN_OS"*)
		curl -fsSL "https://github.com/dandavison/delta/releases/download/$VERSION/delta-$VERSION-x86_64-unknown-linux-gnu.tar.gz" | tar -xz -C /tmp
		sudo mv "/tmp/delta-$VERSION-x86_64-unknown-linux-gnu/delta" /usr/local/bin
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

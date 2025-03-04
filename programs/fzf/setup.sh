#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
PACKAGE_NAME="fzf"

_install() {
	case $CSYS_OS in
    "$LIN_OS"*)
		VERSION="0.60.0"
        ARCH="amd64"
        if [ uname -m == "aarch64" ]; then
            ARCH="arm64"
        fi
		URL="https://github.com/junegunn/fzf/releases/download/v$VERSION/fzf-$VERSION-linux_${ARCH}.tar.gz"
		curl -fsSL "$URL" | tar -xz -C /tmp
		sudo mv /tmp/fzf /usr/local/bin
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

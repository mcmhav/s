#!/usr/bin/env bash

PACKAGE_NAME="terraform-ls"
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
VERSION="0.36.0"

_install() {
	case $CSYS_OS in
	"$LIN_OS"*)
		curl -fsSL "https://releases.hashicorp.com/terraform-ls/$VERSION/terraform-ls_${VERSION}_linux_amd64.zip" | tar -xz -C /tmp/tf-ls.zip
		unzip -qo /tmp/tf-ls.zip -d /tmp/tf-ls
		sudo mv /tmp/tf-ls/terraform-ls /usr/local/bin
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

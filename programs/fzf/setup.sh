#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
PACKAGE_NAME="fzf"
VERSION="0.60.3"

_install() {
	case $CSYS_OS in
    "$LIN_OS"*)
        local arch
        case "$(csys release --arch)" in
        x86_64) arch="amd64" ;;
        aarch64) arch="arm64" ;;
        armv7 | armv6) arch="$(csys release --arch)" ;;
        *)
            loggit warn "$PACKAGE_NAME: no prebuilt release for $(uname -m), skipping"
            return 0
            ;;
        esac
		csys release fzf "$VERSION" \
			"https://github.com/junegunn/fzf/releases/download/v{version}/fzf-{version}-linux_$arch.tar.gz"
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

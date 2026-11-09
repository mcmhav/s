#!/usr/bin/env bash

PACKAGE_NAME="bat"
# renovate: datasource=github-releases depName=sharkdp/bat extractVersion=^v(?<version>.+)$
_VERSION="0.25.0"

_install() {
	case $CSYS_OS in
    "$LIN_OS"*)
        local target
        case "$(csys release --arch)" in
        x86_64) target="x86_64-unknown-linux-musl" ;;
        aarch64) target="aarch64-unknown-linux-musl" ;;
        armv7 | armv6) target="arm-unknown-linux-musleabihf" ;;
        i686) target="i686-unknown-linux-musl" ;;
        *)
            loggit warn "$PACKAGE_NAME: no prebuilt release for $(uname -m), skipping"
            return 0
            ;;
        esac
		csys release bat "$_VERSION" \
			"https://github.com/sharkdp/bat/releases/download/v{version}/bat-v{version}-$target.tar.gz" \
			"bat-v{version}-$target/bat"
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

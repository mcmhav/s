#!/usr/bin/env bash

PACKAGE_NAME="git-delta"
PACKAGE_COMMAND="delta"
# renovate: datasource=github-releases depName=dandavison/delta
VERSION="0.19.2"

_install() {
	case $CSYS_OS in
	"$LIN_OS"*)
		local target
		case "$(csys release --arch)" in
		x86_64) target="x86_64-unknown-linux-gnu" ;;
		aarch64) target="aarch64-unknown-linux-gnu" ;;
		armv7 | armv6) target="arm-unknown-linux-gnueabihf" ;;
		i686) target="i686-unknown-linux-gnu" ;;
		*)
			loggit warn "$PACKAGE_COMMAND: no prebuilt release for $(uname -m), skipping"
			return 0
			;;
		esac
		csys release delta "$VERSION" \
			"https://github.com/dandavison/delta/releases/download/{version}/delta-{version}-$target.tar.gz" \
			"delta-{version}-$target/delta"
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

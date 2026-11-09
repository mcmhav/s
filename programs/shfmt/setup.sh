#!/usr/bin/env bash

PACKAGE_NAME="shfmt"
# renovate: datasource=github-releases depName=mvdan/sh extractVersion=^v(?<version>.+)$
VERSION="3.10.0"

_install() {
	case $CSYS_OS in
	"$LIN_OS"*)
		csys release shfmt "$VERSION" \
			"https://github.com/mvdan/sh/releases/download/v{version}/shfmt_v{version}_linux_{goarch}"
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

#!/usr/bin/env bash

PACKAGE_NAME="terraform-ls"
# renovate: datasource=github-releases depName=hashicorp/terraform-ls extractVersion=^v(?<version>.+)$
VERSION="0.36.0"

_install() {
	case $CSYS_OS in
	"$LIN_OS"*)
		csys release terraform-ls "$VERSION" \
			"https://releases.hashicorp.com/terraform-ls/{version}/terraform-ls_{version}_linux_{goarch}.zip"
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

#!/usr/bin/env bash

PACKAGE_NAME="yq"
PACKAGE_COMMAND="yq"
# renovate: datasource=github-releases depName=mikefarah/yq extractVersion=^v(?<version>.+)$
VERSION="4.54.2"

_install() {
  case $CSYS_OS in
  "$LIN_OS"*)
    csys release yq "$VERSION" \
      "https://github.com/mikefarah/yq/releases/download/v{version}/yq_linux_{goarch}"
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

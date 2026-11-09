#!/usr/bin/env bash

PACKAGE_NAME="process-compose"
# renovate: datasource=github-releases depName=F1bonacc1/process-compose
VERSION="v1.78.0"

_install() {
  case $CSYS_OS in
  "$LIN_OS"*)
    # linux_arm is built with GOARM=6, so it also runs on a Pi Zero
    csys release process-compose "$VERSION" \
      "https://github.com/F1bonacc1/process-compose/releases/download/{version}/process-compose_linux_{goarch}.tar.gz"
    ;;
  "$MAC_OS")
    curl -fsSL https://github.com/F1bonacc1/process-compose/releases/download/$VERSION/process-compose_darwin_amd64.tar.gz | tar -xz -C /tmp
    mv /tmp/process-compose "$HOME/.local/bin"
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

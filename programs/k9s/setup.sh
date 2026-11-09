#!/usr/bin/env bash

PACKAGE_NAME="k9s"
# renovate: datasource=github-releases depName=derailed/k9s
VERSION="v0.31.7"

_install_release() {
  local arch
  case "$(csys release --arch)" in
  x86_64) arch="amd64" ;;
  aarch64) arch="arm64" ;;
  armv7) arch="armv7" ;;
  *)
    # e.g. armv6 (Pi Zero): no release asset
    loggit warn "$PACKAGE_NAME: no prebuilt release for $(uname -m), skipping"
    return
    ;;
  esac
  csys release k9s "$VERSION" \
    "https://github.com/derailed/k9s/releases/download/{version}/k9s_Linux_$arch.tar.gz"
}

_install() {
  case $CSYS_OS in
  "$LIN_OS"*)
    _install_release
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

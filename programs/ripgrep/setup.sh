#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
PACKAGE_NAME="ripgrep"
PACKAGE_COMMAND="rg"
# renovate: datasource=github-releases depName=BurntSushi/ripgrep
VERSION="14.1.1"

_install_release() {
  local target
  case "$(csys release --arch)" in
    x86_64) target="x86_64-unknown-linux-musl" ;;
    aarch64) target="aarch64-unknown-linux-gnu" ;;
    armv7) target="armv7-unknown-linux-musleabihf" ;;
    i686) target="i686-unknown-linux-gnu" ;;
    *)
      # e.g. armv6 (Pi Zero): no release asset, use the distro package instead
      if command -v apt-get >/dev/null; then
        sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -qq "$PACKAGE_NAME" >/dev/null
      else
        loggit warn "$PACKAGE_NAME: no prebuilt release for $(uname -m), skipping"
      fi
      return
      ;;
  esac
  csys release ripgrep "$VERSION" \
    "https://github.com/BurntSushi/ripgrep/releases/download/{version}/ripgrep-{version}-$target.tar.gz" \
    "ripgrep-{version}-$target/rg"
}

_setup() {
  case $CSYS_OS in
    "$LIN_OS"*)
      if ! command -v "$PACKAGE_COMMAND" >/dev/null; then
          _install_release
      fi
      ;;
    "$GITPOD_OS")
      if ! command -v "$PACKAGE_COMMAND" >/dev/null; then
        sudo apt-get install -y "$PACKAGE_NAME"
      fi
      ;;
    "$MAC_OS")
      if ! command -v "$PACKAGE_COMMAND" >/dev/null; then
        brew install "$PACKAGE_NAME"
      fi
      ;;
    *)
      loggit warn "Unsupported OS: $CSYS_OS"
      exit 1
      ;;
  esac
}

_setup

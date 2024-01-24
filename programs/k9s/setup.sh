#!/usr/bin/env bash

PACKAGE_NAME="k9s"
VERSION="v0.31.7"

_install() {
  case $CSYS_OS in
    "$LIN_OS"*)
      curl -fsSL https://github.com/derailed/k9s/releases/download/$VERSION/k9s_Freebsd_amd64.tar.gz | tar -xz -C /tmp
      sudo mv /tmp/k9s /usr/local/bin
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

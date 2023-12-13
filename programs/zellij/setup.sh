#!/usr/bin/env bash

PACKAGE_NAME="zellij"
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
VERSION="v0.39.2"

_install() {
  case $CSYS_OS in
    "$LIN_OS"*)
      curl -fsSL https://github.com/zellij-org/zellij/releases/download/$VERSION/zellij-x86_64-unknown-linux-musl.tar.gz | tar -xz -C /tmp
      sudo mv /tmp/zellij /usr/local/bin
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

  ln -sf "$SCRIPT_PATH/config/zellij" "$HOME/.config"
}

_setup

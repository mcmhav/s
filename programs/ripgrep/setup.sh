#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
PACKAGE_NAME="ripgrep"
PACKAGE_COMMAND="rg"
VERSION="14.1.1"

_setup() {
  case $CSYS_OS in
    "$LIN_OS"*)
      if ! command -v "$PACKAGE_COMMAND" >/dev/null; then
          ARCH=$(uname -m)
          RG_NAME="ripgrep-${VERSION}-${ARCH}-unknown-linux-gnu"
          if [ "$ARCH" == "x86_64" ]; then
              RG_NAME="ripgrep-${VERSION}-x86_64-unknown-linux-musl"
          fi
          curl -fsSL https://github.com/BurntSushi/ripgrep/releases/download/${VERSION}/${RG_NAME}.tar.gz | tar -xz -C /tmp
          sudo mv /tmp/${RG_NAME}/rg /usr/local/bin
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
      echo "Unsupported OS: $CSYS_OS"
      exit 1
      ;;
  esac
}

_setup


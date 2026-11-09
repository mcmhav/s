#!/usr/bin/env bash

PACKAGE_NAME="zellij"
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
# renovate: datasource=github-releases depName=zellij-org/zellij extractVersion=^v(?<version>.+)$
VERSION="0.39.2"

_install() {
  case $CSYS_OS in
    "$LIN_OS"*)
      case "$(csys release --arch)" in
        x86_64 | aarch64)
          csys release zellij "$VERSION" \
            "https://github.com/zellij-org/zellij/releases/download/v{version}/zellij-{arch}-unknown-linux-musl.tar.gz"
          ;;
        *)
          loggit warn "$PACKAGE_NAME: no prebuilt release for $(uname -m), skipping"
          ;;
      esac
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

  ln -sf "$SCRIPT_PATH/config/zellij" "$HOME/.config"
}

_setup

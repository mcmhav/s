#!/usr/bin/env bash

PACKAGE_NAME="ty"
# renovate: datasource=github-releases depName=astral-sh/ty
VERSION="0.0.99"

_install() {
  case $CSYS_OS in
    "$LIN_OS"*)
      local target
      case "$(csys release --arch)" in
        x86_64 | aarch64 | i686) target="$(csys release --arch)-unknown-linux-musl" ;;
        armv7) target="armv7-unknown-linux-musleabihf" ;;
        armv6) target="arm-unknown-linux-musleabihf" ;;
        *)
          loggit warn "$PACKAGE_NAME: no prebuilt release for $(uname -m), skipping"
          return 0
          ;;
      esac
      csys release "$PACKAGE_NAME" "$VERSION" \
        "https://github.com/astral-sh/ty/releases/download/{version}/ty-$target.tar.gz" \
        "ty-$target/ty"
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

#!/usr/bin/env bash

PACKAGE_NAME="prek"
# renovate: datasource=github-releases depName=j178/prek extractVersion=^v(?<version>.+)$
VERSION="0.5.10"

_install() {
  case $CSYS_OS in
  "$LIN_OS"*)
    local target
    case "$(csys release --arch)" in
    x86_64 | aarch64) target="$(csys release --arch)-unknown-linux-musl" ;;
    *)
      # e.g. a Pi: no prebuilt release
      loggit warn "$PACKAGE_NAME: no prebuilt release for $(uname -m), skipping"
      return 0
      ;;
    esac
    csys release "$PACKAGE_NAME" "$VERSION" \
      "https://github.com/j178/prek/releases/download/v{version}/prek-$target.tar.gz" \
      "prek-$target/prek"
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

# Run the dotfiles' own hooks (.pre-commit-config.yaml) on every commit to them.
_install_hook() {
  command -v prek >/dev/null || return 0
  cd "$CSYS_HOME" 2>/dev/null || return 0
  git rev-parse --git-dir >/dev/null 2>&1 || return 0
  if ! grep -qs prek "$(git rev-parse --git-path hooks/pre-commit)"; then
    prek install
  fi
}

_setup() {
  if ! command -v "$PACKAGE_NAME" >/dev/null; then
    _install
  fi
  _install_hook
}

_setup

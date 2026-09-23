#!/usr/bin/env bash

PACKAGE_NAME="uv"
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_install() {
  case $CSYS_OS in
    "$LIN_OS"*)
      pip install uv
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

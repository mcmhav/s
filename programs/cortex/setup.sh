#!/usr/bin/env bash

PACKAGE_NAME="cortex"
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_install() {
  case $CSYS_OS in
    "$LIN_OS"*)
      ARCH=$(uname -m)
      curl -LsS https://ai.snowflake.com/static/cc-scripts/install.sh | sh
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

  mkdir -p "$HOME/.snowflake/cortex"
  ln -sf "$SCRIPT_PATH/config/settings.json" "$HOME/.snowflake/cortex/settings.json"
  ln -sf "$SCRIPT_PATH/config/cortex.json" "$HOME/.snowflake/cortex/cortex.json"
}

_setup

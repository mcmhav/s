#!/usr/bin/env bash
# Zed installs its own remote server into ~/.zed_server on connect. The file name includes the client
# build (e.g. zed-remote-server-stable-1.26.2+stable.384.<sha>), so it can't be prefetched from the
# version alone. On Coder, ~/.zed_server is persisted instead (see os/lin-coder/setup.sh).

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_setup() {
  mkdir -p "$HOME/.config/zed"
  ln -sf "$SCRIPT_PATH/config/settings.json" "$HOME/.config/zed/settings.json"
}

_setup

#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# Tool state that should survive workspace rebuilds lives on the persistent volume under
# /workspace/.home, mirroring the paths under $HOME (~/<path> -> /workspace/.home/<path>).
PERSIST_HOME="/workspace/.home"

_persist() {
  # Link ~/<path> to /workspace/.home/<path>. Links the directory, not single files: tools like fish
  # save by renaming a temp file over the original, which would replace a file symlink.
  local rel="$1"
  local persist="$PERSIST_HOME/$rel"
  local target="$HOME/$rel"
  mkdir -p "$persist" "$(dirname "$target")"
  if [ -d "$target" ] && [ ! -L "$target" ]; then
    # Keep anything written before the link existed; already persisted files win.
    cp -a --update=none "$target/." "$persist/" 2>/dev/null || true
    rm -rf "$target"
  fi
  ln -sfn "$persist" "$target"
}
_setup_persisted_state() {
  _persist ".config/github-copilot"          # Copilot (editor/LSP) auth
  _persist ".copilot"                        # Copilot CLI home (config.json, logs/)
  _persist ".local/share/fish"               # fish_history
  _persist ".snowflake/cortex/conversations" # Cortex Code conversations
  _persist ".local/share/csys"               # `csys release` downloads, so restarts skip GitHub
  _persist ".zed_server"                     # remote server Zed installs on connect
  _persist ".local/share/uv/tools"           # `uv tool install` venvs (see _link_uv_tools)
  chmod 700 "$PERSIST_HOME/.local/share/fish"
  # Each Zed version leaves a ~110 MB server behind; keep the two newest.
  find "$PERSIST_HOME/.zed_server" -maxdepth 1 -type f -name 'zed-remote-server-*' -printf '%T@ %p\n' |
    sort -rn | tail -n +3 | cut -d' ' -f2- | xargs -r -d '\n' rm -f
  _link_uv_tools
}
_link_uv_tools() {
  # The persisted tool venvs survive restarts, but their executables in ~/.local/bin don't.
  # Recreate them from each tool's receipt, like `uv tool install` does.
  local tools="$HOME/.local/share/uv/tools" receipt tool name dest
  for receipt in "$tools"/*/uv-receipt.toml; do
    [ -f "$receipt" ] || continue
    tool="$(basename "$(dirname "$receipt")")"
    if [ ! -e "$tools/$tool/bin/python" ]; then
      # Venvs use the image's pyenv Python; a new image version can remove it.
      loggit warn "uv tool $tool: Python is gone, run: uv tool install --reinstall $tool"
    fi
    sed -nE 's/.*name = "([^"]+)", install-path = "([^"]+)".*/\1 \2/p' "$receipt" |
      while read -r name dest; do
        mkdir -p "$(dirname "$dest")"
        ln -sfn "$tools/$tool/bin/$name" "$dest"
      done
  done
}
_setup_buildx_cache() {
  # Keep the buildx "builders" layer cache on /workspace (see /workspace/.home/bin/buildx-persist).
  # Docker (DinD) may still be starting, so wait for it in the background.
  local bin="$PERSIST_HOME/bin/buildx-persist"
  local dir="$PERSIST_HOME/.local/share/buildkit"
  if [ -x "$bin" ]; then
    mkdir -p "$dir"
    nohup "$bin" --wait 300 >"$dir/startup.log" 2>&1 &
  fi
}
_setup() {
  export CSYS_LOG_LEVEL=5
  export CSYS_SHALLOW_SETUP="true"

  _setup_persisted_state
  _setup_buildx_cache

  export VS_CODE_SETTINGS_LOCATION="$HOME/.vscode-server/data/Machine/"
  csys install vs-code-server-config &

  export VS_CODE_SETTINGS_LOCATION="$HOME/.local/share/code-server/Machine/"
  csys install vs-code-server-config &
  # sudo apt-get update
  # loggit "Installing brew"
  # csys install brew
  loggit "Installing csys-reqs"
  csys reqs-install "$SCRIPT_PATH/reqs"

  # sudo apt-get install -y mariadb-client
  # pip install "uv<1.0.0"
  # uv tool install ruff@latest

  echo 'if [ -f "$HOME/.bashrc" ]; then source "$HOME/.bashrc"; fi' >>"$HOME/.bash_profile"

  cat "$SCRIPT_PATH/config/browser-open" >"/usr/local/bin/browser-override"
  sudo tee -a "/usr/local/bin/xdg-open" <"$SCRIPT_PATH/config/browser-open" >/dev/null

  if ! command -v nc >/dev/null; then
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -qq netcat-openbsd >/dev/null
  fi
}

_setup

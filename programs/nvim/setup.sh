#!/usr/bin/env bash

PACKAGE_NAME="nvim"
# renovate: datasource=github-releases depName=neovim/neovim extractVersion=^v(?<version>.+)$
NVIM_VERSION="0.12.6"

_install_from_tar() {
  local arch
  case "$(csys release --arch)" in
  x86_64) arch="x86_64" ;;
  aarch64) arch="arm64" ;;
  *)
    loggit warn "$PACKAGE_NAME: no prebuilt release for $(uname -m), skipping"
    return 0
    ;;
  esac
  csys release nvim "$NVIM_VERSION" \
    "https://github.com/neovim/neovim/releases/download/v{version}/nvim-linux-$arch.tar.gz" \
    "nvim-linux-$arch/bin/nvim"
}

_setup() {
  case $CSYS_OS in
  "$LIN_OS"*)
    if ! command -v "$PACKAGE_NAME" >/dev/null; then
      _install_from_tar
    else
      CURRENT_VERSION=$(nvim --version | head -n 1 | awk '{print $2}')
      if ! echo -e "v$NVIM_VERSION\n$CURRENT_VERSION" | sort -V -C; then
        _install_from_tar
      fi
    fi
    ;;
  "$MAC_OS")
    if ! command -v "$PACKAGE_NAME" >/dev/null; then
      brew install "$PACKAGE_NAME"
    fi
    ;;
  *)
    loggit warn "Unsupported OS: $CSYS_OS"
    exit 1
    ;;
  esac

  ln -sf "$SCRIPT_PATH/config/nvim" "$HOME/.config"
}

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

_setup

#!/usr/bin/env bash

# pyenv
export PYENV_ROOT="$HOME/.pyenv"

# go sgit
export GOPATH="$HOME/.go"

case "$CSYS_OS" in
"$PI_OS") export GOROOT=/usr/lib/go ;;
"$LIN_OS") export GOROOT="$HOME/go" ;;
"$MAC_OS") export GOROOT=/usr/local/opt/go/libexec ;;
"$WIN_OS") export GOROOT=/usr/local/opt/go/libexec ;;
*) export GOROOT=/usr/local/opt/go/libexec ;;
esac

# android
export ANDROID_HOME="/usr/local/share/android-sdk"

# path stuff
PATHS=(
  # "$HOME/.pyenv/shims"
  "/git/tools/bin"
  "$PATH"
  "/usr/local/bin"
  "$GOPATH/bin"
  "$GOROOT/bin"
  "/usr/local/opt/python/libexec/bin"
  "$PYENV_ROOT/bin"
  "$CSYS_BIN"
  "$HOME/.poetry/bin"
  "$HOME/.nodenv/bin"
  "$HOME/.nodenv/shims"
  "$HOME/.cargo/bin"
  "$HOME/.csys.bashrc.d/bin"
  "/home/linuxbrew/.linuxbrew/bin"
)
PATH=$(printf '%s:' "${PATHS[@]%}" | sed 's/:$//')
if [ -n "$(command -v ruby)" ]; then
  PATH=$PATH:"$(ruby -r rubygems -e "puts Gem.user_dir")/bin"
fi
export PATH=$PATH

# gcloud currently needs python 2
export CLOUDSDK_PYTHON="$HOME/.pyenv/versions/2.7.16/bin/python"

# Pipenv
export PIPENV_YES="yes"

export WAKATIME_HOME="$HOME/.wakatime"

export XDG_CONFIG_HOME="$HOME/.config"

export SHELLCHECK_OPTS="--external-sources"

# Language
export LANG='en_US.UTF-8'
export LC_ALL="en_US.UTF-8"

# Rust
export CARGO_NET_GIT_FETCH_WITH_CLI=true

# fzf
export FZF_DEFAULT_COMMAND='ag --hidden --unrestricted --ignore .git -f -g ""'

if command -v bat 1>/dev/null 2>&1; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

potential_editors=(
  "nvim"
  "vim"
  "vi"
  "nano"
)
for potential_editor in "${potential_editors[@]}"; do
  if command -v "$potential_editor" 1>/dev/null 2>&1; then
    export EDITOR="$potential_editor"
    break
  fi
done

# Notrack
export DO_NOT_TRACK=1

# Bat
export BAT_THEME="Dracula"

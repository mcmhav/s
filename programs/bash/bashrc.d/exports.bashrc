#!/usr/bin/env bash

# pyenv
if [ -z "$PYENV_ROOT" ] || [ ! -d "$PYENV_ROOT" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
fi

# go sgit
export GOPATH="$HOME/.go"

# case "$CSYS_OS" in
# "$PI_OS") export GOROOT=/usr/lib/go ;;
# "$LIN_OS") export GOROOT="$HOME/go" ;;
# "$GITPOD_OS") export GOROOT="$HOME/go" ;;
# "$MAC_OS") export GOROOT=/usr/local/opt/go/libexec ;;
# "$WIN_OS") export GOROOT=/usr/local/opt/go/libexec ;;
# *) export GOROOT=/usr/local/opt/go/libexec ;;
# esac

# android
export ANDROID_HOME="/usr/local/share/android-sdk"

# path stuff
PATHS=(
    # "$HOME/.pyenv/shims"
    "$CSYS_BIN"
    "/git/tools/bin"
    "$PATH"
    "/usr/local/bin"
    "$GOPATH/bin"
    # "$GOROOT/bin"
    "/usr/local/opt/python/libexec/bin"
    "$PYENV_ROOT/bin"
    "$HOME/.poetry/bin"
    # "$HOME/.nodenv/bin"
    # "$HOME/.nodenv/shims"
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
export CLOUDSDK_PYTHON="$HOME/.pyenv/shims/python"

# Pipenv
export PIPENV_YES="yes"

export XDG_CONFIG_HOME="$HOME/.config"

export SHELLCHECK_OPTS="--external-sources"

# Language
export LANG='en_US.UTF-8'
export LC_ALL="en_US.UTF-8"

# Rust
export CARGO_NET_GIT_FETCH_WITH_CLI=true

# fzf
export FZF_DEFAULT_COMMAND='__file_search'
export FZF_DEFAULT_OPTS="--no-mouse"

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

# Brew
# export HOMEBREW_NO_INSTALL_FROM_API=1
export HOMEBREW_NO_ENV_HINTS=1

# Git
export GIT_EDITOR="vim"

# aws
export AWS_PAGER=""
export AWS_MAX_ATTEMPTS="20"
export AWS_RETRY_MODE="adaptive"

# nvm
if ! command -v nvm >/dev/null; then
    export NVM_DIR="$HOME/.nvm"
    node_versions=("$NVM_DIR"/versions/node/*)
    if [[ "${#node_versions[@]}" -gt 0 ]]; then
        PATH="$PATH:${node_versions[$((${#node_versions[@]} - 1))]}/bin"
    fi
    if [ -d "$NVM_DIR/nvm.sh" ]; then
        # load the real nvm on first use
        nvm() {
            # shellcheck disable=SC1090,SC1091
            source "$NVM_DIR"/nvm.sh
            nvm "$@"
        }
    fi
fi

# prefect
export PREFECT_CLI_PROMPT=false

# terraform
export TF_CLI_ARGS_plan="-lock=false"
# export TF_CLI_ARGS_plan="-refresh=false -lock=false"

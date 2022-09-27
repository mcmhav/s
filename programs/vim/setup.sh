#!/usr/bin/env bash

COC_HOME="$HOME/.config/coc/extensions"

link_config() {
  if [ ! -d "$HOME/.vim" ]; then
    mkdir "$HOME/.vim"
  fi
  LOCAL_CONFIG_PATH="$SCRIPT_PATH/config"

  ln -sf "$LOCAL_CONFIG_PATH"/*.vim "$HOME"/.vim

  if [ ! -d "$HOME/.vim/colors" ]; then
    mkdir "$HOME/.vim/colors"
  fi
  if [ ! -d "$HOME/.vim/after/syntax" ]; then
    mkdir -p "$HOME/.vim/after/syntax"
  fi
  if [ ! -d "$HOME/.vim/sessions" ]; then
    mkdir "$HOME/.vim/sessions"
  fi
  if [ ! -d "$HOME/.vim/autoload" ]; then
    mkdir "$HOME/.vim/autoload"
  fi
  ln -sf "$LOCAL_CONFIG_PATH/colors/cake.vim" "$HOME/.vim/colors/cake.vim"
  ln -sf "$LOCAL_CONFIG_PATH/colors/gruvbox.vim" "$HOME/.vim/colors/gruvbox.vim"
  ln -sf "$LOCAL_CONFIG_PATH/colors/gruvbox-material.vim" "$HOME/.vim/colors/gruvbox-material.vim"
  ln -sf "$LOCAL_CONFIG_PATH/colors/dracula.vim" "$HOME/.vim/colors/dracula.vim"
  ln -sf "$LOCAL_CONFIG_PATH/autoload/dracula.vim" "$HOME/.vim/autoload/dracula.vim"
  ln -sf "$LOCAL_CONFIG_PATH/colors/syntax/"* "$HOME/.vim/after/syntax"
  ln -sf "$LOCAL_CONFIG_PATH/.vimrc" "$HOME/.vimrc"

  mkdir -p "$COC_HOME"
  ln -sf "$LOCAL_CONFIG_PATH/coc-package.json" "$COC_HOME/package.json"
}

setup_plugins() {
  if [ ! -d "$HOME/.vim/autoload" ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi

  {
    vim +PlugInstall +qall 1>/dev/null 2>&1
    vim +PlugUpgrade +qall 1>/dev/null 2>&1
    vim +PlugUpdate +qall 1>/dev/null 2>&1
    (
      cd "$COC_HOME" &&
        npm install --global-style --legacy-bundling --legacy-peer-deps --no-package-lock --ignore-scripts --no-lockfile --production --legacy-peer-deps --no-global 1>/dev/null 2>&1
    )
  } &
}

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
RETURN_TO=$(pwd)

link_config
setup_plugins

cd "$RETURN_TO" || exit

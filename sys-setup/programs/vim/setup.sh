#!/usr/bin/env bash

link_config() {
  LOCAL_CONFIG_PATH="$CSYS_HOME/sys-setup/programs/vim/config"

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
  ln -sf "$LOCAL_CONFIG_PATH/colors/cake.vim" "$HOME/.vim/colors/cake.vim"
  ln -sf "$LOCAL_CONFIG_PATH/colors/syntax/"* "$HOME/.vim/after/syntax"
}

setup_plugins() {
  if [ ! -d "$VIM_BUNDLE_PATH" ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  else
    cd "$VIM_BUNDLE_PATH" || exit
    git pull
  fi

  if [ ! -d "$HOME/.vim/autoload" ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi

  vim +PlugInstall +qall
}

VIM_BUNDLE_PATH="$HOME/.vim/bundle/Vundle.vim"
RETURN_TO=$(pwd)

link_config
setup_plugins

cd "$RETURN_TO" || exit

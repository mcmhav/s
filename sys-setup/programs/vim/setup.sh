#!/usr/bin/env bash

VIM_PATH="$HOME/.vim/bundle/Vundle.vim"
RETURN_TO=$(pwd)

if [ ! -d "$VIM_PATH" ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
else
  cd "$VIM_PATH" || exit
  git pull
fi

vim +PluginInstall +qall

cd "$RETURN_TO" || exit

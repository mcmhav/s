#!/usr/bin/env bash

VIM_BUNDLE_PATH="$HOME/.vim/bundle/Vundle.vim"
RETURN_TO=$(pwd)

if [ ! -d "$VIM_BUNDLE_PATH" ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
else
  cd "$VIM_BUNDLE_PATH" || exit
  git pull
fi

if [ ! -d "$HOME/.vim/autoload" ]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [ ! -d "$HOME/.vim/colors" ]; then
  mkdir "$HOME/.vim/colors"
  ln -sf "$CSYS_HOME/sys-setup/programs/vim/colors/cake.vim" "$HOME/.vim/colors"
fi

vim +PluginInstall +qall
vim +PlugInstall +qall

cd "$RETURN_TO" || exit

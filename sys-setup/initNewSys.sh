#!/usr/bin/env bash

export CSYS_HOME="$HOME/r/s"

ln -sf $CSYS_HOME/sys-setup/bash/.bashrc ~/.bashrc;
ln -sf $CSYS_HOME/sys-setup/bash/.bashrc ~/.bash_profile;
ln -sf $CSYS_HOME/sys-setup/.dotfiles/.vimrc ~/.vimrc;
ln -sf $CSYS_HOME/sys-setup/.dotfiles/.gitconfig ~/.gitconfig;
ln -sf $CSYS_HOME/sys-setup/.dotfiles/.gitignore ~/.gitignore;

CONFIG_HOME="$CSYS_HOME/sys-setup"
RETURN_TO=$(pwd)

cd $CONFIG_HOME || exit

if [ "$(uname -s)" == "Linux" ]; then
	./os/lin/setup.sh
elif [ "$(uname -s)" == "Darwin" ]; then
  ./os/mac/setup.sh
elif [ "$(uname -s)" == "MINGW64_NT-10.0" ]; then
  ./os/win/setup.sh
fi

programs/atom/setup.sh --install
# programs/subl/setup.sh # not using
programs/vim/setup.sh
programs/vscode/setup.sh --install

cd $RETURN_TO || exit

# Apps:
#   python

# function:
# npm installs:
#   bower
#
#   gulp
#   jshint
#   yo
#   eslint
#   babel-eslint
#   n
#	node-notifier

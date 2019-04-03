#!/usr/bin/env bash

export CSYS_HOME="$HOME/r/s"

non_gui_config() {
  ln -sf $CSYS_HOME/sys-setup/bash/.bashrc ~/.bashrc
  ln -sf $CSYS_HOME/sys-setup/bash/.bashrc ~/.bash_profile

  ln -sf $CSYS_HOME/sys-setup/.dotfiles/.vimrc ~/.vimrc
  ln -sf $CSYS_HOME/sys-setup/.dotfiles/.gitconfig ~/.gitconfig
  ln -sf $CSYS_HOME/sys-setup/.dotfiles/.gitignore ~/.gitignore
  ln -sf $CSYS_HOME/sys-setup/.dotfiles/.eslintrc.js ~/.eslintrc.js
  ln -sf $CSYS_HOME/sys-setup/.dotfiles/.prettierrc.js ~/.prettierrc.js
  ln -sf $CSYS_HOME/sys-setup/.dotfiles/.pylintrc ~/.pylintrc
  ln -sf $CSYS_HOME/sys-setup/.dotfiles/.pydocstylerc ~/.pydocstylerc
}
gui_config() {
  ln -sf $CSYS_HOME/sys-setup/.dotfiles/.hyper.js ~/.hyper.js
}
non_gui_program_setup() {
  programs/vim/setup.sh
}
gui_program_setup() {
  programs/atom/setup.sh --install
  # programs/subl/setup.sh # not using
  programs/vscode/setup.sh --install
}

CONFIG_HOME="$CSYS_HOME/sys-setup"
RETURN_TO=$(pwd)

cd $CONFIG_HOME || exit

non_gui_config
gui_config

if [ "$(uname -s)" == "Linux" ]; then
  if [ "$(uname -m)" == "armv7l" ]; then
    ./os/pi/setup.sh
  else
    ./os/lin/setup.sh
    gui_program_setup
  fi
elif [ "$(uname -s)" == "Darwin" ]; then
  ./os/mac/setup.sh
  gui_program_setup
elif [ "$(uname -s)" == "MINGW64_NT-10.0" ]; then
  ./os/win/setup.sh
  gui_program_setup
fi

non_gui_program_setup

cd $RETURN_TO || exit

# function:
# npm installs:
#   eslint
#   babel-eslint
#	node-notifier

#!/usr/bin/env bash

export CSYS_HOME="$HOME/r/s"

non_gui_config() {
  if [ ! -d "$HOME/.config" ]; then
    mkdir "$HOME/.config"
  fi
  ln -sf "$CSYS_HOME/sys-setup/bash/.bashrc" "$HOME/.bashrc"
  ln -sf "$CSYS_HOME/sys-setup/bash/.bashrc" "$HOME/.bash_profile"

  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.vimrc" "$HOME/.vimrc"
  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.tmux.conf" "$HOME/.tmux.conf"
  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.gitconfig" "$HOME/.gitconfig"
  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.gitignore" "$HOME/.gitignore"
  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.eslintrc.js" "$HOME/.eslintrc.js"
  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.prettierrc.js" "$HOME/.prettierrc.js"
  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.pylintrc" "$HOME/.pylintrc"
  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.pydocstylerc" "$HOME/.pydocstylerc"
  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.style.yapf" "$HOME/.style.yapf"
  ln -sf "$CSYS_HOME/sys-setup/fish" "$HOME/.config/"
}
gui_config() {
  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.jupyter" "$HOME/.jupyter"
  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.ipython" "$HOME/.ipython"
  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.hyper.js" "$HOME/.hyper.js"
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

cd "$CONFIG_HOME" || exit

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

cd "$RETURN_TO" || exit

# function:
# npm installs:
#   eslint
#   babel-eslint
#	node-notifier

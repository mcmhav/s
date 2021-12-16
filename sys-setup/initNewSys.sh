#!/usr/bin/env bash

non_gui_config() {
  if [ ! -d "$HOME/.wakatime" ]; then
    mkdir "$HOME/.wakatime"
  fi
  if [ ! -d "$HOME/.config" ]; then
    mkdir "$HOME/.config"
  fi
  ln -sf "$CSYS_HOME/sys-setup/bash/.bashrc" "$HOME/.bashrc"
  ln -sf "$CSYS_HOME/sys-setup/bash/.bashrc" "$HOME/.bash_profile"

  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.vimrc" "$HOME/.vimrc"
  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.tmux.conf" "$HOME/.tmux.conf"
  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/zellij" "$HOME/.config/zellij"
  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.eslintrc.js" "$HOME/.eslintrc.js"
  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.prettierrc.js" "$HOME/.prettierrc.js"
  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.pylintrc" "$HOME/.pylintrc"
  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.pydocstylerc" "$HOME/.pydocstylerc"
  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.style.yapf" "$HOME/.style.yapf"
  ln -sf "$CSYS_HOME/sys-setup/programs/fish" "$HOME/.config/"
}
gui_config() {
  if [ ! -L "$HOME/.jupyter" ]; then
    rm -rf "$HOME/.jupyter"
  fi
  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.jupyter" "$HOME/"
  if [ ! -L "$HOME/.ipython" ]; then
    rm -rf "$HOME/.ipython"
  fi
  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.ipython" "$HOME/"

  case "$CSYS_OS" in
  "$WIN_OS") ln -sf --hard "$CSYS_HOME/sys-setup/.dotfiles/.hyper.js" "$HOME/AppData/Roaming/Hyper/.hyper.js" ;;
  *) ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.hyper.js" "$HOME/.hyper.js" ;;
  esac

  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/alacritty" "$HOME/.config/"
}
non_gui_program_setup() {
  programs/vim/setup.sh
}
gui_program_setup() {
  programs/atom/setup.sh --install
  programs/vscode/setup.sh --install
}

CSYS_HOME="$HOME/r/s"
CONFIG_HOME="$CSYS_HOME/sys-setup"
RETURN_TO=$(pwd)

cd "$CONFIG_HOME" || exit

source "$CSYS_HOME/sys-setup/bash/bashrc/.bashcsysrc"
source "$CSYS_HOME/sys-setup/bash/bashrc/.bashSourcerc"

non_gui_config
gui_config

case "$CSYS_OS" in
"$PI_OS") ./os/pi/setup.sh ;;
"$LIN_OS")
  ./os/lin/setup.sh
  gui_program_setup
  ;;
"$MAC_OS")
  ./os/mac/setup.sh
  gui_program_setup
  ;;
"$WIN_OS")
  ./os/win/setup.sh
  gui_program_setup
  ;;
esac

non_gui_program_setup

cd "$RETURN_TO" || exit

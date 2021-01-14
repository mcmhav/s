#!/usr/bin/env bash

non_gui_config() {
  if [ ! -d "$HOME/.config" ]; then
    mkdir "$HOME/.config"
  fi
  ln -sf "$CSYS_HOME/sys-setup/bash/.bashrc" "$HOME/.bashrc"
  ln -sf "$CSYS_HOME/sys-setup/bash/.bashrc" "$HOME/.bash_profile"

  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.vimrc" "$HOME/.vimrc"
  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.tmux.conf" "$HOME/.tmux.conf"
  # ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.gitconfig" "$HOME/.gitconfig"
  # ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.gitignore" "$HOME/.gitignore"
  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.eslintrc.js" "$HOME/.eslintrc.js"
  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.prettierrc.js" "$HOME/.prettierrc.js"
  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.pylintrc" "$HOME/.pylintrc"
  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.pydocstylerc" "$HOME/.pydocstylerc"
  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.style.yapf" "$HOME/.style.yapf"
  ln -sf "$CSYS_HOME/sys-setup/programs/fish" "$HOME/.config/"
}
gui_config() {
  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.jupyter" "$HOME/"
  ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.ipython" "$HOME/"
  if [[ "$(uname -s)" =~ MINGW64_NT* ]]; then
    ln -sf --hard "$CSYS_HOME/sys-setup/.dotfiles/.hyper.js" "$HOME/AppData/Roaming/Hyper/.hyper.js"
  else
    ln -sf "$CSYS_HOME/sys-setup/.dotfiles/.hyper.js" "$HOME/.hyper.js"
  fi
}
non_gui_program_setup() {
  programs/vim/setup.sh
}
gui_program_setup() {
  programs/atom/setup.sh --install
  # programs/subl/setup.sh # not using
  programs/vscode/setup.sh --install
}

CSYS_HOME="$HOME/r/s"
CONFIG_HOME="$CSYS_HOME/sys-setup"
RETURN_TO=$(pwd)

cd "$CONFIG_HOME" || exit

# TODO: use CSYS_OS-variable
source "$CSYS_HOME/sys-setup/bash/bashrc/.bashcsysrc"
source "$CSYS_HOME/sys-setup/bash/bashrc/.bashSourcerc"

exit

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

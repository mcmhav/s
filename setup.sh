#!/usr/bin/env bash
# https://raw.githubusercontent.com/mcmhav/s/HEAD/setup.sh

CONFIG_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
BASHRC_LOCATION="$HOME/.csys.bashrc.d"
export CSYS_HOME="$CONFIG_HOME"

DOTFILES="$CSYS_HOME/sys-setup/.dotfiles"
BASH_CONFIG="$CSYS_HOME/bash"
PROGRAMS_CONFIG="$CSYS_HOME/programs"

if [ ! -d "$BASHRC_LOCATION" ]; then
  mkdir "$BASHRC_LOCATION"
fi

ln -sf "$BASH_CONFIG/main.bashrc" "$BASHRC_LOCATION"

# Hacky as shit?
BASH_RC_SOURCER="[ -d \"$BASHRC_LOCATION\" ] && for i in \$(find $BASHRC_LOCATION -regex \".*rc$\"); do source \"\$i\"; done || echo \"csys not set up\""
# BASH_RC_SOURCER="[ -d \"$BASHRC_LOCATION\" ] && find $BASHRC_LOCATION -name \*rc -print0 | while IFS= read -r -d '' line; do source \"\$line\"; done || echo \"csys not set up\""
if ! grep -q "$BASH_RC_SOURCER" <"$HOME/.bashrc"; then
  echo "$BASH_RC_SOURCER" >>"$HOME/.bashrc"
fi

non_gui_config() {
  if [ ! -d "$HOME/.config" ]; then
    mkdir "$HOME/.config"
  fi
  ln -sf "$DOTFILES/zellij" "$HOME/.config/"
  ln -sf "$DOTFILES/.eslintrc.js" "$HOME/.eslintrc.js"
  ln -sf "$DOTFILES/.prettierrc.js" "$HOME/.prettierrc.js"
  ln -sf "$DOTFILES/.pylintrc" "$HOME/.pylintrc"
  ln -sf "$DOTFILES/.pydocstylerc" "$HOME/.pydocstylerc"
  ln -sf "$DOTFILES/.style.yapf" "$HOME/.style.yapf"
  ln -sf "$DOTFILES/fish" "$HOME/.config/"
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
  programs/vscode/setup.sh --install
}

non_gui_config

source "$CSYS_HOME/bash/bashrc.d/csys.bashrc"
source "$CSYS_HOME/bash/bashrc.d/sourcer.bashrc"

"$PROGRAMS_CONFIG/wakatime/setup.sh"
"$PROGRAMS_CONFIG/vim/setup.sh"

exit

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

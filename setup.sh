#!/bin/bash
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
if ! grep -q "$BASH_RC_SOURCER" <"$HOME/.bashrc"; then
  echo "$BASH_RC_SOURCER" >>"$HOME/.bashrc"
fi

exit

non_gui_config() {
  if [ ! -d "$HOME/.config" ]; then
    mkdir "$HOME/.config"
  fi
  ln -sf "$DOTFILES/.tmux.conf" "$HOME/.tmux.conf"
  ln -sf "$DOTFILES/zellij" "$HOME/.config/"
  ln -sf "$DOTFILES/.eslintrc.js" "$HOME/.eslintrc.js"
  ln -sf "$DOTFILES/.prettierrc.js" "$HOME/.prettierrc.js"
  ln -sf "$DOTFILES/.pylintrc" "$HOME/.pylintrc"
  ln -sf "$DOTFILES/.pydocstylerc" "$HOME/.pydocstylerc"
  ln -sf "$DOTFILES/.style.yapf" "$HOME/.style.yapf"
  ln -sf "$DOTFILES/fish" "$HOME/.config/"
}

non_gui_config

source "$CSYS_HOME/sys-setup/bash/bashrc/.bashcsysrc"
source "$CSYS_HOME/sys-setup/bash/bashrc/.bashSourcerc"

"$PROGRAMS_CONFIG/wakatime/setup.sh"
"$PROGRAMS_CONFIG/vim/setup.sh"

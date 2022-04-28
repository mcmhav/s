#!/bin/bash
# https://raw.githubusercontent.com/mcmhav/s/HEAD/setup.sh

CONFIG_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
BASHRC_LOCATION="$HOME/.csys.bashrc.d"
export CSYS_HOME="$CONFIG_HOME"

DOTFILES="$CSYS_HOME/sys-setup/.dotfiles"
PROGRAMS_CONFIG="$CSYS_HOME/programs"

if [ ! -d "$BASHRC_LOCATION" ]; then
	mkdir "$BASHRC_LOCATION"
fi

ln -sf "$CSYS_HOME/sys-setup/bash/.bashrc" "$BASHRC_LOCATION"

BASH_RC_SOURCER='for i in $(ls -A $HOME/.csys.bashrc.d/ | grep "rc$"); do source $HOME/.csys.bashrc.d/$i; done'
if ! grep -q "$BASH_RC_SOURCER" <"$HOME/.bashrc"; then
	echo "$BASH_RC_SOURCER" >>$HOME/.bashrc
fi

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

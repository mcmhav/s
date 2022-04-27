# https://wiki.archlinux.org/title/fish
set fish_greeting

set fish_command_timer_enabled 0

export CSYS_HOME="$HOME/r/s"
bass source $CSYS_HOME/sys-setup/bash/bashrc/.bashcsysrc fish
bass source $CSYS_HOME/sys-setup/bash/bashrc/.bashSourcerc

# alias pipenv='env SHELL="/usr/local/bin/fish" pipenv'
alias :q="exit"
status --is-login; and pyenv init --path | source
status --is-interactive; and source (rbenv init -|psub)
status --is-interactive; and source (nodenv init -|psub)

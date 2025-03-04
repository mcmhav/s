# ᯾ ᯿
PROMPT='%F{green}▲%f %B%F{#ff55ff}%1~%f%b %F{#5BB3ff}⭔%f '

# Styles
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select

# keys
bindkey '^R' history-incremental-search-backward

SCRIPT_PATH="$(dirname $(realpath ${(%):-%x}))"
export CSYS_HOME="$(realpath $SCRIPT_PATH/../../..)"
emulate bash -c 'source $CSYS_HOME/programs/bash/bashrc.d/csys.bashrc zsh'
emulate bash -c 'source $CSYS_HOME/programs/bash/bashrc.d/sourcer.bashrc'

export ZSH_CONFIG_HOME="$HOME/.config/zsh"
source "$ZSH_CONFIG_HOME/source.zsh"

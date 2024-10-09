PROMPT='%F{green}▲%f %F{blue}%1~%f ⭓ '

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

SCRIPT_PATH="$(dirname $(realpath ${(%):-%x}))"
export CSYS_HOME="$(realpath $SCRIPT_PATH/../../..)"
emulate bash -c 'source $CSYS_HOME/programs/bash/bashrc.d/csys.bashrc zsh'
emulate bash -c 'source $CSYS_HOME/programs/bash/bashrc.d/sourcer.bashrc'


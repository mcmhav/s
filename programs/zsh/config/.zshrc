PROMPT='%F{green}▲%f %F{blue}%1~%f ⭓ '

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

emulate bash -c 'source $CSYS_HOME/programs/bash/bashrc.d/csys.bashrc zsh'
emulate bash -c 'source $CSYS_HOME/programs/bash/bashrc.d/sourcer.bashrc'

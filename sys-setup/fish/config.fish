set fish_greeting

export CSYS_HOME="$HOME/r/s"

bass source $CSYS_HOME/sys-setup/bash/bashrc/.bashHelperFuncsrc
bass source $CSYS_HOME/sys-setup/bash/bashrc/.bashGitrc
bass source $CSYS_HOME/sys-setup/bash/bashrc/.bashAliasesrc
bass source $CSYS_HOME/sys-setup/bash/bashrc/.bashExportsrc
if test -e $HOME/.bashAkerrcs
  bass source $HOME/.bashAkerrcs/.bashAkerrc
end
# bass source $CSYS_HOME/sys-setup/bash/bashrc/.bashSourcerc

# source $CSYS_HOME/sys-setup/bash/.bashrc

pyenv init - | source

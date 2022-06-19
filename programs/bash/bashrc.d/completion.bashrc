#!/usr/bin/env bash
# shellcheck source=/dev/null

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi

# shims and autocompletion, pyenv
if command -v pyenv 1>/dev/null 2>&1 && [ "$CSYS_OS" != "$WIN_OS" ]; then
  eval "$(pyenv init -)"
fi

if command -v nodenv 1>/dev/null 2>&1; then
  eval "$(nodenv init -)"
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

completionsWD="$CSYS_BASH_HOME/completions"

source "$completionsWD/csys.bash"

# Terraform:
if [ -f "/usr/local/bin/terraform" ]; then
  complete -C /usr/local/bin/terraform terraform
fi

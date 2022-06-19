#!/usr/bin/env bash

# https://iridakos.com/tutorials/2018/03/01/bash-programmable-completion-tutorial.html
# https://www.tldp.org/LDP/abs/html/tabexpansion.html
_csys_completions()
{
  CSYS_FLAGS="--diff --download --upload --status"

  COMPREPLY=()   # Array variable storing the possible completions.
  cur=${COMP_WORDS[COMP_CWORD]}
  prev=${COMP_WORDS[COMP_CWORD-1]}

  case "$cur" in
    # -*)
    #   COMPREPLY=($(compgen -W "$CSYS_FLAGS" -- $cur))
    #   ;;
    *)
      COMPREPLY=($(compgen -W "$CSYS_FLAGS" -- $cur))
      ;;
  esac
}

complete -F _csys_completions csys

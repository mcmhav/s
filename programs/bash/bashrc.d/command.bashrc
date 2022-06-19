#!/usr/bin/env bash

HISTSIZE=10000
HISTFILESIZE=2000
export HISTFILE=~/.bash_eternal_ish_history
HISTCONTROL=ignoreboth

unset PROMPT_COMMAND

function timer_start() {
  timer=${timer:-$SECONDS}
}

function timer_stop() {
  timer_show=$((SECONDS - timer))

  if [ "$timer_show" -gt "900" ]; then
    notifyer "Done!!!"
  fi

  unset timer
}
trap 'timer_start' DEBUG

function error_log() {
  promt_message=""
  promt_message_spacer=""
  if [[ $1 != 0 && $1 != 130 ]]; then
    # http://www.tldp.org/LDP/abs/html/exitcodes.html
    # no error
    # Ctrl + C - exit
    promt_message="▼"
    promt_message_spacer="|"
  else
    printf ""
  fi
}

function promt_commands() {
  local curr_exit="$?"

  timer_stop
  error_log $curr_exit
}

PROMPT_COMMAND=promt_commands

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  IS_SSH_SESSION="1"
else
  case $(ps -o comm= -p $PPID) in
  sshd | */sshd) IS_SSH_SESSION="1" ;;
  esac
fi

PS1=''
PS1=$PS1'\[\e[0;31m\]${promt_message}\[\e[m\]'
PS1=$PS1'${promt_message_spacer}'
PS1=$PS1'\[\e[1;35m\]${timer_show}\[\e[m\]'
PS1=$PS1'|'
PS1=$PS1'\[\e['
if [ -n "$IS_SSH_SESSION" ]; then
  PS1=$PS1'1;31m'
else
  PS1=$PS1'1;32m'
fi
PS1=$PS1'\]\W\[\e[m\]'
# ❮ ❯ ❰ ❱ ◼ ▶ ▴ ▲ ▼ ⬘ ⌔ ∴ ⭓ ⭔ း ಃ 〓 💩
PS1=$PS1'\[\e['
if [ -n "$IS_SSH_SESSION" ]; then
  PS1=$PS1'0;34m'
else
  PS1=$PS1'0;31m'
fi
PS1=$PS1'\]⭓\[\e[m\] '

export PS1=$PS1
export PROMPT=$PS1
export PS2='> '

# '\e[x;ym $PS1 \e[m' Where:
#  - \e[ : Start color scheme.
#  - x;y : Color pair to use (x;y)
#  - $PS1 : Your shell prompt variable.
#  - \e[m : Stop color scheme.

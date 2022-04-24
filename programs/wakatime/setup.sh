#!/usr/bin/env bash

if [ ! -d "$HOME/.wakatime" ]; then
  mkdir "$HOME/.wakatime"
fi

if [ ! -f "$HOME/.wakatime/.wakatime.cfg" ]; then
  echo """[settings]
  debug = false
  hidefilenames = false
  ignore =
      COMMIT_EDITMSG$
      PULLREQ_EDITMSG$
      MERGE_MSG$
      TAG_EDITMSG$
  api_key=tmp
  """ >>"$HOME/.wakatime/.wakatime.cfg"
fi

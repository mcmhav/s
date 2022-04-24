#!/usr/bin/env bash

if [ ! -d "$HOME/.wakatime" ]; then
  mkdir "$HOME/.wakatime"
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

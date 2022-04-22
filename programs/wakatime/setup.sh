#!/usr/bin/env bash

if [ ! -d "$HOME/.wakatime" ]; then
  mkdir "$HOME/.wakatime"
  echo """[settings]
  api_key=tmp
  """ >>"$HOME/.wakatime/.wakatime.cfg"
fi

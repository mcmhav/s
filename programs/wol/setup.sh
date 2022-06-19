#!/usr/bin/env bash

_setup() {
  if ! command -v wol >/dev/null; then
    go install github.com/sabhiram/go-wol/cmd/wol@latest
  fi
}

_setup

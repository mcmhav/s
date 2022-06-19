#!/usr/bin/env bash

_setup() {
  if ! command -v primitive >/dev/null; then
    go install github.com/fogleman/primitive@latest
  fi
}

_setup

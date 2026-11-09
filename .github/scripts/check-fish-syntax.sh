#!/usr/bin/env bash
# prek hook: syntax-check fish files. `fish --no-execute` only checks one script per call.
if ! command -v fish >/dev/null; then
  if [ -n "${CI:-}" ]; then
    echo "fish is not installed" >&2
    exit 1
  fi
  echo "fish is not installed, skipping the fish syntax check" >&2
  exit 0
fi

status=0
for f in "$@"; do
  fish --no-execute "$f" || status=1
done
exit "$status"

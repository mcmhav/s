#!/usr/bin/env bash
# CI: install programs whose pinned release changed and check that they run.
#
# Installs into a throwaway HOME with only basic tools on PATH, so tools preinstalled on the runner
# (yq, rg, ...) don't hide a broken pin. Only programs that install through `csys release` are checked.
#
#   .github/scripts/check-release-pins.sh [<program>...]
#
# Without arguments: the programs changed since $BASE_SHA, or all of them when bin/_csys or .github
# changed or $BASE_SHA is unset.
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

_all_release_programs() {
  grep -l "csys release" "$ROOT"/programs/*/setup.sh | xargs -n1 dirname | xargs -n1 basename
}

_programs() {
  if [ "$#" -gt 0 ]; then
    printf '%s\n' "$@"
    return
  fi
  if [ -z "${BASE_SHA:-}" ]; then
    _all_release_programs
    return
  fi
  local changed
  changed="$(git -C "$ROOT" diff --name-only "$BASE_SHA"...HEAD)"
  if grep -qE '^(bin/_csys/|\.github/)' <<<"$changed"; then
    _all_release_programs
    return
  fi
  sed -nE 's#^programs/([^/]+)/setup\.sh$#\1#p' <<<"$changed" |
    while read -r p; do
      if grep -q "csys release" "$ROOT/programs/$p/setup.sh"; then echo "$p"; fi
    done
}

mapfile -t PROGRAMS < <(_programs "$@")
if [ "${#PROGRAMS[@]}" -eq 0 ]; then
  echo "No changed programs that install through csys release."
  exit 0
fi
echo "Checking on $(uname -m): ${PROGRAMS[*]}"

SANDBOX="$(mktemp -d)"
trap 'rm -rf "$SANDBOX"' EXIT
mkdir -p "$SANDBOX/bin" "$SANDBOX/home/.config"
for tool in bash sh env curl tar gzip xz unzip mktemp find sed grep awk uname dirname basename \
  chmod mkdir mv cp rm ln ls comm readlink cat sort head tail tr date touch wc cut xargs column \
  sleep stat; do
  if path="$(command -v "$tool")" && [ -x "$path" ]; then ln -s "$path" "$SANDBOX/bin/$tool"; fi
done
export HOME="$SANDBOX/home"
# Keep everything inside the sandbox, including where csys release keeps its store.
unset XDG_CONFIG_HOME XDG_DATA_HOME XDG_STATE_HOME XDG_CACHE_HOME CSYS_STORE CSYS_LOCAL_BIN CSYS_RUN_DIR

# After HOME is switched: csys.bashrc derives paths like CSYS_BASHRC_D from it. It isn't `set -u` safe.
export CSYS_HOME="$ROOT"
set +u
source "$ROOT/programs/bash/bashrc.d/csys.bashrc"
set -u
export CSYS_LOG_LEVEL=5
export PATH="$HOME/.local/bin:$CSYS_BIN:$SANDBOX/bin"

# Not every tool has --version (kubectl, k9s, process-compose use a `version` subcommand), and some
# exit 0 on an unknown flag (k9s), so an attempt only counts if it also prints a version number.
_version() {
  local out
  for args in "--version" "version --client" "version"; do
    # shellcheck disable=SC2086
    if out="$("$1" $args 2>&1)" && grep -qE '[0-9]+\.[0-9]+' <<<"$out" &&
      ! grep -qiE 'unknown (flag|command|shorthand)' <<<"$out"; then
      echo "$out"
      return 0
    fi
  done
  echo "$out"
  return 1
}

failed=()
for p in "${PROGRAMS[@]}"; do
  echo "::group::$p"
  before="$(ls "$HOME/.local/bin" 2>/dev/null)"
  bash "$ROOT/programs/$p/setup.sh"
  new="$(comm -13 <(echo "$before") <(ls "$HOME/.local/bin" 2>/dev/null))"
  ok=1
  if [ -z "$new" ]; then
    echo "::error::$p: nothing was installed into ~/.local/bin"
    ok=0
  fi
  for bin in $new; do
    if ! _version "$HOME/.local/bin/$bin"; then
      echo "::error::$p: '$bin' does not run (tried --version, version --client, version)"
      ok=0
    fi
  done
  echo "::endgroup::"
  [ "$ok" = 1 ] || failed+=("$p")
done

if [ "${#failed[@]}" -gt 0 ]; then
  echo "Failed on $(uname -m): ${failed[*]}"
  exit 1
fi
echo "All good on $(uname -m)."

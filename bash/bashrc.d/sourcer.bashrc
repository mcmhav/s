#!/usr/bin/env bash
# shellcheck source=/dev/null

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

# adding extra sourcesz
source "$SCRIPT_DIR/git.bashrc"
source "$SCRIPT_DIR/exports.bashrc"
source "$SCRIPT_DIR/aliases.bashrc"
source "$SCRIPT_DIR/$CSYS_OS.bashrc"

G_CLOUD_SDK_PATH="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"

if [ "$CSYS_SHELL" == "bash" ]; then
  # The next line updates PATH for the Google Cloud SDK.
  if [ -e "$G_CLOUD_SDK_PATH/path.bash.inc" ]; then
    source "$G_CLOUD_SDK_PATH/path.bash.inc"
  fi
  # The next line enables shell command completion for gcloud.
  if [ -f $G_CLOUD_SDK_PATH/completion.bash.inc ]; then
    source $G_CLOUD_SDK_PATH/completion.bash.inc
  fi

  source "$SCRIPT_DIR/command.bashrc"

  source "$SCRIPT_DIR/completion.bashrc"
fi

#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

installYarns() {
	while read l; do
		yarn global add $l
	done <"$SCRIPT_DIR/yarns"
}

installYarns

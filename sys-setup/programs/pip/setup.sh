#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

installPys() {
	while read -r l; do
		pip install "$l" --quiet
	done <"$SCRIPT_DIR/pips"
}

pip install --upgrade pip --quiet

installPys

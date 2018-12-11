#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

installPys() {
	while read l; do
		pip install $l
	done <"$SCRIPT_DIR/pips"
}

pip install --upgrade pip

installPys

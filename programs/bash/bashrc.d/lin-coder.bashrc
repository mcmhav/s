#!/usr/bin/env bash

export TF_PLUGIN_CACHE_DIR="/workspace/.terraform.d/plugin-cache"
if [ ! -d "$TF_PLUGIN_CACHE_DIR" ]; then
    mkdir -p "$TF_PLUGIN_CACHE_DIR"
fi

#!/usr/bin/env bash

exec /run/current-system/sw/bin/rclone bisync \
    onedrive:Documents \
    "$HOME/Documents" \
    --create-empty-src-dirs \
    "$@"

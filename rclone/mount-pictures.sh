#!/usr/bin/env bash

exec /run/current-system/sw/bin/rclone mount \
    onedrive:Pictures \
    "$HOME/Pictures" \
    --vfs-cache-mode full

#!/bin/bash -e

USER=$(whoami)
YABAI_PATH=$(which yabai)
CHECKSUM=$(shasum -a 256 "$YABAI_PATH")

TARGET_PATH="/private/etc/sudoers.d/yabai"

echo "$USER ALL = (root) NOPASSWD: sha256:$CHECKSUM --load-sa" > $TARGET_PATH

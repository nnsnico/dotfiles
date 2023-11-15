#!/bin/sh

# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

TITLE_YABAI=$(yabai -m query --windows --window | "$HOME"/dotfiles/zsh/.zinit/plugins/jqlang---jq/jq -r '.title')
sketchybar --set "$NAME" label="$TITLE_YABAI"

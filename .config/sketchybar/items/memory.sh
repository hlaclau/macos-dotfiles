#!/bin/bash

MEMORY=(
  update_freq=5
  icon.font="$ICON_FONT:Regular:16.0"
  icon=$MEMORY_ICON
  icon.color=$SKY
  background.color=$ITEM_BG_COLOR
  background.corner_radius=10
  script="$PLUGIN_DIR/memory.sh"
)

sketchybar --add item memory right \
           --set memory "${MEMORY[@]}"
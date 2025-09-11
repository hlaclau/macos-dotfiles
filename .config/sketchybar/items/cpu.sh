#!/bin/bash

CPU=(
  update_freq=2
  icon.font="$ICON_FONT:Regular:16.0"
  icon=$CPU_ICON
  icon.color=$PEACH
  background.color=$ITEM_BG_COLOR
  background.corner_radius=10
  script="$PLUGIN_DIR/cpu.sh"
)

sketchybar --add item cpu right \
           --set cpu "${CPU[@]}" 
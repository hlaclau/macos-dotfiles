#!/bin/bash

BATTERY=(
  update_freq=120
  icon.font="$ICON_FONT:Regular:18.0"
  icon.color=$GREEN
  background.color=$ITEM_BG_COLOR
  background.corner_radius=10
  script="$PLUGIN_DIR/battery.sh"
)

sketchybar --add item battery right \
           --set battery "${BATTERY[@]}" \
           --subscribe battery system_woke power_source_change


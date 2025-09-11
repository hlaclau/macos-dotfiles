#!/bin/bash

FRONT_APP=(
  label.font="$FONT:Medium:13.0"
  label.color=$WHITE
  background.drawing=off
  icon.drawing=off
  script="$PLUGIN_DIR/front_app.sh"
)

sketchybar --add item front_app left \
           --set front_app "${FRONT_APP[@]}" \
           --subscribe front_app front_app_switched 

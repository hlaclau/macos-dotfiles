#!/bin/bash

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9")

SPACE=(
  icon.padding_left=10
  icon.padding_right=10
  icon.color=$DARK_WHITE
  icon.font="$FONT:Medium:14.0"
  icon.highlight_color=$WHITE
  background.color=$TRANSPARENT
  background.corner_radius=8
  background.height=26
  background.padding_left=4
  background.padding_right=4
  background.shadow.drawing=off
  label.drawing=off
)

sketchybar --add event aerospace_workspace_change

for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))
  sketchybar --add item space.$sid left \
             --subscribe space.$sid aerospace_workspace_change \
             --set space.$sid "${SPACE[@]}" \
                  script="$PLUGIN_DIR/space.sh $sid" \
                  click_script="aerospace workspace $sid" \
             --set space.$sid icon=${SPACE_ICONS[i]}
done
#!/bin/bash

source "$CONFIG_DIR/colors.sh"

SELECTED="false"
BG_COLOR=$TRANSPARENT
ICON_COLOR=$DARK_WHITE

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    SELECTED="true"
    BG_COLOR=$MAUVE
    ICON_COLOR=$WHITE
fi

sketchybar --animate sin 20 --set $NAME \
           icon.highlight=$SELECTED \
           icon.color=$ICON_COLOR \
           background.color=$BG_COLOR

#!/bin/bash

sketchybar --add event music_changed \
           --add item music right \
           --set music background.color=$ITEM_BG_COLOR \
                      background.corner_radius=10 \
                      icon=$MUSIC_ICON \
                      icon.color=$BLUE \
                      icon.font="$ICON_FONT:Regular:16.0" \
                      label.color=$WHITE \
                      label.font="$FONT:Medium:11.0" \
                      label.max_chars=25 \
                      label.scroll_duration=150 \
                      script="$PLUGIN_DIR/music.sh" \
                      updates=on \
           --subscribe music music_changed
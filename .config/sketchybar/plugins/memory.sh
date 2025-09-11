#!/bin/bash

source "$CONFIG_DIR/colors.sh"

MEMORY_STATS=$(memory_pressure | grep "System-wide memory free percentage")
if [[ $MEMORY_STATS =~ ([0-9]+)% ]]; then
    MEMORY_FREE=${BASH_REMATCH[1]}
    MEMORY_USED=$((100 - MEMORY_FREE))
    
    if [ $MEMORY_USED -gt 80 ]; then
        COLOR=$RED
    elif [ $MEMORY_USED -gt 60 ]; then
        COLOR=$YELLOW
    else
        COLOR=$SKY
    fi
    
    sketchybar --set memory label="${MEMORY_USED}%" \
                            icon.color=$COLOR
else
    MEMORY_INFO=$(vm_stat | head -4 | tail -3)
    PAGES_FREE=$(echo "$MEMORY_INFO" | grep "Pages free" | awk '{print $3}' | sed 's/\.//')
    PAGES_ACTIVE=$(echo "$MEMORY_INFO" | grep "Pages active" | awk '{print $3}' | sed 's/\.//')
    PAGES_INACTIVE=$(echo "$MEMORY_INFO" | grep "Pages inactive" | awk '{print $3}' | sed 's/\.//')
    
    if [ -n "$PAGES_FREE" ] && [ -n "$PAGES_ACTIVE" ] && [ -n "$PAGES_INACTIVE" ]; then
        PAGES_TOTAL=$((PAGES_FREE + PAGES_ACTIVE + PAGES_INACTIVE))
        MEMORY_USED_PERCENT=$(((PAGES_ACTIVE + PAGES_INACTIVE) * 100 / PAGES_TOTAL))
        
        if [ $MEMORY_USED_PERCENT -gt 80 ]; then
            COLOR=$RED
        elif [ $MEMORY_USED_PERCENT -gt 60 ]; then
            COLOR=$YELLOW
        else
            COLOR=$SKY
        fi
        
        sketchybar --set memory label="${MEMORY_USED_PERCENT}%" \
                                icon.color=$COLOR
    else
        sketchybar --set memory label="N/A" \
                                icon.color=$DARK_WHITE
    fi
fi
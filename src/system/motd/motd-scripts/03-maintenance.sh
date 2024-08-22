#!/bin/bash

# @NOTE: Placeholder script , enhancements to be added to include logic for easily specifying maintenance details.
#      : Current idea is to assign a dir where a simple maintenance file cann be added with details that can be automatically 
#      : parsed and logic for cleanup (automatically removing file after time is passed)

# Define color and reset variables
COLOR='\033[38;2;0;187;255;1m'
RESET='\033[0m'

# Define width for columns (length in characters)
COLUMN_WIDTH=30

# Function to calculate length of text excluding escape codes
text_length() {
    local text="$1"
    echo -n "$text" | sed 's/\x1b\[[0-9;]*m//g' | wc -c
}

# Function to pad the text to align columns
pad_text() {
    local text="$1"
    local padding="$2"
    printf "%s%${padding}s" "$text"
}

# Example data
next_maintenance="[Date and Time]"
details="[Brief Description]"

# Display formatted output
echo -e "$(pad_text "${COLOR}Next Maintenance${RESET}" $((COLUMN_WIDTH - $(text_length "Next Maintenance")))): $next_maintenance"
echo -e "$(pad_text "${COLOR}Details${RESET}" $((COLUMN_WIDTH - $(text_length "Details")))): $details"


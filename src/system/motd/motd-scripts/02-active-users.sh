#!/bin/bash

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
active_users=$(who | awk '{print "~" $1 " " $2 " " $3 " " $4 " " $5 " " $6 " " $7 " " $8}')


# Display formatted output
echo -e "$(pad_text "${COLOR}Active Users${RESET}" $((COLUMN_WIDTH - $(text_length "Active Users")))): $active_users"


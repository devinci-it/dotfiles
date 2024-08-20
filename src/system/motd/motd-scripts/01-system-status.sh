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
cpu_usage=$(top -bn1 | grep 'Cpu(s)' | sed 's/.*, *\([0-9.]*\)%* id.*/\1/' | awk '{print 100 - $1}')%
memory_usage=$(free -h | grep Mem | awk '{print $3 "/" $2}')
disk_usage=$(df -h | grep '/$' | awk '{print $3 "/" $2}')

# Display formatted output
echo -e "$(pad_text "${COLOR}CPU Usage${RESET}" $((COLUMN_WIDTH - $(text_length "CPU Usage")))): $cpu_usage"
echo -e "$(pad_text "${COLOR}Memory Usage${RESET}" $((COLUMN_WIDTH - $(text_length "Memory Usage")))): $memory_usage"
echo -e "$(pad_text "${COLOR}Disk Usage${RESET}" $((COLUMN_WIDTH - $(text_length "Disk Usage")))): $disk_usage"


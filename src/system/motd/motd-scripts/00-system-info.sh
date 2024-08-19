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
hostname=$(hostname)
os=$(lsb_release -d | awk -F: '{print $2}' | xargs)
kernel=$(uname -r)
uptime=$(uptime -p)
last_login=$(last -n 1 $USER | awk '{print $4, $5, $6, $7}')

# Display formatted output
echo -e "$(pad_text "${COLOR}Hostname${RESET}" $((COLUMN_WIDTH - $(text_length "Hostname")))): $hostname"
echo -e "$(pad_text "${COLOR}Operating System${RESET}" $((COLUMN_WIDTH - $(text_length "Operating System")))): $os"
echo -e "$(pad_text "${COLOR}Kernel Version${RESET}" $((COLUMN_WIDTH - $(text_length "Kernel Version")))): $kernel"
echo -e "$(pad_text "${COLOR}Uptime${RESET}" $((COLUMN_WIDTH - $(text_length "Uptime")))): $uptime"
#echo -e "$(pad_text "${COLOR}Last Login${RESET}" $((COLUMN_WIDTH - $(text_length "Last Login")))): $last_login"

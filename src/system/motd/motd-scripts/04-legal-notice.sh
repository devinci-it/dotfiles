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
legal_notice="Unauthorized access to this system is prohibited and may result in legal consequences. By continuing, you agree to comply with all applicable laws and policies."

legal_notice=$(cat <<EOF
Unauthorized access to this system is prohibited and may result in legal consequences.
Only authorized users are permitted access to this system. 
Any unauthorized access or use may be punishable to the fullest extent of the law.
By continuing, you agree to comply with all applicable laws, regulations, and policies.
EOF
)
# Display formatted output
echo ""
echo -e "$(pad_text "${COLOR}System Access Notice${RESET}" $((COLUMN_WIDTH - $(text_length "Legal Notice"))))"
echo ""
echo -e "$legal_notice"


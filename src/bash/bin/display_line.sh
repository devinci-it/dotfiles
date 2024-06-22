#!/bin/bash

###########################################################
# Alias Script: lmz
# Description: Custom alias for displaying specific lines from a file
# Author: devinci-it
# Date: $(date +"%Y-%m-%d")
# Version: 1.0
#
# Usage:
#   lmz <line-number-or-range> <file>
#
# Example:
#   lmz 5 myfile.txt   # Displays line 5 from myfile.txt
#
###########################################################

# Function-like alias definition
setup_alias() {
    local command="$1"

    if [ -z "$1" ]; then
        echo "Usage: $0 <line-number-or-range> <file>"
        return 1
    fi

    # Command definition
    alias lmz="function __lmz() { $command; }; __lmz"
}

# Define the display_line function
display_line() {
    if [ $# -ne 2 ]; then
        echo "Usage: display_line <line-number-or-range> <file>"
        return 1
    fi

    local line_range="$1"
    local file="$2"

    if [[ ! -f "$file" ]]; then
        echo "File not found: $file"
        return 1
    fi

    sed -n "${line_range}p" "$file"
}

# Call setup_alias with your command
setup_alias "display_line \"$1\" \"$2\""

# End of alias script

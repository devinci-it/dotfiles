#!/bin/bash

# Get the directory of the current script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Script directory: $SCRIPT_DIR"

# Define the path to your manifest.yml file relative to the script's directory
MANIFEST_FILE="$SCRIPT_DIR/../alias.d/MANIFEST.yml"

echo "Manifest file: $MANIFEST_FILE"

check_duplicate_alias_keywords() {
    local manifest_file="$1"
    
    # Check if the manifest file exists
    if [ ! -f "$manifest_file" ]; then
        echo "Error: File '$manifest_file' not found."
        return 1
    fi

    # Extract alias-keywords and check for duplicates
    local duplicates_found=false
    local duplicate_keywords=$(awk '/alias-keyword:/ {print $2}' "$manifest_file" | sort | uniq -d)

    if [ -n "$duplicate_keywords" ]; then
        duplicates_found=true
        echo "Duplicate alias-keywords found:"
        # Iterate over duplicate keywords and print them
        for keyword in $duplicate_keywords; do
            echo "$keyword"
        done
    fi

    # Return boolean value (true/false)
    if $duplicates_found; then
        return 0  # true
    else
        return 1  # false
    fi
}

# Example usage:
check_duplicate_alias_keywords "$MANIFEST_FILE"

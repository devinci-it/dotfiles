#!/bin/bash

# Get the directory path of the current script (index.sh)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"


# Source logger functions
source "$SCRIPT_DIR/logger.sh"

# Locate the MANIFEST.txt relative to SCRIPT_DIR
MANIFEST_FILE="$SCRIPT_DIR/MANIFEST.txt"

# Check if MANIFEST.txt exists
if [ ! -f "$MANIFEST_FILE" ]; then
    echo "MANIFEST.txt not found in $SCRIPT_DIR."
    exit 1
fi

# Read each line of MANIFEST.txt
while IFS= read -r line; do
    # Extract filename (trimming any leading/trailing whitespace)
    filename=$(echo "$line" | awk '{$1=$1};1')

    # Construct absolute path to the script
    script_path="$SCRIPT_DIR/$filename"

    # Check if the file ends with .sh and is executable
    if [[ "$filename" == *.sh && -f "$script_path" && -x "$script_path" ]]; then
        # Source the script
        source "$script_path"
    fi
done < "$MANIFEST_FILE"

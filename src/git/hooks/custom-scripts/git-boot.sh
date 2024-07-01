#!/bin/bash

# Script: git-boot.sh
# Description: Boot script to move files from project root/.git/stubs to project directory, removing .stub extension
# Author: Your Name
# Date: $(date +"%Y-%m-%d")
# Version: 1.0

# Set -e to exit immediately if any command fails
set -e

# Check if script is being sourced
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    MAIN=main
else
    echo "This script should be executed directly, not sourced."
    exit 1
fi

# Main function
main() {
    local PROJECT_DIR=$(git rev-parse --show-toplevel)  # Get project root directory

    # Directory containing stub files
    local STUBS_DIR="${PROJECT_DIR}/.git/stubs"

    # Check if stubs directory exists
    if [ ! -d "${STUBS_DIR}" ]; then
        echo "Stubs directory (${STUBS_DIR}) not found. Exiting."
        exit 1
    fi

    echo "Moving stub files from ${STUBS_DIR} to ${PROJECT_DIR}..."

    # Move stub files and remove .stub extension
    for stub_file in "${STUBS_DIR}"/*.stub; do
        if [ -f "$stub_file" ]; then
            target_file="${PROJECT_DIR}/$(basename "$stub_file" .stub)"
            mv "$stub_file" "$target_file"
            echo "Moved $(basename "$stub_file") to $(basename "$target_file")"
        fi
    done

    echo "Bootstrapping complete."
}

    main "$@"

# End of script

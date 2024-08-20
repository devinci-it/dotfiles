#!/bin/bash

# Function to create a directory with local error handling
create_directory() {
    # Check if a path is provided
    if [ -z "$1" ]; then
        echo "Usage: create_directory <directory-path>"
        return 1
    fi

    # Create the directory
    local DIR_PATH="$1"
    mkdir -p "$DIR_PATH"

    # Check if the directory was created successfully
    if [ $? -eq 0 ]; then
        echo "Directory created: $DIR_PATH"
        log_message "Directory created: $DIR_PATH"
    else
        echo "Failed to create directory: $DIR_PATH"
        log_message "Failed to create directory: $DIR_PATH"
        return 1
    fi
}

# Log message when script is sourced
log_message "create_directory function is now available"

#!/bin/bash


# Function to check if a file or directory exists
check_exists() {
    # Check if a path is provided
    if [ -z "$1" ]; then
        log_error "Usage: check_exists <file-or-directory-path>"
        return 1
    fi

    # Path to check
    local PATH_TO_CHECK="$1"

    # Check if the file or directory exists
    if [ -e "$PATH_TO_CHECK" ]; then
        echo "Exists: $PATH_TO_CHECK"
        log_message "Exists: $PATH_TO_CHECK"
    else
        echo "Does not exist: $PATH_TO_CHECK"
        log_message "Does not exist: $PATH_TO_CHECK"
        return 1
    fi
}

# Log message when script is sourced
log_message "check_exists function is now available"


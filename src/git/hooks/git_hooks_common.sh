#!/bin/bash

# Logger function
log_message() {
    local LOG_FILE="${LOG_FILE:-/tmp/git_hooks.log}"  # Default log file if LOG_FILE is not set

    # Create log directory if it doesn't exist
    local LOG_DIR=$(dirname "$LOG_FILE")
    mkdir -p "$LOG_DIR"

    # Log format: [YYYY-MM-DD HH:mm:SS] - Message
    local TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$TIMESTAMP] - $1" >> "$LOG_FILE"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to get script directory
get_script_dir() {
    local SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
    echo "$SCRIPT_DIR"
}

# Function to create directory if it doesn't exist
create_directory() {
    local DIR_PATH="$1"

    if [ ! -d "$DIR_PATH" ]; then
        mkdir -p "$DIR_PATH"
        if [ $? -eq 0 ]; then
            log_message "Directory created: $DIR_PATH"
        else
            log_message "Failed to create directory: $DIR_PATH"
            exit 1
        fi
    else
        log_message "Directory already exists: $DIR_PATH"
    fi
}

# Function to check if a file or directory exists
check_exists() {
    local PATH_TO_CHECK="$1"

    if [ -e "$PATH_TO_CHECK" ]; then
        log_message "$PATH_TO_CHECK exists."
        return 0
    else
        log_message "$PATH_TO_CHECK does not exist."
        return 1
    fi
}

# Function to overwrite file or directory (creates a backup)
overwrite() {
    local FILE_PATH="$1"
    local BACKUP_DIR="/tmp/git_hooks_backup"

    if [ -e "$FILE_PATH" ]; then
        log_message "Backing up $FILE_PATH to $BACKUP_DIR"
        mkdir -p "$BACKUP_DIR"
        cp -r "$FILE_PATH" "$BACKUP_DIR"
        rm -rf "$FILE_PATH"
    fi
}

# Export the functions for use in other scripts

export -f log_message
export -f command_exists
export -f get_script_dir
export -f create_directory
export -f check_exists
export -f overwrite

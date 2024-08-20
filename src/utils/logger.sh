#!/bin/bash

LOG_FILE="${LOG_FILE:-utils.log}"

# Function to log a message with a timestamp
log_message() {
    local message="$1"
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $message" >> "$LOG_FILE"
}

# Function to log an error message with a timestamp
log_error() {
    local message="$1"
    echo "$(date +'%Y-%m-%d %H:%M:%S') - ERROR: $message" >> "$LOG_FILE"
}

# If being sourced by a barrel script, export functions
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "Logger functions should be sourced, not executed directly."
else
    export -f log_message
    export -f log_error
fi

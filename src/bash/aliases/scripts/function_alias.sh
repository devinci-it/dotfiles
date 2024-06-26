#!/bin/bash
#
# Script: function_alias.sh
# Description: Generates a new function-based alias file based on user input.
# Author: devinci-it
# Date: $(date +"%Y-%m-%d")
# Version: 1.0
# Usage: ./generate_alias.sh
#
# Dependencies:
#   - utility_functions.sh: Contains utility functions for the script.
#   - alias_generator.sh: Generates the alias script file based on user input.
#
# Environment Variables:
#   - DEBUG: Set to "true" to enable debug logging.
#
# Directory Structure:
#   - LOG_DIR: Directory path for log files.
#   - STUBS_DIR: Directory path for stub files.
#   - ALIAS_DIR: Directory path for alias scripts.
#   - MANIFEST_FILE: Path to the manifest file for alias registration.
#   - STUB_FILE_FUNCTION: Path to the function-based alias stub file.
#   - LOG_FILE: Path to the log file.
#

set -e

# Source utility functions
source "$(dirname "${BASH_SOURCE[0]}")/utility_functions.sh"

# Define directories and files
LOG_DIR="$(dirname "${BASH_SOURCE[0]}")/../logs"
STUBS_DIR="$(dirname "${BASH_SOURCE[0]}")/../stubs"
ALIAS_DIR="$(dirname "${BASH_SOURCE[0]}")/../alias.d"
MANIFEST_FILE="$ALIAS_DIR/MANIFEST.yml"
STUB_FILE_FUNCTION="$STUBS_DIR/func-alias.stub"
LOG_FILE="$LOG_DIR/alias.log"

ALIAS_FILE=''

# Ensure log directory exists
mkdir -p "$LOG_DIR"

# Determine if DEBUG mode is enabled
DEBUG=true
if [[ "$DEBUG" == "true" ]]; then
    DEBUG_LOGGING=true
else
    DEBUG_LOGGING=false
fi

# Function to log messages to the log file
# Arguments:
#   $1 (string): Message to log.
log_message() {
    local log_time
    log_time=$(date +"%Y-%m-%d %H:%M:%S")
    local message="$1"
    
    if [[ "$DEBUG_LOGGING" == "true" ]]; then
        echo "[$log_time] $message" >> "$LOG_FILE"
    fi
}

# Function to open a file in nano for editing
open_in_nano() {
    local file_to_edit="$1"

    read -p "Do you want to edit the alias file now? [Y/n] " choice
    case "$choice" in
        y|Y|"" )
            nano "$file_to_edit"
            ;;
        * )
            echo "Skipping editing."
            ;;
    esac
}

# generate_function_alias_file function generates a new function-based alias file based on user input.
# It prompts the user for alias details, checks for existing aliases, fills in a stub file,
# sets permissions, and registers the alias in the manifest file.
generate_function_alias_file() {
    # Prompt for alias details (assuming prompt_alias_info is defined in utility_functions.sh)
    source "$(dirname "${BASH_SOURCE[0]}")/utility_functions.sh"
    # prompt_alias_info

    # Check for existing aliases (assuming check_alias_keyword is defined in utility_functions.sh)
    # check_alias_keyword

    # Generate alias file (assuming alias_generator.sh returns the generated alias file name)
    ALIAS_FILE=$(bash "$(dirname "${BASH_SOURCE[0]}")/alias_generator.sh")
    log_message "Generated alias file: $ALIAS_FILE"

    # Set permissions (assuming set_permissions is defined in utility_functions.sh)
    set_permissions
    log_message "Set permissions for alias file: $ALIAS_FILE"

    # Register alias in manifest file (assuming register_in_manifest is defined in utility_functions.sh)
    register_in_manifest
    log_message "Registered alias in manifest file: $MANIFEST_FILE"

    log_message "Completed generating function-based alias file: $ALIAS_FILE"

    # Open the generated alias file for editing
    open_in_nano "$ALIAS_DIR/$ALIAS_FILE"
}

# Main script
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    generate_function_alias_file
fi

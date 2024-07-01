#!/bin/bash

sudo -k
<<EOF
User Management Script - Index
Filename: index.sh

This script serves as the main entry point for user management operations. It provides
an interactive menu to add a new user, display user information, rename a user, change
primary group of a user, delete a user, synchronize passwd and shadow files, or exit the script.

Functions:
- None (uses direct script execution)

Usage:
Run this script with sudo to interactively manage users on the system.

Example:
$ sudo ./index.sh
EOF
# Log file path
LOG_FILE="/var/log/user_management.log"

# Function to log messages
log_message() {
    local log_level="$1"
    local message="$2"
    logger -t "UserManagement" -p "${log_level}" "${message}"
}

# Get the directory where this script is located
SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

# Path to individual scripts, relative to the main script's location
ADD_USER_SCRIPT="$SCRIPT_DIR/add_user.sh"
DISPLAY_INFO_SCRIPT="$SCRIPT_DIR/display_user_info.sh"
RENAME_USER_SCRIPT="$SCRIPT_DIR/rename_user.sh"
CHANGE_GROUP_SCRIPT="$SCRIPT_DIR/change_primary_group.sh"
DELETE_USER_SCRIPT="$SCRIPT_DIR/delete_user.sh"
SYNC_PASSWD_SHADOW_SCRIPT="$SCRIPT_DIR/sync_passwd_shadow.sh"  # New script for sync

# Path to .env file and sudo utility script
ENV_FILE="$SCRIPT_DIR/.env"

# Source .env file and sudo utility script
if [ -f "$ENV_FILE" ]; then
    source "$ENV_FILE"
else
    echo "Error: .env file not found in $ENV_FILE. Please create and configure it."
    exit 1
fi

SUDO_UTILITY_SCRIPT="$UTIL_DIR/sudo_utility.sh"
if [ -f "$SUDO_UTILITY_SCRIPT" ]; then
    source "$SUDO_UTILITY_SCRIPT"
else
    echo "Error: Sudo utility script not found in $SUDO_UTILITY_SCRIPT. Please ensure it exists."
    exit 1
fi

# Main loop for interactive user management
while true; do
    echo "User Management Script"
    echo "1. Add a new user"
    echo "2. Display user information"
    echo "3. Rename a user"
    echo "4. Change primary group of a user"
    echo "5. Delete a user"
    echo "6. Sync passwd and shadow files"
    echo "7. Exit"

    read -p "Enter your choice: " choice
    case $choice in
        1) sudo bash "$ADD_USER_SCRIPT" ;;
        2) sudo bash "$DISPLAY_INFO_SCRIPT" ;;
        3) sudo bash "$RENAME_USER_SCRIPT" ;;
        4) sudo bash "$CHANGE_GROUP_SCRIPT" ;;
        5) sudo bash "$DELETE_USER_SCRIPT" ;;
        6) sudo bash "$SYNC_PASSWD_SHADOW_SCRIPT" ;;
        7) echo "Exiting."; break ;;
        *) echo "Invalid choice. Please enter a number between 1 and 7." ;;
    esac
done

# Log script exit
log_message "info" "User management script exited."


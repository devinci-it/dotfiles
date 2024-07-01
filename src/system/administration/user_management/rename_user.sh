#!/bin/bash

sudo -k
<<EOF
User Management Script - Rename User
Filename: rename_user.sh

This script renames an existing user on the system.

Functions:
- rename_user(): Renames a user based on user input.

Usage:
Run this script with sudo to interactively rename an existing user.

Example:
$ sudo ./rename_user.sh
EOF

source ./../.env
source "$UTIL_DIR/sudo_utility.sh"
# Log file path
LOG_FILE="/var/log/user_management.log"

# Function to log messages
log_message() {
    local log_level="$1"
    local message="$2"
    logger -t "UserManagement" -p "${log_level}" "${message}"
}

# Function to rename a user
rename_user() {
    read -p "Enter current username: " current_username
    read -p "Enter new username: " new_username

    if id "$current_username" &>/dev/null; then
        sudo usermod -l "$new_username" "$current_username"
        if [ $? -eq 0 ]; then
            log_message "info" "User $current_username renamed to $new_username successfully."
            echo "User $current_username renamed to $new_username successfully."
        else
            log_message "error" "Failed to rename user $current_username."
            echo "Failed to rename user $current_username."
        fi
    else
        log_message "error" "User $current_username does not exist."
        echo "User $current_username does not exist."
    fi
}

# Execute rename_user function if script is executed as main
if [ "$0" == "${BASH_SOURCE[0]}" ]; then
    require_sudo
    revoke_sudo
    rename_user
fi

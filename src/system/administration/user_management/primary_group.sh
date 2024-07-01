#!/bin/bash

sudo -k
<<EOF
User Management Script - Change Primary Group
Filename: change_primary_group.sh

This script changes the primary group of a specified user.

Functions:
- change_primary_group(): Changes the primary group of a user based on user input.

Usage:
Run this script with sudo to interactively change the primary group of a user.

Example:
$ sudo ./primary_group.sh
EOF
source .env
# Log file path
LOG_FILE="/var/log/user_management.log"

# Function to log messages
log_message() {
    local log_level="$1"
    local message="$2"
    logger -t "UserManagement" -p "${log_level}" "${message}"
}

# Function to change primary group of a user
change_primary_group() {
    read -p "Enter username: " username
    read -p "Enter new primary group: " new_primary_group

    if id "$username" &>/dev/null; then
        sudo usermod -g "$new_primary_group" "$username"
        if [ $? -eq 0 ]; then
            log_message "info" "Primary group of user $username changed to $new_primary_group successfully."
            echo "Primary group of user $username changed to $new_primary_group successfully."
        else
            log_message "error" "Failed to change primary group of user $username."
            echo "Failed to change primary group of user $username."
        fi
    else
        log_message "error" "User $username does not exist."
        echo "User $username does not exist."
    fi
}

# Execute change_primary_group function if script is executed as main
if [ "$0" == "${BASH_SOURCE[0]}" ]; then
    change_primary_group
fi

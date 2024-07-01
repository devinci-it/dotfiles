#!/bin/bash

sudo -k
source .env
source "$UTIL_DIR/sudo_utility.sh"
<<EOF
User Management Script - Delete User
Filename: delete_user.sh

This script deletes an existing user from the system.

Functions:
- delete_user(): Deletes a user based on user input.

Usage:
Run this script with sudo to interactively delete an existing user from the system.

Example:
$ sudo ./delete_user.sh
EOF

# Log file path
LOG_FILE="/var/log/user_management.log"

# Function to log messages
log_message() {
    local log_level="$1"
    local message="$2"
    logger -t "UserManagement" -p "${log_level}" "${message}"
}

# Function to delete a user
delete_user() {
    read -p "Enter username to delete: " username

    if id "$username" &>/dev/null; then
        sudo userdel -r "$username"
        if [ $? -eq 0 ]; then
            log_message "info" "User $username deleted successfully."
            echo "User $username deleted successfully."
        else
            log_message "error" "Failed to delete user $username."
            echo "Failed to delete user $username."
        fi
    else
        log_message "error" "User $username does not exist."
        echo "User $username does not exist."
    fi
}

# Execute delete_user function if script is executed as main
if [ "$0" == "${BASH_SOURCE[0]}" ]; then
    require_sudo
    revoke_sudo
    delete_user
    
fi


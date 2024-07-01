#!/bin/bash

sudo -k
<<EOF
User Management Script - Display User Info
Filename: user_info.sh

This script displays information about a specified user.

Functions:
- display_user_info(): Displays user information based on user input.

Usage:
Run this script with sudo to interactively display information about a user.

Example:
$ sudo ./display_user_info.sh
EOF

# Log file path
LOG_FILE="/var/log/user_management.log"

# Function to log messages
log_message() {
    local log_level="$1"
    local message="$2"
    logger -t "UserManagement" -p "${log_level}" "${message}"
}

# Function to display user information
user_info() {
    read -p "Enter username: " username

    if id "$username" &>/dev/null; then
        log_message "info" "Displaying information for user $username."
        echo "User information for $username:"
        finger "$username"
    else
        log_message "error" "User $username does not exist."
        echo "User $username does not exist."
    fi
}

# Execute display_user_info function if script is executed as main
if [ "$0" == "${BASH_SOURCE[0]}" ]; then
    user_info
fi


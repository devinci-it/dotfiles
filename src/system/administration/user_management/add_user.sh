#!/bin/bash

sudo -k
<<EOF
User Management Script - Add User
Filename: add_user.sh

This script adds a new user to the system. It prompts for user details including
username, full name, primary group, and optionally allows creating a system user
without a login shell and home directory.

Functions:
- sanitize_input(): Sanitizes input by trimming leading and trailing whitespace.
- add_user(): Adds a new user based on user input.

Usage:
Run this script with sudo to interactively add a new user to the system.

Example:
$ sudo ./add_user.sh
EOF

# Log file path
LOG_FILE="/var/log/user_management.log"

# Function to log messages
log_message() {
    local log_level="$1"
    local message="$2"
    logger -t "UserManagement" -p "${log_level}" "${message}"
}

# Function to sanitize input (strip leading/trailing whitespace)
sanitize_input() {
    local input="$1"
    input="${input#"${input%%[![:space:]]*}"}"   # Trim leading whitespace
    input="${input%"${input##*[![:space:]]}"}"   # Trim trailing whitespace
    echo "$input"
}

# Function to add a new user
add_user() {
    read -p "Enter username: " username
    username=$(sanitize_input "$username")
    read -p "Enter full name: " full_name
    full_name=$(sanitize_input "$full_name")
    read -p "Enter primary group (default: users): " primary_group
    primary_group=$(sanitize_input "${primary_group:-users}")
    read -p "Create as system user? (y/n): " is_system_user

    if [ "$is_system_user" == "y" ]; then
        # System user: no login shell and no home directory
        sudo useradd -r -g "$primary_group" -c "$full_name" "$username"
    else
        # Regular user with home directory and default shell
        read -p "Enter home directory (default: /home/$username): " home_dir
        home_dir=$(sanitize_input "${home_dir:-/home/$username}")
        read -p "Enter shell (default: /bin/bash): " shell
        shell=$(sanitize_input "${shell:-/bin/bash}")

        sudo useradd -m -d "$home_dir" -s "$shell" -g "$primary_group" -c "$full_name" "$username"
    fi

    if [ $? -eq 0 ]; then
        log_message "info" "User $username added successfully."
        
        # Set password for the new user
        sudo passwd "$username"
        if [ $? -eq 0 ]; then
            log_message "info" "Password set successfully for user $username."
        else
            log_message "error" "Failed to set password for user $username."
        fi
    else
        log_message "error" "Failed to add user $username."
    fi
}

# Execute add_user function if script is executed as main
if [ "$0" == "${BASH_SOURCE[0]}" ]; then
    add_user
fi

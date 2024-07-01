#!/bin/bash

<<EOF
User Management Script - Sync Passwd and Shadow
Filename: sync.sh

This script synchronizes the 'passwd' and 'shadow' files in Linux to maintain consistency.

Functions:
- sync_passwd_shadow(): Synchronizes the 'passwd' and 'shadow' files securely.

Usage:
Run this script with sudo to synchronize the 'passwd' and 'shadow' files.

Example:
$ sudo ./sync_passwd_shadow.sh

EOF

# Log file path
LOG_FILE="/var/log/user_management.log"

# Function to log messages
log_message() {
local log_level="$1"
local message="$2"
logger -t "UserManagement" -p "${log_level}" "${message}"
}

# Function to synchronize passwd and shadow files
sync_passwd_shadow() {
# Check if user has sufficient privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root (sudo)." >&2
        exit 1
    fi

    # Synchronize passwd and shadow
    pwconv  # Update shadow from passwd
    sync

    # Log synchronization event
    log_message "info" "Passwd and shadow files synchronized."
    echo "Passwd and shadow files synchronized."
}

# Execute sync_passwd_shadow function if script is executed as main
if [ "$0" == "${BASH_SOURCE[0]}" ]; then
    sync_passwd_shadow
fi


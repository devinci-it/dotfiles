#!/bin/bash

<<EOF

Utility Script - Sudo Utility
Filename: sudo_util.sh

This script provides functions to require sudo to execute commands,
and revokes privileges to prevent inheritance for subsequent commands.

Functions:
- require_sudo: Checks and requires sudo privileges for subsequent commands.
- revoke_sudo: Revokes sudo privileges to prevent inheritance.

Usage:
Source this script in your main script to use the functions provided.

Example:
1. source sudo_util.sh
2. require_sudo
3. # Your commands that require sudo privileges
4. revoke_sudo
EOF

# Function to require sudo privileges
require_sudo() {
    if [ "$(id -u)" != "0" ]; then
        echo "This function requires sudo privileges. Please run with sudo."
        exit 1
    fi
    
    # Invalidate sudo credentials for subsequent commands
    sudo -k
}

# Function to revoke sudo privileges
revoke_sudo() {
    # Check if script is run with sudo
    if [ "$(id -u)" == "0" ]; then
        echo "Revoking sudo privileges..."
        sudo -k
    else
        echo "No sudo privileges to revoke."
    fi
}

# If script is executed as main, provide information
if [ "$0" == "${BASH_SOURCE[0]}" ]; then
    echo "This script is meant to be sourced, not executed directly."
    echo "Source this script in your main script to use the functions provided."
fi

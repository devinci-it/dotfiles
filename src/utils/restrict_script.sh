#!/bin/bash

<<EOF
Utility Script - Set File Permissions
Filename: restrict_script.sh

This script sets ownership and permissions for all .sh files in a directory
to restrict access as much as possible (500).

Functions:
- set_permissions(): Sets ownership and permissions for .sh files.

Usage:
Run this script in a directory containing .sh files to set permissions.

Example:
$ ./set_file_permissions.sh
EOF

# Function to set permissions for .sh files
set_permissions() {
    local dir="$1"
    
    if [ -z "$dir" ]; then
        dir="."
    fi

    # Find all .sh files and set permissions
    find "$dir" -type f -name "*.sh" -exec chmod 500 {} \;
    find "$dir" -type f -name "*.sh" -exec chown "$(whoami):$(id -gn)" {} \;
    
    echo "Permissions set to 500 for all .sh files in $dir"
}

# Execute set_permissions function if script is executed as main
if [ "$0" == "${BASH_SOURCE[0]}" ]; then
    set_permissions "$1"
fi


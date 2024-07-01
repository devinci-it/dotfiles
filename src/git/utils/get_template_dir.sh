#!/bin/bash

# Function to get the Git template directory path
get_git_template_dir() {
    local TEMPLATE_DIR=$(git config --get init.templateDir)
    
    if [ -z "$TEMPLATE_DIR" ]; then
        echo "No custom Git template directory is configured."
    else
        echo "Current Git template directory path: $TEMPLATE_DIR"
    fi
}

# Check if sourced or executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    # Script is executed directly, call the function
    get_git_template_dir
fi

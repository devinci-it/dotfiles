#! /bin/bash

# Enable immediate exit on error
set -e

# Function to get the root directory of the Git project
get_git_root() {
    local PROJECT_ROOT=$(git rev-parse --show-toplevel)
    echo "$PROJECT_ROOT"
}

# Set environment variable for Git root directory
export GIT_ROOT=$(get_git_root)

# Check if sourced or executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    # Script is executed directly, print Git root directory
    echo "Git root directory: $GIT_ROOT"
fi











#!/bin/bash

# Function to empty .log files
empty_log_files() {
    # Get the root directory of the Git repository
    repo_root=$(git rev-parse --show-toplevel)

    # Find and empty all .log files
    find "$repo_root" -type f -name '*.log' -exec truncate -s 0 {} +
}

# Call function to empty .log files
empty_log_files

#!/bin/bash

# Source common functions and logging
source "$(dirname "$0")/../git_hooks_common.sh"

# Function to generate commit message template and get staged files
generate_commit_template_and_staged_files() {
    local SCRIPT_DIR="$(get_script_dir)"
    local TEMPLATE_FILE="$SCRIPT_DIR/.commit_template"

    # Generate commit message template
    local VERSION="v0.0.1"  # Default version if no tags are found

    # Check if there are any tags on the current commit
    local TAG=$(git describe --tags --exact-match HEAD 2>/dev/null)
    if [ -n "$TAG" ]; then
        VERSION=$TAG
    fi

    local TEMPLATE="[$VERSION] $(date +"%d %b %Y") :
--------------------------------------------------------


--------------------------------------------------------
ADDED:
"

    # List staged files for "ADDED" section
    git diff --cached --name-status | grep '^A' | cut -f 2- |
    while read -r file; do
        TEMPLATE="$TEMPLATE- $file\n"
    done

    TEMPLATE="$TEMPLATE--------------------------------------------------------
MODIFIED:
"

    # List staged files for "MODIFIED" section
    git diff --cached --name-status | grep '^M' | cut -f 2- |
    while read -r file; do
        TEMPLATE="$TEMPLATE- $file\n"
    done

    TEMPLATE="$TEMPLATE--------------------------------------------------------
DELETED:
"

    # List staged files for "DELETED" section
    git diff --cached --name-status | grep '^D' | cut -f 2- |
    while read -r file; do
        TEMPLATE="$TEMPLATE- $file\n"
    done

    TEMPLATE="$TEMPLATE--------------------------------------------------------
"

    # Write the template to a temp file
    echo -e "$TEMPLATE" > "$TEMPLATE_FILE"

    # Output the list of staged files (optional)
    log_message "Staged files:"
    git diff --cached --name-only

    # Pass the temp file path to the prepare-commit-msg hook
    echo "$TEMPLATE_FILE"
}

# Call function to generate commit template and staged files
generate_commit_template_and_staged_files

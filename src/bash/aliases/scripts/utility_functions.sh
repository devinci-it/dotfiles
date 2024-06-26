#!/bin/bash

# Utility functions for managing aliases and manifests

# calculate_hash function calculates the SHA256 hash of a file.
# Arguments:
#   $1: File path for which hash needs to be calculated.
# Returns:
#   SHA256 hash of the file.
calculate_hash() {
    sha256sum "$1" | cut -d ' ' -f 1
}

# prompt_alias_info function prompts the user to enter alias information.
# It sets the global variable ALIAS_FILE based on user input.
prompt_alias_info() {
    read -p "Enter alias: " alias_name
    read -p "Enter brief description: " alias_description
    read -p "Enter alias string (command): " alias_command
    read -p "Enter arguments (separated by space): " arguments
    read -p "Enter brief description for arguments: " args_description
    ALIAS_FILE="${alias_name}.alias"
}

# check_alias_keyword function checks if the alias keyword already exists in the manifest file.
# It uses yq utility to parse the YAML manifest file.
# If the alias keyword exists, it prints an error message and exits with status 1.
check_alias_keyword() {
    local existing_aliases=""
    if [[ -f "$MANIFEST_FILE" ]]; then
        existing_aliases=$(yq eval '.[].alias-keyword' "$MANIFEST_FILE" 2>/dev/null | grep -E '^"'$alias_name'"$' || true)
    fi

    if [[ -n "$existing_aliases" ]]; then
        echo "Error: Alias keyword \"$alias_name\" already exists in the manifest."
        exit 1
    fi
}

# set_permissions function sets executable and writable permissions (700) to the generated alias file.
set_permissions() {
    chmod 700 "$ALIAS_DIR/$ALIAS_FILE"
}

# register_in_manifest function registers the alias information in the manifest file.
# It generates a unique ID for the alias entry and appends it to the manifest in YAML format.
register_in_manifest() {
    local file_hash=$(calculate_hash "$ALIAS_DIR/$ALIAS_FILE")
    local date_added=$(date +"%Y-%m-%d %H:%M:%S")
    local modified_date="$date_added"
    local alias_keyword="$alias_name"
    local id=$(uuidgen) # Generate a unique id

    # Construct new YAML entry
    local new_entry=$(cat <<EOF
- id: "$id"
  alias-keyword: "$alias_keyword"
  script-path: "$(realpath "$ALIAS_DIR/$ALIAS_FILE")"
  hash: "$file_hash"
  date-added: "$date_added"
  modified-date: "$modified_date"

EOF
)

    # Append new entry to manifest file
    if [ ! -f "$MANIFEST_FILE" ]; then
        echo "$new_entry" > "$MANIFEST_FILE"
    else
        echo "$new_entry" >> "$MANIFEST_FILE"
    fi
}


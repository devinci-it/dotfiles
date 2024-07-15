#!/bin/bash
set -e

# Define variables for stub files and paths
STUBS_DIR="$(dirname "${BASH_SOURCE[0]}")/../stubs"
ALIAS_DIR="$(dirname "${BASH_SOURCE[0]}")/../alias.d"
MANIFEST_FILE="$ALIAS_DIR/MANIFEST.yml"
STUB_FILE_ALIAS="$STUBS_DIR/aliasng.stub"
STUB_FILE_FUNCTION="$STUBS_DIR/func-alias.stub"

ALIAS_FILE=''

# Function to calculate file hash (SHA256)
calculate_hash() {
    sha256sum "$1" | cut -d ' ' -f 1
}

# Function to prompt user for alias information
prompt_alias_info() {
    read -p "Enter alias: " alias_name
    read -p "Enter brief description: " alias_description
    read -p "Enter alias string (command): " alias_command
    read -p "Is this alias argumented? [y/n]: " is_argumented

    if [[ "$is_argumented" == "y" || "$is_argumented" == "Y" ]]; then
        read -p "Enter arguments (separated by space): " arguments
        read -p "Enter brief description for arguments: " args_description
    fi
   ALIAS_FILE="${alias_name}.alias"

}

generate_alias_file() {
    local stub_file
    if [[ "$is_argumented" == "y" || "$is_argumented" == "Y" ]]; then
        stub_file="$STUB_FILE_FUNCTION"
    else
        stub_file="$STUB_FILE_ALIAS"
    fi

    local timestamp=$(date +"%Y%m%d%H%M%S")
    local alias_file="${alias_name}.alias"
    cp "$stub_file" "$ALIAS_DIR/$alias_file"

    # Fill in the alias file with user input
    sed -i "s|<alias-name>|$alias_name|g" "$ALIAS_DIR/$alias_file"
    sed -i "s|<Description of your alias>|$alias_description|g" "$ALIAS_DIR/$alias_file"
    sed -i "s|<command>|$alias_command|g" "$ALIAS_DIR/$alias_file"

    if [[ "$is_argumented" == "y" || "$is_argumented" == "Y" ]]; then
        sed -i "s|<arguments>|$arguments|g" "$ALIAS_DIR/$alias_file"
        sed -i "s|<Description of your alias>|$args_description|g" "$ALIAS_DIR/$alias_file"
    fi
    nano "$ALIAS_DIR/$alias_file"
}

check_alias_keyword() {
    local existing_aliases
    if [[ -f "$MANIFEST_FILE" ]]; then
        existing_aliases=$(yq eval '.[].alias-keyword' "$MANIFEST_FILE" 2>/dev/null | grep -E '^"'$alias_name'"$' || true)
	echo $existing_aliases
    fi

    if [[ -n "$existing_aliases" ]]; then
        echo "Error: Alias keyword \"$alias_name\" already exists in the manifest."
        exit 1
    fi
}


# Function to set permissions: executable and writable only to owner
set_permissions() {
    chmod 700 "$ALIAS_DIR/$ALIAS_FILE"
}

register_in_manifest() {

    local file_hash=$(calculate_hash "$ALIAS_DIR/$ALIAS_FILE")
    local date_added=$(date +"%Y-%m-%d %H:%M:%S")
    local modified_date="$date_added"
    local alias_keyword="$alias_name"
    # Generate a unique id
    local id=$(uuidgen)

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

# Main script
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    prompt_alias_info
    check_alias_keyword
    generate_alias_file
    set_permissions
    register_in_manifest
fi

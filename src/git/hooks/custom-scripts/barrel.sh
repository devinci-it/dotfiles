#!/bin/bash

# Ensure script is executed from its directory
cd "$(dirname "${BASH_SOURCE[0]}")" || exit

# Array of scripts to source
scripts=(
    "append-changelog.sh"
    "generate-commit-template.sh"
    "git-boot.sh"
    "git-extract-changelog.sh"
    "move-templates.sh"
    "semver-tagging.sh"
    "update_manifest.sh"
)

# Manifest file path
MANIFEST="MANIFEST.txt"

# Function to source scripts and set up aliases
setup_scripts() {
    for script in "${scripts[@]}"; do
        if [[ -f "$script" ]]; then
            source "$script"
            # Extract functions from script and create aliases
            while read -r line; do
                if [[ "$line" =~ ^function\ ([^\ ]+) ]]; then
                    alias "${BASH_REMATCH[1]}"="${BASH_REMATCH[1]}"
                fi
            done < <(declare -F)
        fi
    done
}

# Function to update Manifest
update_manifest() {
    echo "Manifest updated at: $(date +"%Y-%m-%d %H:%M:%S")" >> "$MANIFEST"
}

# Function to perform pre-checks
pre_checks() {
    # Check if Manifest exists; create if not
    if [[ ! -f "$MANIFEST" ]]; then
        echo "Manifest file not found. Creating..."
        touch "$MANIFEST"
    fi
}

# Main function to setup environment
main() {
    pre_checks
    setup_scripts
    update_manifest
}

# Execute main function
main


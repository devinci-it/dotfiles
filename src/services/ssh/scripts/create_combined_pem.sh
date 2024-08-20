#!/bin/bash

# ══════════════════════════════════════════════════════════════════════════════════ #
#  Script: create_combined_pem.sh
#  Description: Creates a combined PEM file from the private and public keys.
#  Author: devinci-it
#  Date: $(date +"%Y-%m-%d")
#  Version: 1.3
# ══════════════════════════════════════════════════════════════════════════════════ #

# Function to display help message
print_help() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -n, --key-name      Name for the key pair (default: id_rsa_4096)"
    echo "  -d, --key-dir       Directory to store the key pair (default: \$HOME/.ssh/keys/)"
    echo "  -p, --private       Path to the private key file (default: \$KEY_DIR/\$KEY_NAME)"
    echo "  -u, --public        Path to the public key file (default: \$KEY_DIR/\$KEY_NAME.pub)"
    echo "  -h, --help          Show this help message"
}

# Default values
KEY_NAME="id_rsa_4096"
KEY_DIR="$HOME/.ssh/keys/$KEY_NAME"
PRIVATE_KEY="$KEY_DIR/$KEY_NAME"
PUBLIC_KEY="$KEY_DIR/$KEY_NAME.pub"

# Parse command-line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -n|--key-name) KEY_NAME="$2"; PRIVATE_KEY="$KEY_DIR/$KEY_NAME"; PUBLIC_KEY="$KEY_DIR/$KEY_NAME.pub"; shift ;;
        -d|--key-dir) KEY_DIR="$2"; shift ;;
        -p|--private) PRIVATE_KEY="$2"; shift ;;
        -u|--public) PUBLIC_KEY="$2"; shift ;;
        -h|--help) print_help; exit 0 ;;
        *) echo "Unknown parameter passed: $1"; print_help; exit 1 ;;
    esac
    shift
done

# Ensure the key directory exists
mkdir -p "$(dirname "$PRIVATE_KEY")"

# Variables
COMBINED_PEM="$(dirname "$PRIVATE_KEY")/$(basename "$PRIVATE_KEY").pem"  # Path for the combined PEM file

# Function to check if a file exists
file_exists() {
    if [ ! -f "$1" ]; then
        echo "Error: $1 does not exist."
        exit 1
    fi
}

# Function to create the combined PEM file
create_combined_pem() {
    echo "Creating combined PEM file..."

    # Check if private and public keys exist
    file_exists "$PRIVATE_KEY"
    file_exists "$PUBLIC_KEY"

    # Create the combined PEM file
    cat "$PRIVATE_KEY" > "$COMBINED_PEM"
    echo "" >> "$COMBINED_PEM"  # Ensure there's a newline between keys
    cat "$PUBLIC_KEY" >> "$COMBINED_PEM"

    # Set proper permissions
    chmod 600 "$COMBINED_PEM"

    echo "Combined PEM file created at: $COMBINED_PEM"
}

# Run the function
create_combined_pem

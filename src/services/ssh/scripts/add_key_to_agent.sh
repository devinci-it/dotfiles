#!/bin/bash

# ══════════════════════════════════════════════════════════════════════════════════ #
#  Script: add_key_to_agent.sh
#  Description: Adds the private key to ssh-agent if it is not already added.
#  Author: devinci-it
#  Date: $(date +"%Y-%m-%d")
#  Version: 1.0
# ══════════════════════════════════════════════════════════════════════════════════ #

# Variables
KEY_NAME="id_rsa_4096"  # Name for the key pair
KEY_DIR="$HOME/.ssh/keys/$KEY_NAME"  # Directory to store the key pair
PRIVATE_KEY="$KEY_DIR/$KEY_NAME"  # Path for the private key

# Check if ssh-agent is running
if ! pgrep -x "ssh-agent" > /dev/null; then
    echo "SSH agent not running. Starting..."
    eval "$(ssh-agent -s)"
else
    echo "SSH agent is already running."
fi

# Function to add the private key to ssh-agent
add_key_to_agent() {
    echo "Adding private key to ssh-agent..."
    if ! ssh-add -l | grep -q "$PRIVATE_KEY"; then
        if ssh-add "$PRIVATE_KEY"; then
            echo "Private key added to ssh-agent."
        else
            echo "Error: Failed to add private key to ssh-agent." >&2
            exit 1
        fi
    else
        echo "Private key is already added to ssh-agent."
    fi
}

add_key_to_agent


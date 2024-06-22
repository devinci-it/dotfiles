#!/bin/bash

set -e

# Function to install .aliasrc
install_aliasrc() {
    # Define paths
    INSTALL_DIR="$HOME/.local/opt/alias"
    BIN_DIR="$INSTALL_DIR/bin"
    ALIASRC_SOURCE="$INSTALL_DIR/aliasrc"
    
    # Create installation directory if it doesn't exist
    mkdir -p "$INSTALL_DIR"
    
    # Get current script directory
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    
    # Copy files to installation directory
    bash -c "cp -r '$SCRIPT_DIR'/* '$INSTALL_DIR/'"
    
    # Set permissions
    chmod -R 755 "$INSTALL_DIR"
    chmod +x "$BIN_DIR/alias_conflict.sh"  # Adjust with actual script names
    chmod +x "$BIN_DIR/setup_alias.sh"     # Adjust with actual script names
    
    # Path to .aliasrc in the installation directory
    ALIASRC="$HOME/.aliasrc"
    
    # Check if .aliasrc already exists in user's home directory
    if [[ -e "$ALIASRC" ]]; then
        echo ".aliasrc already exists in your home directory."
    else
        # Create symlink for aliasrc in $HOME as .aliasrc
        ln -s "$ALIASRC_SOURCE" "$ALIASRC"
        echo "Symlink created: $ALIASRC -> $ALIASRC_SOURCE"
    fi
    
    echo "Installation complete."
    
    # Print conditional sourcing instructions for users
    echo
    echo 'if [ -f "$HOME/.aliasrc" ]; then'
    echo '    source "$HOME/.aliasrc"'
    echo 'fi'
}

# Execute the installation function
install_aliasrc

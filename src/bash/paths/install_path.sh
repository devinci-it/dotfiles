#!/bin/bash

set -e

# Function to install pathrc
install_pathrc() {
    # Define paths
    INSTALL_DIR="$HOME/.local/opt/path"
    BIN_DIR="$INSTALL_DIR/bin"
    PATHRC_SOURCE="$INSTALL_DIR/pathrc"
    
    # Create installation directory if it doesn't exist
    mkdir -p "$INSTALL_DIR"
    
    # Get current script directory
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    
    # Copy files to installation directory
    bash -c "cp -r '$SCRIPT_DIR'/* '$INSTALL_DIR/'"
    
    # Set permissions
    chmod -R 755 "$INSTALL_DIR"
    chmod +x "$BIN_DIR/pathrc_script.sh"  # Adjust with actual script names
    
    # Check if .pathrc already exists in user's home directory
    PATHRC="$HOME/.pathrc"
    if [[ -e "$PATHRC" ]]; then
        echo ".pathrc already exists in your home directory."
    else
        # Create symlink for pathrc in $HOME as .pathrc
        ln -s "$PATHRC_SOURCE" "$PATHRC"
        echo "Symlink created: $PATHRC -> $PATHRC_SOURCE"
    fi
    
    echo "Installation complete."
    
    # Print conditional sourcing instructions for users
    echo
    echo 'if [ -f "$HOME/.pathrc" ]; then'
    echo '    source "$HOME/.pathrc"'
    echo 'fi'
}

# Execute the installation function
install_pathrc

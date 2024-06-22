#!/bin/bash

set -e

# Include logger functions from ../bin/logger
source "$(dirname "${BASH_SOURCE[0]}")/../bin/logger"


# Define log file path relative to script location
LOG_FILE="$(dirname "${BASH_SOURCE[0]}")/../logs/install.log"

# Function to unset LOG_FILE on script exit
cleanup() {
    unset LOG_FILE
}

# Trap script exit to ensure cleanup

# Function to install .aliasrc
install_aliasrc() {
    # Define paths
    local INSTALL_DIR="$HOME/.local/opt/alias"
    local BIN_DIR="$INSTALL_DIR/scripts"
    local ALIASRC_SOURCE="$INSTALL_DIR/aliasrc"
    
    # Create installation directory if it doesn't exist
    mkdir -p "$INSTALL_DIR" || { log_error "Failed to create $INSTALL_DIR"; exit 1; }
    
    # Get current script directory
    local SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
    
    # Copy files to installation directory
    cp -r "$SCRIPT_DIR"/* "$INSTALL_DIR/" || { log_error "Failed to copy files to $INSTALL_DIR"; exit 1; }
    
    # Set permissions
    chmod -R 755 "$INSTALL_DIR"
    chmod +x "$BIN_DIR/alias_conflict.sh"  # Adjust with actual script names
    chmod +x "$BIN_DIR/setup_alias.sh"     # Adjust with actual script names
    
    # Path to .aliasrc in the installation directory
    local ALIASRC="$HOME/.aliasrc"
    
    # Check if .aliasrc already exists in user's home directory
    if [[ -e "$ALIASRC" ]]; then
        log_info ".aliasrc already exists in your home directory."
    else
        # Create symlink for aliasrc in $HOME as .aliasrc
        ln -s "$ALIASRC_SOURCE" "$ALIASRC" || { log_error "Failed to create symlink $ALIASRC"; exit 1; }
        log_info "Symlink created: $ALIASRC -> $ALIASRC_SOURCE"
    fi
    
    log_info "Installation complete."
    
    # Print conditional sourcing instructions for users
    echo
    echo 'if [ -f "$HOME/.aliasrc" ]; then'
    echo '    source "$HOME/.aliasrc"'
    echo 'fi'
}

# Function to temporarily add ../bin to PATH relative to script's location
add_bin_to_path() {
    local script_dir="$(dirname "${BASH_SOURCE[0]}")"
    local bin_dir="$script_dir/../bin"
    
    if [[ -d "$bin_dir" ]]; then
        export PATH="$bin_dir:$PATH"
        log_debug "Added $bin_dir to PATH."
    else
        log_warning "$bin_dir not found."
    fi
}

# Function to set ../test as $HOME (optional)
set_test_home() {
    local script_dir="$(dirname "${BASH_SOURCE[0]}")"
    local test_home="$script_dir/../test"
    
    if [[ -d "$test_home" ]]; then
        export HOME="$test_home"
        log_debug "Set HOME to $test_home."
    else
        log_warning "$test_home not found."
    fi
}

# Main installation process
install() {
    add_bin_to_path
    set_test_home  # Comment out if not needed
    
    log_debug "Starting installation process..."
    
    # Execute installation function
    install_aliasrc
    
    log_debug "Installation process complete."
}

# Execute the main installation process
install

# Define log file path relative to script location

# Trap script exit to ensure cleanup
trap cleanup EXIT

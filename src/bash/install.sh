#!/bin/bash

set -e

. bin/env activate
# Function to encapsulate the entire script
main() {
    # Determine the directory of the script (install.sh)
    local SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    
    # Source logger script (assuming it's in bin/logger)
    source "$SCRIPT_DIR/bin/logger"
    
    log_info "Initial SCRIPT_DIR: $SCRIPT_DIR"
    
    # Define an associative array to track environment variables
    declare -A ENV_TRACKER
    
    # Function to set environment variables and track them
    set_env() {
        local var_name="$1"
        local var_value="$2"
        
        # Set the environment variable
        export "$var_name"="$var_value"
        
        # Track the environment variable in ENV_TRACKER
        ENV_TRACKER["$var_name"]="set"
        
        log_info "Set $var_name=$var_value"
    }
    
    # Function to unset tracked environment variables
    unset_tracked_env() {
        log_info "Cleaning up tracked environment variables..."
        for var_name in "${!ENV_TRACKER[@]}"; do
            unset "$var_name"
            log_info "Unset $var_name"
        done
        log_info "Cleanup of tracked environment variables complete."
    }
    
    # Function to install aliases
    install_aliases() {
        log_info "Installing aliases..."
        log_info "SCRIPT_DIR in install_aliases: $SCRIPT_DIR"
        
        # Check if install_alias.sh exists in aliases directory
        if [[ -f "$SCRIPT_DIR/aliases/install_alias.sh" ]]; then
            # Execute installation script for aliases
            log_info "Script directory before executing aliases: $(pwd)"
            "$SCRIPT_DIR/aliases/install_alias.sh" || { log_error "Failed to execute install_alias.sh."; return 1; }
            log_info "Aliases installation complete."
        else
            log_error "install_alias.sh not found in $SCRIPT_DIR/aliases directory."
            return 1
        fi
    }
    
    # Function to install paths
    install_paths() {
        log_info "Installing paths..."
        log_info "SCRIPT_DIR in install_paths: $SCRIPT_DIR"
        
        # Check if install_path.sh exists in paths directory
        if [[ -f "$SCRIPT_DIR/paths/install_path.sh" ]]; then
            # Execute installation script for paths
            log_info "Script directory before executing paths: $(pwd)"
            "$SCRIPT_DIR/paths/install_path.sh" || { log_error "Failed to execute install_path.sh."; return 1; }
            log_info "Paths installation complete."
        else
            log_error "install_path.sh not found in $SCRIPT_DIR/paths directory."
            return 1
        fi
    }
    
    # Main installation function
    install_main() {
        log_info "Starting installation process..."
        log_info "SCRIPT_DIR in install_main: $SCRIPT_DIR"
        
        # Set HOME dynamically
        set_env "HOME" "$SCRIPT_DIR/../test_home"
        
        # Install aliases
        install_aliases || { log_error "Failed to install aliases."; exit 1; }
        
        # Install paths
        install_paths || { log_error "Failed to install paths."; exit 1; }
        
        log_info "Installation process complete."
    }
    
    # Function to clean up environment
    cleanup() {
        log_info "Cleaning up..."
        unset_tracked_env
        # Add more cleanup tasks as needed
        
        log_info "Cleanup complete."
        . bin/env deactivate    
}
    
    # Trap signals to ensure cleanup on exit
    trap cleanup EXIT
    
    # Execute main installation function
    install_main
}

# Call the main function to start the script
main

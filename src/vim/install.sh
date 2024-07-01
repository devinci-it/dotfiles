#!/bin/bash

# Define paths
INSTALL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_VIMRC="$HOME/.vimrc"
LOCAL_VIM_DIR="$HOME/.local/opt/vim"
NEW_VIMRC="$INSTALL_DIR/vimrc"

# Heredoc for script overview and filename
cat <<EOF
################################################################################
# Install Script for Vim Configuration
#
# Filename: install.sh
#
# Overview:
# This script installs Vim configuration files by copying the directory to
# \$HOME/.local/opt/vim and creating a symbolic link for the vimrc file in
# \$HOME/.vimrc.
#
################################################################################

EOF

# Function to create target directory if it doesn't exist
create_target_directory() {
    mkdir -p "$LOCAL_VIM_DIR"
    echo "Created directory: $LOCAL_VIM_DIR"
}

# Function to copy the entire directory to $HOME/.local/opt/vim
copy_directory() {
    cp -r "$INSTALL_DIR" "$LOCAL_VIM_DIR"
    echo "Copied $INSTALL_DIR to $LOCAL_VIM_DIR"
}

# Function to symlink the vimrc file to $HOME/.vimrc
create_symlink() {
    ln -sf "$NEW_VIMRC" "$HOME_VIMRC"
    echo "Created symlink: $NEW_VIMRC -> $HOME_VIMRC"
}

# Main function that executes installation steps
main() {
    # Ensure the target directory exists
    create_target_directory

    # Copy the directory to $HOME/.local/opt/vim
    copy_directory

    # Create symlink for vimrc to $HOME/.vimrc
    create_symlink

    echo "Installation completed."
}

# Check if script is being executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    # Call the main function
    main
fi

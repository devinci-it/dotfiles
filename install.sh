#! /bin/bash

#!/bin/bash

# Define dotfiles directory
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$DOTFILES_DIR/dotfiles.backup"

# Function to create symlinks
link_file() {
    SOURCE=$1
    TARGET=$2

    if [ -e "$TARGET" -o -L "$TARGET" ]; then
        # File or symlink already exists
        read -p "$TARGET already exists. Do you want to overwrite it? (y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            # Backup existing file
            mv "$TARGET" "$BACKUP_DIR/$(basename $TARGET).$(date +%Y%m%d%H%M%S)"
            ln -s "$SOURCE" "$TARGET"
            echo "Linked $TARGET"
        else
            echo "Skipping $TARGET: File not linked."
        fi
    else
        # Link file if it doesn't exist
        ln -s "$SOURCE" "$TARGET"
        echo "Linked $TARGET"
    fi
}

# Example: Link Vim configuration
link_file "$DOTFILES_DIR/vim/.vimrc" "$HOME/.vimrc"
link_file "$DOTFILES_DIR/vim/.vim" "$HOME/.vim"

# Example: Link Bash configuration
link_file "$DOTFILES_DIR/bash/.bashrc" "$HOME/.bashrc"
link_file "$DOTFILES_DIR/bash/.bash_profile" "$HOME/.bash_profile"

# Add more links as needed for other applications

echo "Dotfiles installation complete."


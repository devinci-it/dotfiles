#!/bin/bash

# Define the installation directory
INSTALL_DIR="$HOME/.local/opt/paths"

# Check if PATH_DEBUG is set to true
if [ "$PATH_DEBUG" = true ]; then
  INSTALL_DIR="$(dirname "${BASH_SOURCE[0]}")/test_installation"
  echo "PATH_DEBUG is true. Using $INSTALL_DIR as installation directory."
fi

# Create the installation directory if it doesn't exist
if [ ! -d "$INSTALL_DIR" ]; then
  mkdir -p "$INSTALL_DIR"
  echo "Created directory $INSTALL_DIR"
fi

# Copy files and directories to the installation directory
cp -r path.d "$INSTALL_DIR/"
cp pathrc "$INSTALL_DIR/"
cp install_path.sh "$INSTALL_DIR/"
cp README.md "$INSTALL_DIR/"
cp -r scripts "$INSTALL_DIR/"
cp -r stubs "$INSTALL_DIR/"

echo "Copied files to $INSTALL_DIR"

# Create symbolic links in the user's home directory
ln -sf "$INSTALL_DIR/pathrc" "$HOME/.pathrc"
ln -sf "$INSTALL_DIR/path.d" "$HOME/.path.d"

echo "Created symbolic links in $HOME"

# Print final message
echo "Installation completed successfully."
echo "Source the paths by adding the following line to your .bashrc or .zshrc:"
echo "source \$HOME/.pathrc"

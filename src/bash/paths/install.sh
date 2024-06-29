#!/bin/bash

# Define the installation directory
INSTALL_DIR="$HOME/.local/opt/paths"

# Define the log file paths
LOG_DIR="$(dirname "${BASH_SOURCE[0]}")/logs"
INSTALL_LOG="$LOG_DIR/install.log"
ERROR_LOG="$LOG_DIR/error.log"

# Logger function to log messages
log_message() {
  local message="$1"
  local log_file="$2"
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $message" | tee -a "$log_file"
}

# Function to create the installation directory
create_install_dir() {
  if [ ! -d "$INSTALL_DIR" ]; then
    mkdir -p "$INSTALL_DIR"
    log_message "Created directory $INSTALL_DIR" "$INSTALL_LOG"
  fi
}

# Function to copy files to the installation directory
copy_files() {
  cp -r path.d "$INSTALL_DIR/" || log_message "Failed to copy path.d" "$ERROR_LOG"
  cp pathrc "$INSTALL_DIR/" || log_message "Failed to copy pathrc" "$ERROR_LOG"
  cp install_path.sh "$INSTALL_DIR/" || log_message "Failed to copy install_path.sh" "$ERROR_LOG"
  cp README.md "$INSTALL_DIR/" || log_message "Failed to copy README.md" "$ERROR_LOG"
  cp -r scripts "$INSTALL_DIR/" || log_message "Failed to copy scripts" "$ERROR_LOG"
  cp -r stubs "$INSTALL_DIR/" || log_message "Failed to copy stubs" "$ERROR_LOG"
  log_message "Copied files to $INSTALL_DIR" "$INSTALL_LOG"
}

# Function to create symbolic links
create_symlinks() {
  local expanded_install_dir
  expanded_install_dir=$(readlink -f "$INSTALL_DIR")
  ln -sf "$expanded_install_dir/pathrc" "$HOME/.pathrc"
  ln -sf "$expanded_install_dir/path.d" "$HOME/.path.d"
  log_message "Created symbolic links in $HOME" "$INSTALL_LOG"
}

# Main installation function
main() {
  # Create the log directory
  mkdir -p "$LOG_DIR"

  # Check if PATH_DEBUG is set to true
  if [ "$PATH_DEBUG" = true ]; then
    # Create a test directory in the script's directory and use it as HOME
    TEST_HOME="$(dirname "${BASH_SOURCE[0]}")/test_path"
    INSTALL_DIR="$TEST_HOME/.local/opt/paths"
    log_message "PATH_DEBUG is true. Using $INSTALL_DIR as installation directory." "$INSTALL_LOG"

    # Create the test home directory
    mkdir -p "$TEST_HOME"
    export HOME="$TEST_HOME"
    log_message "Using $HOME as HOME directory in debug mode." "$INSTALL_LOG"
  fi

  create_install_dir
  copy_files
  create_symlinks

  # Print final message
  echo "Installation completed successfully."
  echo "Source the paths by adding the following line to your .bashrc or .zshrc:"
  echo "source \$HOME/.pathrc"
}

# Run the main function
main

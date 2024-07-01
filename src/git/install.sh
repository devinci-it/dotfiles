#!/bin/bash

# Source logger functions

# Log file path
export LOG_FILE="install.log"

# Define source and destination directories
SOURCE_DIR="$(cd "$(dirname "$0")" && pwd)"
DEST_DIR="$HOME/.local/opt/git-template"
SYMLINK_DIR="$HOME/.git-template"
UTILS_DIR="$SOURCE_DIR/../utils"

source "$SOURCE_DIR/../utils/index.sh"
# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if a file or directory exists
check_exists() {
    local PATH_TO_CHECK="$1"

    if [ -e "$PATH_TO_CHECK" ]; then
        log_message "Exists: $PATH_TO_CHECK"
        return 0
    else
        log_message "$PATH_TO_CHECK does not exist."
        return 1
    fi
}

# Function to prompt for confirmation
confirm() {
    while true; do
        read -rp "$1 (y/n): " response
        case $response in
            [yY]) return 0 ;;
            [nN]) return 1 ;;
            *) echo "Invalid input. Please enter 'y' or 'n'." ;;
        esac
    done
}

# Step 0: Source index.sh from utils directory
source "$UTILS_DIR/index.sh"

# Step 1: Copy the directory to /opt/git-template
log_message "Copying $SOURCE_DIR to $DEST_DIR..."
check_exists "$DEST_DIR"
if [ $? -eq 0 ]; then
    log_message "Directory $DEST_DIR already exists. Removing it..."
    rm -rf "$DEST_DIR"
fi
cp -r "$SOURCE_DIR" "$DEST_DIR" >> "$LOG_FILE" 2>&1

# Step 2: Create a symbolic link to ~/.git-template
log_message "Creating a symbolic link to $SYMLINK_DIR..."
check_exists "$SYMLINK_DIR"
if [ $? -eq 0 ]; then
    log_message "Symbolic link or directory $SYMLINK_DIR already exists."
    if ! confirm "Do you want to overwrite it?"; then
        log_message "Skipping overwrite."
        exit 0
    else
        log_message "Removing $SYMLINK_DIR..."
        rm -rf "$SYMLINK_DIR"
    fi
fi
ln -s "$DEST_DIR" "$SYMLINK_DIR" >> "$LOG_FILE" 2>&1

# Step 3: Set the Git configuration to use ~/.git-template
log_message "Configuring Git to use $SYMLINK_DIR as the template directory..."
git config --global init.templateDir "$SYMLINK_DIR" >> "$LOG_FILE" 2>&1

echo "Installation complete. Check $LOG_FILE for details."

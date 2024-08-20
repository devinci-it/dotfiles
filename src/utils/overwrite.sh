#!/bin/bash


# Function to overwrite a file or directory with backup
overwrite() {
    # Check if source and destination paths are provided
    if [ -z "$1" ] || [ -z "$2" ]; then
        log_error "Usage: overwrite <source-path> <destination-path>"
        return 1
    fi

    local SOURCE_PATH="$1"
    local DEST_PATH="$2"
    local BACKUP_DIR="/tmp/backup_$(date +"%Y%m%d_%H%M%S")"

    # Function to create a backup
    create_backup() {
        mkdir -p "$BACKUP_DIR"
        if [ -e "$DEST_PATH" ]; then
            cp -r "$DEST_PATH" "$BACKUP_DIR"
            if [ $? -eq 0 ]; then
                log_message "Backup of $DEST_PATH created at $BACKUP_DIR"
            else
                log_error "Failed to create backup of $DEST_PATH"
                return 1
            fi
        fi
    }

    # Create a backup of the destination
    create_backup

    # Overwrite the destination with the source
    rm -rf "$DEST_PATH"
    cp -r "$SOURCE_PATH" "$DEST_PATH"

    # Check if the overwrite was successful
    if [ $? -eq 0 ]; then
        log_message "Successfully overwritten $DEST_PATH with $SOURCE_PATH"
    else
        log_error "Failed to overwrite $DEST_PATH with $SOURCE_PATH"
        return 1
    fi
}

# Log message when script is sourced
log_message "overwrite function is now available"


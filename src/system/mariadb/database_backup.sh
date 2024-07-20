#!/bin/bash

# Function to load configuration from config.ini
load_config() {
    # Check if config file exists
    if [ ! -f "config.ini" ]; then
        echo "Error: config.ini not found. Please create the config file." >&2
        exit 1
    fi

    # Read config.ini
    source config.ini

    # Check if required configuration values are set
    if [ -z "$backup_dir" ] || [ -z "$db_name" ] || [ -z "$db_user" ] || [ -z "$db_password" ]; then
        echo "Error: Missing required configuration values in config.ini. Please check the file." >&2
        exit 1
    fi
}

# Function to perform full database backup
perform_full_backup() {
    local timestamp=$(date +'%Y%m%d_%H%M%S')
    local backup_file="$backup_dir/${db_name}_full_${timestamp}.sql.gz"

    echo "Starting full backup for database '$db_name'..."

    # Perform full backup using mysqldump
    mysqldump -u"$db_user" -p"$db_password" "$db_name" | gzip > "$backup_file"

    if [ $? -eq 0 ]; then
        echo "Full backup successfully created: $backup_file"
    else
        echo "Error: Full backup failed." >&2
        exit 1
    fi
}

# Function to perform incremental database backup
perform_incremental_backup() {
    local timestamp=$(date +'%Y%m%d_%H%M%S')
    local incremental_file="$backup_dir/${db_name}_incremental_${timestamp}.sql.gz"

    echo "Starting incremental backup for database '$db_name'..."

    # Perform incremental backup using mysqldump with --no-create-info to skip table structure
    mysqldump -u"$db_user" -p"$db_password" --no-create-info "$db_name" | gzip > "$incremental_file"

    if [ $? -eq 0 ]; then
        echo "Incremental backup successfully created: $incremental_file"
    else
        echo "Error: Incremental backup failed." >&2
        exit 1
    fi
}

# Function to restore database from backup
restore_database() {
    local backup_file="$1"

    echo "Starting database restoration from backup file: $backup_file..."

    # Ensure user confirmation before restoration
    read -p "This will overwrite the current database. Are you sure? (y/n): " confirm
    if [ "$confirm" != "y" ]; then
        echo "Restoration canceled."
        exit 0
    fi

    # Drop existing database
    echo "Dropping existing database '$db_name'..."
    mysql -u"$db_user" -p"$db_password" -e "DROP DATABASE IF EXISTS $db_name;"

    # Create new database
    echo "Creating new database '$db_name'..."
    mysql -u"$db_user" -p"$db_password" -e "CREATE DATABASE $db_name;"

    # Restore database from backup
    echo "Restoring database from '$backup_file'..."
    gunzip < "$backup_file" | mysql -u"$db_user" -p"$db_password" "$db_name"

    if [ $? -eq 0 ]; then
        echo "Database restoration completed successfully."
    else
        echo "Error: Database restoration failed." >&2
        exit 1
    fi
}

# Main function
main() {
    load_config

    case "$1" in
        backup)
            perform_full_backup
            ;;
        incremental)
            perform_incremental_backup
            ;;
        restore)
            restore_database "$2"
            ;;
        *)
            echo "Usage: $0 {backup|incremental|restore <backup_file>}"
            exit 1
            ;;
    esac
}

# Execute main function with arguments passed to the script
main "$@"


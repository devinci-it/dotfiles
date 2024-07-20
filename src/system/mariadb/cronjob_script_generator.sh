#!/bin/bash

#######################################
# Cron Job Script Generator
# Generates cron job scripts for database backups based on specified durations.
#######################################

# Function to generate cron job script for daily backups
generate_daily_cron_script() {
    local cron_script="cron_backup_daily.sh"

    cat > "$cron_script" <<EOF
#!/bin/bash

# Cron script for daily backups

# Load configuration from config.ini
source config.ini

# Perform full backup daily at midnight
0 0 * * * /bin/bash $(pwd)/backup.sh backup

EOF

    chmod +x "$cron_script"
    echo "Daily cron job script '$cron_script' has been generated:"
    echo "---------------------------------------------"
    cat "$cron_script"
    echo "---------------------------------------------"
}

# Function to generate cron job script for hourly backups
generate_hourly_cron_script() {
    local cron_script="cron_backup_hourly.sh"

    cat > "$cron_script" <<EOF
#!/bin/bash

# Cron script for hourly backups

# Load configuration from config.ini
source config.ini

# Perform incremental backup hourly
@hourly /bin/bash $(pwd)/backup.sh incremental

EOF

    chmod +x "$cron_script"
    echo "Hourly cron job script '$cron_script' has been generated:"
    echo "---------------------------------------------"
    cat "$cron_script"
    echo "---------------------------------------------"
}

# Function to generate custom cron job script
generate_custom_cron_script() {
    local cron_script="cron_backup_custom.sh"

    cat > "$cron_script" <<EOF
#!/bin/bash

# Cron script for custom backups

# Load configuration from config.ini
source config.ini

# Specify your custom cron schedule here
# Example: Perform backup every 6 hours
0 */6 * * * /bin/bash $(pwd)/backup.sh incremental

EOF

    chmod +x "$cron_script"
    echo "Custom cron job script '$cron_script' has been generated:"
    echo "---------------------------------------------"
    cat "$cron_script"
    echo "---------------------------------------------"
}

# Function to display usage information
usage() {
    echo "Usage: $0 <duration>"
    echo "Duration options:"
    echo "  - daily: Daily backups"
    echo "  - hourly: Hourly backups"
    echo "  - custom: Custom backup schedule"
    exit 1
}

# Main function to handle script execution
main() {
    # Check if exactly one argument is provided
    if [ $# -ne 1 ]; then
        usage
    fi

    duration="$1"

    # Determine which type of cron job script to generate based on duration
    case "$duration" in
        daily)
            generate_daily_cron_script
            ;;
        hourly)
            generate_hourly_cron_script
            ;;
        custom)
            generate_custom_cron_script
            ;;
        *)
            usage
            ;;
    esac
}

# Execute the main function with the provided argument
main "$@"

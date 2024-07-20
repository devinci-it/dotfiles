#!/bin/bash
#
# Certificate Renewal Script
# Author: Vincent
#
# This script automates the renewal of SSL certificates using Certbot
# and manages the Apache web server.
#
# Functions:
# - stop_apache(): Stops the Apache web server.
# - start_apache(): Starts the Apache web server.
# - dry_run_renewal(): Performs a dry run renewal with Certbot.
#   If successful, proceeds with the actual renewal.
#   If errors occur, starts Apache.
# - actual_renewal(): Performs the actual renewal with Certbot.
#   Prints success or error messages based on renewal outcome.
#   Always starts Apache after renewal attempt.
# - renew_certificates(): Orchestrates the entire certificate renewal process.
#   Stops Apache, performs dry run renewal, and manages the flow based on outcomes.
#
# Usage: Ensure Certbot is installed and configured properly with required certificates.
#        Run this script with appropriate permissions to stop/start Apache and run Certbot.
#

# Function to stop Apache (no sudo required)
stop_apache() {
    systemctl stop apache2
}

# Function to start Apache (no sudo required)
start_apache() {
    systemctl start apache2
}

# Function for Certbot dry run renewal
dry_run_renewal() {
    if sudo certbot renew --dry-run; then
        echo "Dry run successful. Proceeding with actual renewal."
        actual_renewal
    else
        echo "Dry run encountered errors."
        start_apache
    fi
}

# Function for Certbot actual renewal
actual_renewal() {
    if sudo certbot renew; then
        echo "Certificate renewal successful."
    else
        echo "Certificate renewal encountered errors."
    fi
    start_apache
}

# Main function to orchestrate the renewal process
renew_certificates() {
    stop_apache
    dry_run_renewal
}

# Call the main function to renew certificates
renew_certificates

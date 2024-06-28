
#!/bin/bash
#
# Netatalk Installation Script for Time Machine Backup
#
# This script automates the installation and configuration of Netatalk
# on Debian-based systems (like Ubuntu) for setting up a Time Machine
# backup server. It installs necessary packages, configures Netatalk
# to support Time Machine backups, sets permissions, and restarts the
# Netatalk service.
#
# Requirements:
# - sudo privileges
#
# Usage:
# 1. Make the script executable:
#    chmod +x netatalk_install.sh
#
# 2. Run the script with sudo privileges:
#    sudo ./netatalk_install.sh
#
# If the environment variable TIME_MACHINE_MNT is not set, the script
# will prompt for the path to the Time Machine backup directory.
#

# Check if TIME_MACHINE_MNT is set, otherwise prompt
if [ -z ${TIME_MACHINE_MNT+x} ]; then
    read -p "Enter the path for Time Machine backup directory: " TIME_MACHINE_MNT
fi

# Update package repositories
sudo apt update

# Install Netatalk and required packages
sudo apt install -y netatalk avahi-daemon libnss-mdns

# Backup original configuration file
sudo cp /etc/netatalk/afp.conf /etc/netatalk/afp.conf.bak

# Create a new Netatalk configuration
sudo tee /etc/netatalk/afp.conf > /dev/null <<EOF
[Global]
  mimic model = TimeCapsule6,106
  log file = /var/log/afpd.log
  log level = default:warn

[TimeMachine]
  path = $TIME_MACHINE_MNT
  time machine = yes
  valid users = $USER
EOF

# Create Time Machine backup directory if it doesn't exist
if [ ! -d "$TIME_MACHINE_MNT" ]; then
    sudo mkdir -p "$TIME_MACHINE_MNT"
fi

# Set permissions on Time Machine backup directory
sudo chown -R $USER:$USER "$TIME_MACHINE_MNT"
sudo chmod -R 775 "$TIME_MACHINE_MNT"

# Restart Netatalk service
sudo systemctl restart netatalk

echo "Netatalk installation and configuration completed."

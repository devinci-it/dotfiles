# Netatalk Installation Script for Time Machine Backup

---

## Overview
This script automates the installation and configuration of Netatalk on Debian-based systems (like Ubuntu) to set up a Time Machine backup server. Netatalk allows Mac users to back up their computers using Time Machine over the network.

## Features
- Installs Netatalk and necessary dependencies.
- Configures Netatalk to support Time Machine backups.
- Sets permissions and creates directories as needed.
- Restarts Netatalk service for changes to take effect.

## Requirements
- sudo privileges on the server.
- Environment variable `TIME_MACHINE_MNT` must be set or will prompt for the Time Machine backup directory path if not set.

## Usage
1. **Make the script executable:**
   ```bash
   chmod +x install.sh
   ```

2. **Run the script with sudo privileges:**
   ```bash
   ./install.sh
   ```

3. **Follow prompts (if necessary):**
   - Enter the path for the Time Machine backup directory when prompted.

## Notes
- Ensure that the script is executed on a Debian-based system with internet access.
- Monitor script output for any errors or warnings during execution.
- Customize the script as needed for specific environment configurations or additional features.


# User Management Scripts

This repository contains a set of scripts for managing users on a Linux system. Each script performs specific tasks related to user administration.

## Scripts Overview

- **add_user.sh**: Adds a new user to the system.
- **delete_user.sh**: Deletes an existing user from the system.
- **index.sh**: Main script providing an interactive menu for user management operations.
- **primary_group.sh**: Changes the primary group of a user.
- **rename_user.sh**: Renames an existing user.
- **sync.sh**: Synchronizes system files such as `passwd` and `shadow`.
- **user_info.sh**: Displays information about a specific user.
- **.env**: Configuration file containing environment variables for user management scripts.

## Usage

### Prerequisites

- Ensure you have `sudo` privileges to execute these scripts.
- The `.env` file should be configured with necessary environment variables.

### Running Scripts

1. **add_user.sh**

   ```bash
   sudo ./add_user.sh
   ```

   Follow the prompts to add a new user.

2. **delete_user.sh**

   ```bash
   sudo ./delete_user.sh
   ```

   Follow the prompts to delete an existing user.

3. **index.sh**

   ```bash
   sudo ./index.sh
   ```

   Use the interactive menu to perform various user management tasks.

4. **primary_group.sh**

   ```bash
   sudo ./primary_group.sh
   ```

   Follow the prompts to change the primary group of a user.

5. **rename_user.sh**

   ```bash
   sudo ./rename_user.sh
   ```

   Follow the prompts to rename an existing user.

6. **sync.sh**

   ```bash
   sudo ./sync.sh
   ```

   Synchronize system files such as `passwd` and `shadow`.

7. **user_info.sh**

   ```bash
   sudo ./user_info.sh
   ```

   Follow the prompts to display information about a specific user.

## Configuration (.env)

The `.env` file contains environment variables used by the user management scripts. Ensure it is properly configured before running the scripts.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

### Notes:

- Customize the descriptions and usage instructions further based on the actual functionality and requirements of each script.
- Ensure all scripts (`add_user.sh`, `delete_user.sh`, etc.) have executable permissions (`chmod +x script_name.sh`).
- Provide any additional information or instructions that may help users understand and use your scripts effectively in a Linux environment.


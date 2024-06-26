 #  Alias Management System

Welcome to the Alias Management System! This system enhances command-line productivity by providing tools to manage and generate alias scripts effectively.

## Table of Contents

1. [Overview](#overview)
2. [Directory Structure](#directory-structure)
3. [Installation](#installation)
4. [Usage](#usage)
5. [Managing Aliases](#managing-aliases)
6. [Logging and Debugging](#logging-and-debugging)
7. [Contributing](#contributing)
8. [License](#license)

## Overview

The Alias Management System simplifies the creation, management, and utilization of command-line aliases. It includes scripts for installation, alias generation, setup, and centralized sourcing for enhanced usability.

## Directory Structure

| Directory/File       | Description                                                                 |
|----------------------|-----------------------------------------------------------------------------|
| **`aliases/`**       | Root directory for the alias management system.                               |
| **`├── alias.d/`**   | Directory for executable alias scripts (`*.alias` files).                     |
| **`│   ├── aka.alias`** | Example alias script serving as a template for adding new aliases.          |
| **`│   ├── getignore.alias`** | Example alias script demonstrating specific command aliases.              |
| **`│   ├── MANIFEST.test.yml`** | Example manifest file for testing purposes.                               |
| **`│   └── MANIFEST.yml`** | Main manifest file listing all registered aliases for centralized management. |
| **`├── aliasrc`**    | Central script (`~/.aliasrc`) responsible for sourcing alias files from `alias.d`. |
| **`├── install_alias.sh`** | Installation script to set up the alias management system.                 |
| **`├── logs/`**       | Directory for log files (`alias.log`) to track operations and debug alias configurations. |
| **`├── scripts/`**    | Directory for utility and setup scripts.                                      |
| **`│   ├── alias_conflict.sh`** | Utility script to resolve conflicts between alias definitions.            |
| **`│   ├── alias_generator.sh`** | Script to generate alias files based on user input and templates.         |
| **`│   ├── function_alias.sh`** | Script to interactively generate complex function-based aliases.          |
| **`│   ├── setup_alias.sh`** | Setup script to configure and customize alias settings.                    |
| **`│   └── utility_functions.sh`** | Common utility functions shared across scripts.                           |
| **`└── stubs/`**      | Directory for alias stub files used as templates for creating new aliases.   |
| **`    ├── alias.stub`** | Example alias stub file providing a template for simple alias definitions.  |
| **`    └── func-alias.stub`** | Example function alias stub file offering a template for more complex alias configurations. |

## Installation

To install the Alias Management System, follow these steps:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/devinci-it/dotfiles
   cd dotfiles/src/bash/aliases
   ```

2. **Run the installation script:**
   ```bash
   ./install_alias.sh
   ```

   This script sets up the alias management system:
   - Copies necessary files to `~/.local/opt/alias`.
   - Creates symbolic link `.aliasrc` in the user's home directory for centralized alias sourcing.
   - Sets appropriate permissions and ownership for alias scripts and directories.
   - Updates `MANIFEST.yml` with registered aliases.

3. **Source `.aliasrc` to activate aliases:**
   After installation, ensure `.aliasrc` is properly sourced in your shell configuration file (e.g., `~/.bashrc`, `~/.zshrc`):

   ```bash
   if [ -f "$HOME/.aliasrc" ]; then
       source "$HOME/.aliasrc"
   fi
   ```

## Usage

### Adding New Aliases

#### Default Alias Addition:

Use `aka.alias` as a template for adding new aliases:

```bash
# Example usage
cp stubs/alias.stub alias.d/new_alias.alias
```

#### Generating Function-Based Aliases:

For interactive creation of function-based aliases:

```bash
./scripts/function_alias.sh
```

This script prompts for alias details, generates the `.alias` file in `alias.d`, and updates `MANIFEST.yml`.

### Managing Aliases

- **Centralized Management:**
  `.aliasrc` sources all `.alias` files from `alias.d`, ensuring uniform access and configuration.

- **Manifest File (`MANIFEST.yml`):**
  Lists all registered aliases for easy reference and management.

## Logging and Debugging

- **Log Files:** Stored in `logs/alias.log` to track operations and debug alias configurations.
- **Debug Mode:** Enable detailed logging by setting `DEBUG=true` in relevant scripts.

## Contributing

Contributions are welcome! Fork the repository, make your changes, and submit a pull request with clear descriptions and test cases.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

  
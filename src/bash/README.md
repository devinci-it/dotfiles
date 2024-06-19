# `bash` Configuration

## `bash/aliasrc`

Configuration files and scripts related to Bash aliases.

## Structure

```
├── alias.d
│   ├── aka.alias
│   └── MANIFEST.yml
├── aliasrc
├── bin
│   ├── alias_conflict.sh
│   └── setup_alias.sh
├── stubs
│   ├── alias.stub
│   └── func-alias.stub
├── install.sh
```

### Description of Files and Directories:

- **`alias.d/`**: Directory for alias configurations.
  - `aka.alias`: Example alias definitions.
  - `MANIFEST.yml`: Manifest file listing alias configurations.

- **`aliasrc`**: Bash script for sourcing alias configurations.

- **`bin/`**: Directory for executable scripts.
  - `alias_conflict.sh`: Script for detecting alias conflicts.
  - `setup_alias.sh`: Script for setting up alias configurations.

- **`stubs/`**: Directory for stub files.
  - `alias.stub`: Stub file for aliases.
  - `func-alias.stub`: Stub file for function aliases.

### Installation

To install and configure the aliases, follow these steps:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/devinci-it/dotfiles.git
   cd dotfiles
   ```

2. **Run the Installation Script**:
   ```bash
   ./src/bash/install.sh
   ```

   This script does the following:
   - Sets up the necessary directories and permissions.
   - Copies files to the installation directory (`~/.local/opt/alias` by default).
   - Creates a symlink for `aliasrc` in your home directory as `.aliasrc`.
   - Provides instructions for sourcing `.aliasrc` in your shell configuration.

3. **Usage**

   - **Define Aliases**: Edit `alias.d/aka.alias` to define new aliases or modify existing ones.
   - **Manage Metadata**: Use `alias.d/MANIFEST.yml` to manage alias metadata such as script paths and hashes.
   - **Run Scripts**:
     - `setup_alias.sh`: Setup alias configurations.
     - `alias_conflict.sh`: Detect conflicting aliases.

4. **Bash Configuration**

   Ensure `.aliasrc` is sourced in your `bashrc` or `bash_profile`:
   ```bash
   # In bashrc or bash_profile
   if [ -f "$HOME/.aliasrc" ]; then
       source "$HOME/.aliasrc"
   fi
   ```

### Notes

- **Customization**: Modify the alias definitions and scripts to suit your preferences and system configuration.
- **Documentation**: Document any additional aliases or functions in the `alias.d/README.md` or respective files.

### Contributing

Feel free to fork this repository, make changes, and submit pull requests for improvements.

### License

This repository is licensed under the MIT License. See the [LICENSE](./LICENSE) file for more information.


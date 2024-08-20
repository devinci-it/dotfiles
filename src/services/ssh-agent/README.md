# ssh-agent wiki

---


## Installation

1. **Prepare SSH Agent Files:**
   - Copy the `../ssh-agent` file to `$HOME/.ssh-agent.d`.
     - **Note:** To keep paths consistent, you can use `$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../ssh-agent` for specifying file locations.

2. **Verify Dependencies:**
   - Check if `keyring`, `keychain`, and `ssh-agent` are installed. Verify the presence of `ssh-keygen` and `ssh-add`.
   - For Linux distributions, ensure the required tools can be installed from the appropriate repositories.
   - For non-Linux systems, check for package managers like `brew` or `pacman` and prompt for installation if needed.
   - If none of these tools are available, provide a warning or critical error indicating which applications or binaries are missing.

3. **Create Symlink for Configuration:**
   - Symlink the `sshaddrc` file from `$HOME/.ssh-agent.d` to `$HOME/.sshaddrc`.
     - **Note:** Use `$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../sshaddrc` for dynamic path specification.

4. **Update Startup Scripts:**
   - Print instructions on how to source the `sshaddrc` file in your `bashrc`, `zshrc`, or other startup scripts.

5. **Set Up SSH Keys:**
   - Instruct the user to symlink the private key files that need to be loaded automatically to `$HOME/.ssh-agent.d/ssh-keys`.
   - Follow a consistent naming convention for your keys, such as `nickname/hostname-modulus-key_type`. For instance, use the hostname as defined in your SSH configuration for each specific server or host.
     - **Note:** For better path consistency, use `$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../ssh-keys` for referring to key file locations.


## Caveats

- Note that filenames may differ or appear different from the source code once the files are integrated into the system. This can sometimes cause confusion if not carefully managed. Make sure any manual adjustments or integrations match the expected file names and paths.

- Additionally, the script uses `$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )` to handle file paths. This approach ensures that paths are resolved relative to the script's location, making the script more portable and reliable across different environments. This pattern helps maintain consistent behavior regardless of where the script is executed.

---


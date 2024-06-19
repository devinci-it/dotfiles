# `dotfiles` Repository

## Overview

This repository contains my personal dotfiles, organized into dedicated directories within the `src` directory. Dotfiles are configurations for various applications and tools, ensuring consistent settings across different systems and environments.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)


## Installation

To use these dotfiles on a new system, follow these steps:

1. Clone the repository to your home directory (or any preferred location):

   ```bash
   git clone https://www.github.com/devinci-it/dotfiles.git ~/dotfiles
   ```

2. Navigate to the dotfiles directory:

   ```bash
   cd ~/dotfiles
   ```

3. Symlink each configuration file from the `src` directory to its expected location:

   - Example for `.vimrc`:
     ```bash
     ln -s ~/dotfiles/src/vim/.vimrc ~/.vimrc
     ```

   - Repeat this process for each configuration file in their respective directories (`vim`, `bash`, `tmux`, `git`, etc.).

## Usage

Once installed, your dotfiles will automatically configure your applications and tools according to the settings defined in this repository. Use the applications as you normally would, and the configurations will be applied.

## Contributing

If you have suggestions, improvements, or new configurations to share, feel free to fork this repository, make your changes, and submit a pull request. Contributions are welcome!

## License

This project is licensed under the [MIT License](LICENSE), which means you can use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, subject to the conditions in the [LICENSE](LICENSE) file.


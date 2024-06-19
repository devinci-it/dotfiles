
# `.vimrc` Configuration

## Overview

This repository contains my personal `.vimrc` configuration file for Vim, tailored to maintain consistent settings and improve productivity across different systems.

## Table of Contents

- [Overview](#overview)
- [Key Mappings](#key-mappings)
  - [Insert Mode Commands](#insert-mode-commands)
  - [Normal/Execute Mode Commands](#normalexec-mode-commands)
  
## Key Mappings

### Insert Mode Commands

| Action                     | Shortcut             | Command                        | Mac Symbol        | Windows PC Key        |
|----------------------------|----------------------|--------------------------------|-------------------|-----------------------|
| Exit to Normal Mode        | `Option+e`           | `inoremap <A-e> <Esc>`         | ⌥e                | Alt+e                 |
| Beginning of Line          | `Home`               | `inoremap <Home> <C-o>0`       | Fn+← (or ⌘+←)     | Home                  |
| End of Line                | `End`                | `inoremap <End> <C-o>$`        | Fn+→ (or ⌘+→)     | End                   |

### Normal/Execute Mode Commands

| Action                     | Shortcut             | Command                        | Mac Symbol        | Windows PC Key        |
|----------------------------|----------------------|--------------------------------|-------------------|-----------------------|
| Exit to Normal Mode        | `Option+e`           | `noremap <A-e> <Esc>`          | ⌥e                | Alt+e                 |
| Exit to Normal Mode        | `Option+e`           | `cnoremap <A-e> <C-c>`         | ⌥e                | Alt+e                 |
| Enter Replace Mode         | `Option+r`           | `noremap <A-r> R`              | ⌥r                | Alt+r                 |
| Beginning of Line          | `Home`               | `noremap <Home> 0`             | Fn+← (or ⌘+←)     | Home                  |
| End of Line                | `End`                | `noremap <End> $`              | Fn+→ (or ⌘+→)     | End                   |
| Beginning of File          | `gg`                 | `gg`                           | ⌘↑                | Ctrl+Home             |
| End of File                | `G`                  | `G`                            | ⌘↓                | Ctrl+End              |
| First Non-Blank Character  | `^`                  | `^`                            | ^ (Shift+6)       | ^ (Shift+6)           |
| Top of Screen              | `H`                  | `H`                            | H                 | H                     |
| Middle of Screen           | `M`                  | `M`                            | M                 | M                     |
| Bottom of Screen           | `L`                  | `L`                            | L                 | L                     |

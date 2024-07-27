# `usermod` Command Reference

## Overview

The `usermod` command in Linux is used to modify user accounts. This document provides a comprehensive reference of common `usermod` flags, organized by their functionalities, with syntax and usage examples.

## Common Flags for `usermod`

| **Function**                   | **Command**                  | **Syntax**                                    | **Sample Usage**                           |
|--------------------------------|------------------------------|-----------------------------------------------|-------------------------------------------|
| **Change Username**            | `-l` or `--login`            | `usermod -l newusername oldusername`          | `sudo usermod -l newuser olduser`         |
| **Change Primary Group**       | `-g` or `--gid`              | `usermod -g newgid username`                  | `sudo usermod -g 1001 john`               |
| **Change Home Directory**      | `-d` or `--home`             | `usermod -d /new/home/dir username`           | `sudo usermod -d /home/newuser john`      |
| **Change Shell**               | `-s` or `--shell`            | `usermod -s /path/to/shell username`          | `sudo usermod -s /bin/zsh john`           |
| **Add to Supplementary Groups**| `-G` or `--groups`           | `usermod -G group1,group2 username`           | `sudo usermod -G sudo,admin john`         |
| **Append to Supplementary Groups**| `-a`                       | `usermod -a -G group1,group2 username`        | `sudo usermod -a -G developers john`      |
| **Change UID**                 | `-u` or `--uid`              | `usermod -u newuid username`                  | `sudo usermod -u 1050 john`               |
| **Change Password**            | `-p` or `--password`         | `usermod -p encrypted_password username`      | `sudo usermod -p $6$randomhash john`     |
| **Lock Account**               | `-L` or `--lock`             | `usermod -L username`                         | `sudo usermod -L john`                    |
| **Unlock Account**             | `-U` or `--unlock`           | `usermod -U username`                         | `sudo usermod -U john`                    |
| **Set Account Expiry**         | `-e` or `--expiredate`       | `usermod -e YYYY-MM-DD username`              | `sudo usermod -e 2024-12-31 john`        |
| **Set Inactive Days**          | `-f` or `--inactive`         | `usermod -f days username`                    | `sudo usermod -f 30 john`                 |

## Detailed Command Breakdown

### **Change Username**
- **Syntax**: `usermod -l newusername oldusername`
- **Example**: Change the username from `olduser` to `newuser`.
  ```bash
  sudo usermod -l newuser olduser
  ```

### **Change Primary Group**
- **Syntax**: `usermod -g newgid username`
- **Example**: Change the primary group of user `john` to group ID `1001`.
  ```bash
  sudo usermod -g 1001 john
  ```

### **Change Home Directory**
- **Syntax**: `usermod -d /new/home/dir username`
- **Example**: Change the home directory of user `john` to `/home/newuser`.
  ```bash
  sudo usermod -d /home/newuser john
  ```

### **Change Shell**
- **Syntax**: `usermod -s /path/to/shell username`
- **Example**: Change the login shell for user `john` to `/bin/zsh`.
  ```bash
  sudo usermod -s /bin/zsh john
  ```

### **Add to Supplementary Groups**
- **Syntax**: `usermod -G group1,group2 username`
- **Example**: Add user `john` to groups `sudo` and `admin`.
  ```bash
  sudo usermod -G sudo,admin john
  ```

### **Append to Supplementary Groups**
- **Syntax**: `usermod -a -G group1,group2 username`
- **Example**: Append user `john` to `developers` group without removing existing groups.
  ```bash
  sudo usermod -a -G developers john
  ```

### **Change UID**
- **Syntax**: `usermod -u newuid username`
- **Example**: Change the UID for user `john` to `1050`.
  ```bash
  sudo usermod -u 1050 john
  ```

### **Change Password**
- **Syntax**: `usermod -p encrypted_password username`
- **Example**: Set a new encrypted password for user `john`. Password must be pre-encrypted.
  ```bash
  sudo usermod -p $6$randomhash john
  ```

### **Lock Account**
- **Syntax**: `usermod -L username`
- **Example**: Lock the account for user `john`.
  ```bash
  sudo usermod -L john
  ```

### **Unlock Account**
- **Syntax**: `usermod -U username`
- **Example**: Unlock the account for user `john`.
  ```bash
  sudo usermod -U john
  ```

### **Set Account Expiry**
- **Syntax**: `usermod -e YYYY-MM-DD username`
- **Example**: Set the account expiry date for user `john` to December 31, 2024.
  ```bash
  sudo usermod -e 2024-12-31 john
  ```

### **Set Inactive Days**
- **Syntax**: `usermod -f days username`
- **Example**: Set the account to be disabled 30 days after the password expires.
  ```bash
  sudo usermod -f 30 john
  ```



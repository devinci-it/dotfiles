#!/bin/bash

###########################################################
# Script: install_python3.12.sh
# Description: Script to install Python 3.12 with necessary dependencies,
#              configure with optimizations, set up PATH and PYTHONPATH.
# Author: Your Name
# Date: July 10, 2024
###########################################################

# Make the script verbose
set -x

###########################################################
# Step 1: Install prerequisites
###########################################################

echo "Step 1: Installing prerequisites..."
sudo apt update
sudo apt install -y build-essential zlib1g-dev libncurses5-dev \
    libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget

###########################################################
# Step 2: Download and extract Python source code
###########################################################

echo "Step 2: Downloading Python 3.12 source code..."
wget https://www.python.org/ftp/python/3.12.0/Python-3.12.0.tgz

echo "Extracting Python 3.12 source code..."
tar -xzvf Python-3.12.0.tgz

###########################################################
# Step 3: Configure Python with optimizations
###########################################################

echo "Step 3: Configuring Python 3.12 with optimizations..."
cd Python-3.12.0
./configure --prefix=$HOME/.local/pyenv/Python-3.12.0 --enable-optimizations

###########################################################
# Step 4: Compile and install Python
###########################################################

echo "Step 4: Compiling and installing Python 3.12..."
make
make install

###########################################################
# Step 5: Update PATH and PYTHONPATH
###########################################################

echo "Step 5: Updating PATH and PYTHONPATH..."

# Update PATH to include the new Python installation
echo 'export PATH="$HOME/.local/pyenv/Python-3.12.0/bin:$PATH"' >> ~/.bashrc

# Set PYTHONPATH to include the site-packages directory of Python 3.12
echo 'export PYTHONPATH="$HOME/.local/pyenv/Python-3.12.0/lib/python3.12/site-packages:$PYTHONPATH"' >> ~/.bashrc

# Source .bashrc to apply changes immediately
source ~/.bashrc

###########################################################
# Step 6: Verify Python installation
###########################################################

echo "Step 6: Verifying Python installation..."
python --version
which python

###########################################################
# Installation complete
###########################################################

echo "Python 3.12 installation completed successfully."


###########################################################
# Step 8: Create aliases for python and python3
###########################################################

echo "Creating aliases for python and python3 commands..."

# Set alias for python command
echo 'alias python="python3.12"' >> ~/.bashrc

# Set alias for python3 command (if different from python)
echo 'alias python3="python3.12"' >> ~/.bashrc

# Source .bashrc to apply changes immediately
source ~/.bashrc

###########################################################
# Aliases creation complete
###########################################################

echo "Aliases for python and python3 commands created successfully."

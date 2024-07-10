# Python 3.12 Installation and Environment Setup

This script automates the installation and setup of Python 3.12 along with configuring the environment using Pipenv for managing Python dependencies.

## Steps Overview

### Step 1: Install Prerequisites

Install necessary packages required for compiling Python from source.

### Step 2: Download and Extract Python Source Code

Download Python 3.12 source code from the official Python website and extract it.

### Step 3: Configure Python with Optimizations

Configure Python 3.12 with optimizations for better performance.

### Step 4: Compile and Install Python

Compile Python 3.12 source code and install it on your system.

### Step 5: Update PATH and PYTHONPATH

Update system environment variables (`PATH` and `PYTHONPATH`) to include the new Python installation.

### Step 6: Verify Python Installation

Verify that Python 3.12 has been successfully installed on your system.

### Step 8: Create Aliases for Python and Python3 Commands

Create aliases for `python` and `python3.12` commands for easier usage.

## Pipfile Configuration

The provided `Pipfile` manages Python dependencies and scripts using Pipenv:

```toml
# Pipfile for managing Python dependencies and scripts using Pipenv

# Source configuration for Python packages
[[source]]
name = "pypi"
url = "https://pypi.org/simple"
verify_ssl = true

# Production dependencies (specify specific package versions here if needed)
[packages]
# package_name = "*"

# Development dependencies
# These packages are used for development purposes to enhance testing, code quality, and automation.
[dev-packages]
# HTTP library for making requests
requests = "*"
# Library for loading environment variables from .env files
python-dotenv = "*"
# Testing framework
pytest = "*"
# PEP 8 linting tool
flake8 = "*"
# Automatic code formatting tool
autopep8 = "*"

# Custom scripts for automation
[scripts]
# Run tests with pytest
test = "pytest"
# Run tests with coverage
coverage = "pytest --cov=your_module"
# Check code against PEP 8 standards
lint = "flake8 ."
# Auto-format code with autopep8
format = "autopep8 --recursive --in-place ."
# Update packages in Pipfile
update-packages = "pipenv update"
# Build your project
build = "python setup.py build"
# Clean artifacts
clean-artifacts = "python setup.py clean --all"

# Pipenv specific configurations
[pipenv]
# Custom shell prompt
fancy_prompt = "{project_name} {python_version} ({virtualenv_name})"
# Network timeout in seconds
timeout = 600

# Project metadata
[metadata]
# Repository URL
repository = "https://github.com/devinci-it/{project_name}"
# Authors
authors = ["devinci-it"]
```



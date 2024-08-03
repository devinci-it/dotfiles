#!/bin/bash

# Description:
# This script renames all files with a specified source extension to a target extension
# within the specified directory and its subdirectories.
# It takes three arguments:
#   - The path to the starting directory where the renaming should begin.
#   - The source file extension to be replaced.
#   - The target file extension to replace with.
# Usage: ./extmod <starting-directory> <source-extension> <target-extension>

# Function to display usage information
usage() {
    echo "Usage: $0 <starting-directory> <source-extension> <target-extension>"
    echo
    echo "Description:"
    echo "  Renames all files with the source extension to the target extension"
    echo "  in the specified directory and its subdirectories."
    echo
    echo "Arguments:"
    echo "  <starting-directory>   The path to the starting directory where renaming should begin."
    echo "  <source-extension>     The file extension to be replaced (e.g., 'xhtml')."
    echo "  <target-extension>     The file extension to replace with (e.g., 'html')."
    exit 1
}

# Check if the correct number of arguments is provided
if [ $# -ne 3 ]; then
  usage
fi

START_DIR="$1"
SOURCE_EXT="$2"
TARGET_EXT="$3"

# Check if the provided argument is a directory
if [ ! -d "$START_DIR" ]; then
  echo "Error: '$START_DIR' is not a valid directory."
  exit 1
fi

# Rename files with the specified source extension to the target extension
find "$START_DIR" -type f -name "*.$SOURCE_EXT" -exec rename "s/\.$SOURCE_EXT$/$TARGET_EXT/" {} +

# Confirm completion
echo "Renaming complete. All *.$SOURCE_EXT files have been renamed to *.$TARGET_EXT."


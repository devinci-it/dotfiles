#!/bin/bash

# Path to your MANIFEST file
MANIFEST_FILE="MANIFEST"

# Generate the updated list of files
git ls-tree -r --name-only HEAD > $MANIFEST_FILE.tmp

# Replace MANIFEST file with the updated list
mv $MANIFEST_FILE.tmp $MANIFEST_FILE


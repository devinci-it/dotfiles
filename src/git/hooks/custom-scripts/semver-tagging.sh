#!/bin/bash

################################################################################
# Script: update_version.sh
#
# Description:
#   This script fetches the latest Git tag, increments the major, minor, or patch
#   version component, or creates a custom version tag. It optionally pushes the
#   created tag to the remote origin.
#
# Usage:
#   ./update_version.sh [--remote] <major|minor|patch|--custom VERSION>
#
# Options:
#   --remote: Push the created tag to the remote origin.
#   major|minor|patch: Increment the respective version component.
#   --custom VERSION: Create a custom version tag.
#
# Example Usage:
#   Increment the major version and push to remote:
#     ./update_version.sh --remote major
#
#   Increment the minor version and push to remote:
#     ./update_version.sh --remote minor
#
#   Increment the patch version and push to remote:
#     ./update_version.sh --remote patch
#
#   Create a custom version v1.2.3:
#     ./update_version.sh --custom 1.2.3
#
# Notes:
#   - The script requires Git to be installed and initialized in the repository.
#   - When using --custom, VERSION should be in the format x.y.z.
################################################################################

# Function to display usage
usage() {
    echo "Usage: $0 [--remote] <major|minor|patch|--custom VERSION>"
    echo "  --remote: Push the created tag to the remote origin."
    echo "  major|minor|patch: Increment the respective version component."
    echo "  --custom VERSION: Create a custom version tag."
    exit 1
}

# Fetch the latest tag
latest_tag=$(git tag --list | sort -V | tail -n 1)

# Parse the latest tag into components
major=$(echo $latest_tag | cut -d '.' -f 1 | sed 's/v//')
minor=$(echo $latest_tag | cut -d '.' -f 2)
patch=$(echo $latest_tag | cut -d '.' -f 3)

echo "Latest version: $latest_tag"
echo "Major: $major"
echo "Minor: $minor"
echo "Patch: $patch"

# Check if at least one argument is provided
if [ $# -lt 1 ]; then
    echo "Error: Missing arguments."
    usage
fi

# Parse the arguments
case "$1" in
    --remote)
        shift
        action=$1
        ;;
    --custom)
        shift
        custom_version=$1
        ;;
    major)
        action="major"
        ;;
    minor)
        action="minor"
        ;;
    patch)
        action="patch"
        ;;
    *)
        echo "Error: Invalid arguments."
        usage
        ;;
esac

# Perform the action based on the arguments
if [ "$action" = "major" ]; then
    major=$((major + 1))
    minor=0
    patch=0
    new_version="v$major.$minor.$patch"
elif [ "$action" = "minor" ]; then
    minor=$((minor + 1))
    patch=0
    new_version="v$major.$minor.$patch"
elif [ "$action" = "patch" ]; then
    patch=$((patch + 1))
    new_version="v$major.$minor.$patch"
elif [ "$custom_version" ]; then
    new_version="v$custom_version"
else
    echo "Error: Invalid arguments."
    usage
fi

# Prompt for tag message/comment
echo "Enter tag message/comment (Press Ctrl+X to finish):"
tempfile=$(mktemp)
nano "$tempfile"
tag_message=$(cat "$tempfile")
rm "$tempfile"

# Create the new tag with message/comment
git tag -a "$new_version" -m "$tag_message"
echo "Created new tag: $new_version with message: $tag_message"

# Push the new tag to the remote repository if --remote is specified
if [ "$1" = "--remote" ]; then
    git push origin "$new_version"
    echo "Pushed tag $new_version to origin."
fi

#!/bin/bash

# Define the directory for path files and manifest
PATH_DIR="$HOME/.path.d"
MANIFEST_FILE="$PATH_DIR/MANIFEST.yml"

# Define the log file paths
LOG_DIR="$(dirname "${BASH_SOURCE[0]}")/../logs"
LOG_FILE="$LOG_DIR/path_manager.log"
ERROR_LOG="$LOG_DIR/error.log"

# Logger function to log messages
log_message() {
  local message="$1"
  local log_file="$2"
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $message" | tee -a "$log_file"
}

# Check if PATH_DEBUG is set to true
if [ "$PATH_DEBUG" = true ]; then
  # Create a test directory in the script's directory and use it as HOME
  TEST_HOME="$(dirname "${BASH_SOURCE[0]}")/../test_path"
  PATH_DIR="$TEST_HOME/.path.d"
  MANIFEST_FILE="$PATH_DIR/MANIFEST.yml"
  log_message "PATH_DEBUG is true. Using $PATH_DIR as path directory." "$LOG_FILE"

  # Create the test home directory
  mkdir -p "$TEST_HOME"
  export HOME="$TEST_HOME"
  log_message "Using $HOME as HOME directory in debug mode." "$LOG_FILE"
fi

# Create the directory if it doesn't exist
if [ ! -d "$PATH_DIR" ]; then
  mkdir -p "$PATH_DIR"
  log_message "Created directory $PATH_DIR" "$LOG_FILE"
fi

# Function to update the MANIFEST.yml file
# Function to update the MANIFEST.yml file
update_manifest() {
  log_message "Updating MANIFEST.yml..." "$LOG_FILE"
  echo "-----------------------------------" > "$MANIFEST_FILE"
  find "$PATH_DIR" -name "*.path" -type f | sort | while read -r file; do
    abs_path=$(realpath "$file")
    if [ -f "$abs_path" ]; then
      log_message "Processing file: $abs_path" "$LOG_FILE"
      hash=$(sha256sum "$abs_path" | awk -F '= ' '{ print $2 }')
      if [ -n "$hash" ]; then
        echo "$abs_path: $hash" >> "$MANIFEST_FILE"
        log_message "File added to MANIFEST.yml: $abs_path" "$LOG_FILE"
      else
        log_message "Failed to calculate hash for file: $abs_path" "$ERROR_LOG"
      fi
    else
      log_message "File not found or not a regular file: $abs_path" "$ERROR_LOG"
    fi
  done
  log_message "MANIFEST.yml updated." "$LOG_FILE"
}


generate_manifest_entry() {
  local action="$1"
  local file_path="$2"
  local abs_path=$(realpath "$file_path")
  local filename=$(basename "$file_path")
  local priority=$(echo "$filename" | cut -d'_' -f1)
  local hash=$(openssl sha256 "$abs_path" | awk '{ print $2 }')

  # Check if the file exists and is a regular file
  if [ ! -f "$abs_path" ]; then
    echo "File not found or not a regular file: $abs_path" >> "$ERROR_LOG"
    return
  fi

  case "$action" in
    add)
      # Check if the entry already exists in MANIFEST_FILE
      if grep -q "^filename: $filename$" "$MANIFEST_FILE"; then
        echo "Entry for $filename already exists in MANIFEST_FILE." >> "$ERROR_LOG"
        return
      fi

      # Add new entry to MANIFEST_FILE
      echo "filename: $filename" >> "$MANIFEST_FILE"
      echo "priority: $priority" >> "$MANIFEST_FILE"
      echo "abs_path: $abs_path" >> "$MANIFEST_FILE"
      echo "hash: $hash" >> "$MANIFEST_FILE"
      echo "Entry added to MANIFEST_FILE: $filename"
      ;;

    delete)
      # Check if the entry exists in MANIFEST_FILE
      if grep -q "^filename: $filename$" "$MANIFEST_FILE"; then
        # Remove entry from MANIFEST_FILE
        sed -i "/^filename: $filename$/,/^hash:/d" "$MANIFEST_FILE"
        echo "Entry deleted from MANIFEST_FILE: $filename"
      else
        echo "Entry for $filename not found in MANIFEST_FILE." >> "$ERROR_LOG"
      fi
      ;;
    
    *)
      echo "Unsupported action: $action" >> "$ERROR_LOG"
      ;;
  esac
}

# Function to add a path file
add_path() {
  local priority="$1"
  local name="$2"
  local description="$3"
  local path="$4"
  local active="${5:-true}"
  
  local filename="$priority"_"$name".path

  cat > "$PATH_DIR/$filename" <<EOL
name: $name
description: $description
path: $path
active: $active
EOL

  log_message "Path file $filename added." "$LOG_FILE"
  generate_manifest_entry add "$PATH_DIR/$filename"

}

# Function to remove a path file
remove_path() {
  local name="$1"
  local file_to_remove
  file_to_remove=$(ls "$PATH_DIR" | grep -E "^[0-9]+_$name\.path$")

  if [ -n "$file_to_remove" ]; then
    rm "$PATH_DIR/$file_to_remove"
    log_message "Path file $file_to_remove removed." "$LOG_FILE"
    update_manifest
  else
    log_message "Path file with name $name not found." "$LOG_FILE"
  fi
}

# Function to list all path files
list_paths() {
  log_message "Listing all path files:" "$LOG_FILE"
  for file in "$PATH_DIR"/*.path; do
    [ -e "$file" ] || continue
    echo "$file"
  done
}

# Function to activate/deactivate a path file
set_path_state() {
  local name="$1"
  local state="$2"
  local file_to_modify
  file_to_modify=$(ls "$PATH_DIR" | grep -E "^[0-9]+_$name\.path$")

  if [ -n "$file_to_modify" ]; then
    sed -i "s/^active: .*/active: $state/" "$PATH_DIR/$file_to_modify"
    log_message "Path file $file_to_modify set to $state." "$LOG_FILE"
    update_manifest
  else
    log_message "Path file with name $name not found." "$LOG_FILE"
  fi
}

# Function to display help message
show_help() {
  echo "Usage: $0 {add|remove|list|activate|deactivate} ..."
  echo
  echo "Commands:"
  echo "  add <priority> <name> <description> <path> [active]   Add a new path file"
  echo "  remove <name>                                        Remove a path file"
  echo "  list                                                 List all path files"
  echo "  activate <name>                                      Activate a path file"
  echo "  deactivate <name>                                    Deactivate a path file"
}

# Main script logic
main() {
  # Create the log directory
  mkdir -p "$LOG_DIR"

  case "$1" in
    add)
      add_path "$2" "$3" "$4" "$5" "$6"
      ;;
    remove)
      remove_path "$2"
      ;;
    list)
      list_paths
      ;;
    activate)
      set_path_state "$2" "true"
      ;;
    deactivate)
      set_path_state "$2" "false"
      ;;
    *)
      show_help
      ;;
  esac
}

# Run the main function
main "$@"

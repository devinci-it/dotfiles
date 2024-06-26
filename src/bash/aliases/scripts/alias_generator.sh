#!/bin/bash
set -e

# Define variables
STUBS_DIR="$(dirname "${BASH_SOURCE[0]}")/../stubs"
ALIAS_DIR="$(dirname "${BASH_SOURCE[0]}")/../alias.d"
STUB_FILE_FUNCTION="$STUBS_DIR/func-alias.stub"

# Function to prompt the user for alias details
prompt_alias_info() {
    read -p "Enter alias name: " alias_name
    read -p "Enter function name (descriptive): " function_name
    read -p "Enter alias description: " alias_description
    read -p "Enter alias command: " alias_command
    read -p "Enter alias arguments (space-separated): " arguments

    # Split the arguments and prompt for descriptions
    args_descriptions=""
    for arg in $arguments; do
        read -p "Enter description for argument '$arg': " arg_description
        args_descriptions+="$arg: $arg_description\n"
    done

    read -p "Enter arguments example: " arguments_example

    ALIAS_FILE="${alias_name}.alias"
}

# Function to generate the header comment section
generate_header_comment() {
    cat <<EOL
#!/bin/bash

: <<'ENDCOMMENT'
###########################################################
Alias Script: $alias_name
Description: $alias_description
Author: devinci-it
Date: $(date +"%Y-%m-%d")
Version: 1.0
EOL
}

# Function to generate the usage section
generate_usage_section() {
    cat <<EOL
Usage:
  $alias_name $arguments
EOL
}

# Function to generate the arguments section
generate_arguments_section() {
    cat <<EOL
Arguments:
$args_descriptions
EOL
}

# Function to generate the example section
generate_example_section() {
    cat <<EOL
Example:
  $alias_name $arguments_example
EOL
}

# Function to generate the function definition section
generate_function_definition() {
    cat <<EOL
###########################################################

${function_name}() {

    # Process all arguments to prevent injection vulnerabilities
    local processed_args=()
    for arg in "\$@"; do
        processed_args+=("\$(printf "%q" "\$arg")")
    done

    # Execute the command with the processed arguments
    $alias_command "\${processed_args[@]}"
}

alias $alias_name='${function_name}'

# End of script
EOL
}

# Function to write the alias file
write_alias_file() {
    local alias_file="$ALIAS_DIR/$ALIAS_FILE"

    # Combine all sections into one script content
    {
        generate_header_comment
        generate_usage_section
        generate_arguments_section
        generate_example_section
        generate_function_definition
    } > "$alias_file"

    # Output the alias file name
    echo "$alias_file"
}

# Main script
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    prompt_alias_info
    ALIAS_FILE=$(write_alias_file)
    echo "$ALIAS_FILE"
fi

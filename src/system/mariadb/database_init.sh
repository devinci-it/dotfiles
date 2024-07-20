#!/bin/bash

# Function to display script usage and options
usage() {
    cat <<EOF
Usage: $0 [-f <output_sql_script>] [-x] [-t]
Options:
  -f <output_sql_script>: Specify the output SQL script file (default: init_db_and_user.sql)
  -x: Execute the generated SQL script immediately
  -t: Perform connectivity and basic operations test (create table, insert, drop table)

This script interacts with MariaDB to initialize a database and user.
EOF
    exit 1
}

# Function to prompt user for database credentials
prompt_credentials() {
    read -p "Enter database name: " DB_NAME
    read -p "Enter username: " DB_USER
    read -s -p "Enter password: " DB_PASSWORD
    echo # Move to a new line after password input
}

# Function to generate SQL script for database initialization
generate_sql_script() {
    local SQL_SCRIPT="$1"

    cat > "$SQL_SCRIPT" <<EOF
-- SQL script to initialize database and user

-- Create database if not exists
CREATE DATABASE IF NOT EXISTS \`$DB_NAME\`;
USE \`$DB_NAME\`;

-- Create user and grant privileges
CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON \`$DB_NAME\`.* TO '$DB_USER'@'localhost';
FLUSH PRIVILEGES;
EOF

    echo "SQL script '$SQL_SCRIPT' has been generated:"
    echo "---------------------------------------------"
    cat "$SQL_SCRIPT"
    echo "---------------------------------------------"
}

# Function to execute SQL script
execute_sql_script() {
    local SQL_SCRIPT="$1"

    echo "Executing SQL script..."
    mysql -u "$DB_USER" -p"$DB_PASSWORD" < "$SQL_SCRIPT"
    echo "Execution complete."
}

# Function to perform connectivity and basic operations test
perform_test() {
    echo "Performing connectivity and basic operations test..."

    echo "Testing database connectivity..."
    mysql -u "$DB_USER" -p"$DB_PASSWORD" -e "SELECT 'Connected successfully to $DB_NAME';"

    echo "Creating test table..."
    mysql -u "$DB_USER" -p"$DB_PASSWORD" -e "USE $DB_NAME; CREATE TABLE IF NOT EXISTS test_table (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(50));"

    echo "Inserting test data..."
    mysql -u "$DB_USER" -p"$DB_PASSWORD" -e "USE $DB_NAME; INSERT INTO test_table (name) VALUES ('Test data 1'), ('Test data 2');"

    echo "Displaying test data..."
    mysql -u "$DB_USER" -p"$DB_PASSWORD" -e "USE $DB_NAME; SELECT * FROM test_table;"

    echo "Dropping test table..."
    mysql -u "$DB_USER" -p"$DB_PASSWORD" -e "USE $DB_NAME; DROP TABLE IF EXISTS test_table;"

    echo "Test complete."
}

# Main function that orchestrates the script flow
main() {
    local SQL_SCRIPT="init_db_and_user.sql"
    local EXECUTE_SCRIPT=false
    local PERFORM_TEST=false

    # Parse command line options using getopts
    while getopts "f:xt" opt; do
        case $opt in
            f)
                SQL_SCRIPT="$OPTARG"
                ;;
            x)
                EXECUTE_SCRIPT=true
                ;;
            t)
                PERFORM_TEST=true
                ;;
            \?)
                usage
                ;;
        esac
    done

    shift $((OPTIND - 1))

    # Prompt user for database credentials
    prompt_credentials

    # Generate SQL script
    generate_sql_script "$SQL_SCRIPT"

    # Execute SQL script if -x flag is set
    if [ "$EXECUTE_SCRIPT" = true ]; then
        execute_sql_script "$SQL_SCRIPT"
    fi

    # Perform test if -t flag is set
    if [ "$PERFORM_TEST" = true ]; then
        perform_test
    fi
}

# Call the main function with arguments passed to the script
main "$@"

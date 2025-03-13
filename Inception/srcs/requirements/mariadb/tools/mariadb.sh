#!/bin/sh

# Install necessary packages
apk add --no-cache mariadb mariadb-client

# Set up environment variables
export db1_name="my_database"
export db1_user="my_user"
export db1_pwd="my_password"
export MYSQL_PWD="rootpassword"

# Wait for the MariaDB service to start (adjust as necessary)
sleep 5

# Initialize the database if it's not already initialized
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB..."
    mysqld --initialize-insecure --datadir=/var/lib/mysql
fi

# Create database and user, set permissions
echo "Running SQL commands..."
mysql -u root << EOF
CREATE DATABASE IF NOT EXISTS $db1_name ;
CREATE USER IF NOT EXISTS '$db1_user'@'%' IDENTIFIED BY '$db1_pwd' ;
GRANT ALL PRIVILEGES ON $db1_name.* TO '$db1_user'@'%' ;
ALTER USER 'root'@'localhost' IDENTIFIED BY '12345' ;
FLUSH PRIVILEGES;
EOF

# Start MariaDB (no need for openrc in Docker)
echo "Starting MariaDB..."
exec mysqld

#!/bin/sh

# Install required packages
apk add --no-cache mariadb mariadb-client openrc su-exec

# Create necessary directories for MariaDB
mkdir -p /var/lib/mysql

# Initialize MariaDB database as the mysql user
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB database..."
    su-exec mysql /usr/bin/mysqld --initialize-insecure --datadir=/var/lib/mysql
else
    echo "MariaDB already initialized."
fi

# Start the MariaDB service
echo "Starting MariaDB service..."
rc-service mariadb start

# Wait for MariaDB to fully start
sleep 5
echo "MariaDB started."

# Set up the database and user
echo "Setting up database and user..."
mysql << EOF
CREATE DATABASE IF NOT EXISTS \${db1_name};
CREATE USER IF NOT EXISTS '\${db1_user}'@'%' IDENTIFIED BY '\${db1_pwd}';
GRANT ALL PRIVILEGES ON \${db1_name}.* TO '\${db1_user}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '12345';
FLUSH PRIVILEGES;
EOF

# Enable MariaDB to start on boot
rc-update add mariadb default

# Restart the service to apply any changes
rc-service mariadb restart
echo "MariaDB restarted."

# Keep the container running (to keep the process alive)
tail -f /dev/null

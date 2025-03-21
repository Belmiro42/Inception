#!/bin/sh

#┌─────────────────────────────────────────────────────────────────────────┐
#│                       DOWNLOAD RELEVANT SOFTWARE                        │	
#├─────────────────────────────────────────────────────────────────────────┤
#│ The standard folder for web files when using nginx                      │
#└─────────────────────────────────────────────────────────────────────────┘

# Create a my.cnf file for mariadb to read from (empty)

touch etc/my.cnf

apk add --no-cache mariadb mariadb-client 

#┌─────────────────────────────────────────────────────────────────────────┐
#│                           MARIADB CONFIGURATION                         │	
#├─────────────────────────────────────────────────────────────────────────┤
#│ The standard folder for web files when using nginx                      │
#└─────────────────────────────────────────────────────────────────────────┘

# Create directories for mariaDB and give mysql ownership of them
mkdir -p /var/lib/mysql /run/mysqld && chown -R mysql:mysql /var/lib/mysql /run/mysqld

# Initialises database systems under user mysql and stores files in the datadir folder

mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Run mariaDB in the background and capture its pid

mysqld --user=mysql --datadir=/var/lib/mysql --skip-networking & pid="$!"

# Wait for MariaDB to start

while ! mysqladmin ping --silent; do
    sleep 1
done

# Create database and user

mysql << EOF
CREATE DATABASE IF NOT EXISTS $db_name ;
CREATE USER IF NOT EXISTS '$db_user'@'%' IDENTIFIED BY '$db_pwd' ;
GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user'@'%' ;
FLUSH PRIVILEGES;
EOF

# Need to restart the process so shutdown and wait for process to end

mysqladmin shutdown ; wait "$pid"

# Run MariaDB again

mysqld --user=mysql --datadir=/var/lib/mysql

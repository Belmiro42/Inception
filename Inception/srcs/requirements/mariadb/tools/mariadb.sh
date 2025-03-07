#! bin/sh

# Install MariaDB
apt-get update -y
apt-get install mariadb-server -y

# Start the MariaDB Service
service mysql start 


mysql -u root -p << EOF
CREATE DATABASE IF NOT EXISTS $db1_name ;
CREATE USER IF NOT EXISTS '$db1_user'@'%' IDENTIFIED BY '$db1_pwd' ;
GRANT ALL PRIVILEGES ON $db1_name.* TO '$db1_user'@'%' ;
ALTER USER 'root'@'localhost' IDENTIFIED BY '12345' ;
FLUSH PRIVILEGES;
EOF

sudo systemctl restart mariadb

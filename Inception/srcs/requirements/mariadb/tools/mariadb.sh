#!/bin/sh

apk add --no-cache mariadb mariadb-client openrc

sleep 5;

echo "mysql -u root -p << EOF"

mysql -u root -p << EOF
CREATE DATABASE IF NOT EXISTS $db1_name ;
CREATE USER IF NOT EXISTS '$db1_user'@'%' IDENTIFIED BY '$db1_pwd' ;
GRANT ALL PRIVILEGES ON $db1_name.* TO '$db1_user'@'%' ;
ALTER USER 'root'@'localhost' IDENTIFIED BY '12345' ;
FLUSH PRIVILEGES;
EOF


echo "rc-update add mariadb default"
rc-update add mariadb default
mysqld --initialize-insecure --datadir=/var/lib/mysql
rc-service mariadb restart

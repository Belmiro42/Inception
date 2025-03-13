#!/bin/sh


apk add  mariadb mariadb-client openrc
echo "apk add  mariadb mariadb-client openrc"

rc-service mariadb start
echo "rc-service mariadb start"

sleep 5;
echo "sleep 5;"


echo ""

mysql -u  << EOF
CREATE DATABASE IF NOT EXISTS $db1_name ;
CREATE USER IF NOT EXISTS '$db1_user'@'%' IDENTIFIED BY '$db1_pwd' ;
GRANT ALL PRIVILEGES ON $db1_name.* TO '$db1_user'@'%' ;
ALTER USER 'root'@'localhost' IDENTIFIED BY '12345' ;
FLUSH PRIVILEGES;
EOF

rc-update add mariadb default
echo "rc-update add mariadb default"

mysqld --initialize-insecure --datadir=/var/lib/mysql
echo "mysqld --initialize-insecure --datadir=/var/lib/mysql"

rc-service mariadb restart
echo "rc-service mariadb restart"

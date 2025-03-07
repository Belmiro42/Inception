#!/bin/sh

apk add mariadb mariadb-client

rc-service mariadb start

mysql_secure_installation

rc-update add mariadb default

rc-service mariadb start

sleep 5;
mysql -u root -p << EOF
CREATE DATABASE IF NOT EXISTS $db1_name ;
CREATE USER IF NOT EXISTS '$db1_user'@'%' IDENTIFIED BY '$db1_pwd' ;
GRANT ALL PRIVILEGES ON $db1_name.* TO '$db1_user'@'%' ;
ALTER USER 'root'@'localhost' IDENTIFIED BY '12345' ;
FLUSH PRIVILEGES;
EOF

rc-service mariadb restart

#!/bin/sh


echo "apk add  mariadb mariadb-client openrc"
apk add --no-cache mariadb mariadb-client openrc su-exec



echo "sleep 5;"
sleep 5;


echo "MYSQL"

echo "rc-update add mariadb default"
rc-update add mariadb default

mysql << EOF
CREATE DATABASE IF NOT EXISTS $db1_name ;
CREATE USER IF NOT EXISTS '$db1_user'@'%' IDENTIFIED BY '$db1_pwd' ;
GRANT ALL PRIVILEGES ON $db1_name.* TO '$db1_user'@'%' ;
ALTER USER 'root'@'localhost' IDENTIFIED BY '12345' ;
FLUSH PRIVILEGES;
EOF

echo "rc-service mariadb restart"
rc-service mariadb restart

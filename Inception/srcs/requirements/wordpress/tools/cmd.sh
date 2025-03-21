#! bin/sh

#┌─────────────────────────────────────────────────────────────────────────┐
#│                       DOWNLOAD RELEVANT SOFTWARE                        │	
#├─────────────────────────────────────────────────────────────────────────┤
#│ The standard folder for web files when using nginx                      │
#└─────────────────────────────────────────────────────────────────────────┘

apk update && apk add php-fpm curl php php-common php-fpm php-mysqli php-json php-session php-zlib php-gd php-mbstring  php-openssl  php-curl php-dom wget  tar mariadb-client php-phar php-simplexml php-xmlwriter php-tokenizer  php-zip

# Wait until MariaDB is running

while ! mysqladmin ping -h"$db_host" -u"$db_user" -p"$db_pwd" --silent; do 
  sleep 1
done

#┌─────────────────────────────────────────────────────────────────────────┐
#│                          ENABLE WORDPRESS CLI                           │	
#├─────────────────────────────────────────────────────────────────────────┤
#│ Enables us to use the command line to interact with wordpress           │
#└─────────────────────────────────────────────────────────────────────────┘

# Download wordpress CLI fromt the official repo

curl    -L https://github.com/wp-cli/wp-cli/releases/download/v2.7.1/wp-cli-2.7.1.phar -o /usr/local/bin/wp 

# Execute permissions for the wordpress cli

chmod +x /usr/local/bin/wp

#┌─────────────────────────────────────────────────────────────────────────┐
#│                    WORDPRESS CONFIGURATION / INSTALL                    │	
#├─────────────────────────────────────────────────────────────────────────┤
#│ Enables us to use the command line to interact with wordpress           │
#└─────────────────────────────────────────────────────────────────────────┘

# Download wordpress core files

wp  core download --allow-root --path="$WORDPRESS_PATH"

# Create the configuration file and modify values to allow it to connect to mariaDB

wp  config create --path="$WORDPRESS_PATH" --dbname="$db_name" --dbuser="$db_user" --dbpass="$db_pwd" --dbhost="$db_host" --allow-root

# Installs wordpress and defines admin user

wp core install         --path="$WORDPRESS_PATH" --url="https://${DOMAIN_NAME}" --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

# Creates new Wordpress User

wp user create "$WP_USR" "$WP_EMAIL" --role="subscriber" --user_pass="$WP_ADMIN_PWD" --path="$WORDPRESS_PATH" --allow-root

# Allows fpm to listen on all interfaces 0.0.0.0 instead of 127.0.0.1 as containers do not have the same host machine

sed -i "s/127.0.0.1/0.0.0.0/" /etc/php83/php-fpm.d/www.conf

# Run FPM in the foreground

php-fpm83 -F --nodaemonize
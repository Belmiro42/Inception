#! bin/sh

#┌─────────────────────────────────────────────────────────────────────────┐
#│                       DOWNLOAD RELEVANT SOFTWARE                        │	
#├─────────────────────────────────────────────────────────────────────────┤
#│ The standard folder for web files when using nginx                      │
#└─────────────────────────────────────────────────────────────────────────┘

apt update              -y 
apt install             php-fpm php-mysql -y
apt install             curl -y

#┌─────────────────────────────────────────────────────────────────────────┐
#│                          WEB FILES FOLDER CREATION                      │	
#├─────────────────────────────────────────────────────────────────────────┤
#│ The standard folder for web files when using nginx. Create and clean.   │
#└─────────────────────────────────────────────────────────────────────────┘

mkdir   /var/www/
mkdir   /var/www/html
cd      /var/www/html
rm      *               -rf

#┌─────────────────────────────────────────────────────────────────────────┐
#│                          ENABLE WORDPRESS CLI                           │	
#├─────────────────────────────────────────────────────────────────────────┤
#│ Enables us to use the command line to interact with wordpress           │
#└─────────────────────────────────────────────────────────────────────────┘

# This command downloads wordpress CLI fromt the official repo

curl    -O                                  https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
cmhod   +x                                  wp-cli.phar
mv      wp-cli.phar                         /usr/local/bin/wp
wp      core download                       --allow-root
mv      /var/www/html/wp-config-sample.php  /var/www/html/wp-config.php
mv      /wp-config.php                      /var/www/html/wp-config.php

sed -i -r "s/db1/$db_name/1" wp-config.php
sed -i -r "s/user/$db_user/1" wp-config.php
sed -i -r "s/pwd/$db_pwd/1" wp-config.php

wp core install         --url=$DOMAIN_NAME/ --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
wp user create          $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root

#TODO not necessary
wp theme install astra  --activate --allow-root
wp plugin install redis-cache --activate --allow-root
wp plugin update --all --allow-root

sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf

mkdir /run/php
#wp plugin install redis-cache --activate --allow-root
wp redis enable --allow-root
/usr/sbin/php-fpm7.3 -F

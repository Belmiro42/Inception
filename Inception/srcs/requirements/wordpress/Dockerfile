FROM    debian:bullseye

ENV     DEBIAN_FRONTEND=noninteractive

COPY    ./tools/wordpress.sh    /
COPY    ./conf/wp-config.php    /

CMD     ["/wordpress.sh"]
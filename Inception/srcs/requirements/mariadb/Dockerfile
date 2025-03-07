FROM    alpine:3.20

COPY    ./tools/mariadb.sh      /
COPY    ./conf/my.cnf           /etc/mysql/mariadb.conf.d/

CMD     ["/mariadb.sh"]


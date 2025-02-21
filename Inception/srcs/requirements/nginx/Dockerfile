FROM    alpine:3.20

COPY    ./tools/nginx.sh    /
COPY    ./conf/nginx.conf   /

RUN     chmod 777           /nginx.sh 

CMD     ["/nginx.sh"]
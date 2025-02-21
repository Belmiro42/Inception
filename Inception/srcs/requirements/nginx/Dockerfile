FROM    alpine:3.20

COPY    ./nginx.sh /
COPY    ./conf/nginx_conf.txt /

RUN     chmod 777 /nginx.sh 

CMD     ["/nginx.sh"]
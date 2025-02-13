FROM    alpine:3.20

RUN     apk update
RUN     apk upgrade
RUN     apk add nginx
RUN     apk add openssl


COPY    ./nginx.sh /

RUN     chmod 777 /nginx.sh 

CMD     ["/nginx.sh"]
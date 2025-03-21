FROM            alpine:3.20

COPY            ./tools/cmd.sh      /
COPY            ./conf/nginx.conf   /

STOPSIGNAL      SIGTERM

CMD             ["/cmd.sh"]
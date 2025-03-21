FROM        alpine:3.20

COPY        ./tools/cmd.sh          /

STOPSIGNAL  SIGTERM

EXPOSE      9000

CMD         ["/cmd.sh"]